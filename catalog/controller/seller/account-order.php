<?php

class ControllerSellerAccountOrder extends ControllerSellerAccount {
	public function getTableData() {
		$colMap = array(
			'customer_name' => 'firstname',
			'date_created' => 'o.date_added',
		);
		
		$sorts = array('order_id', 'customer_name', 'date_created', 'total_amount');
		$filters = array_merge($sorts, array('products'));
		
		list($sortCol, $sortDir) = $this->MsLoader->MsHelper->getSortParams($sorts, $colMap);
		$filterParams = $this->MsLoader->MsHelper->getFilterParams($filters, $colMap);
		
		$seller_id = $this->customer->getId();
		$this->load->model('account/order');

		$orders = $this->MsLoader->MsOrderData->getOrders(
			array(
				'seller_id' => $seller_id,
				'order_status' => $this->config->get('msconf_display_order_statuses')
			),
			array(
				'order_by'  => $sortCol,
				'order_way' => $sortDir,
				'offset' => $this->request->get['iDisplayStart'],
				'limit' => $this->request->get['iDisplayLength'],
				'filters' => $filterParams
			),
			array(
				'total_amount' => 1,
				'products' => 1,
			)
		);
                
                    
		$total_orders = isset($orders[0]) ? $orders[0]['total_rows'] : 0;

		$columns = array();
		foreach ($orders as $order) {
			$order_products = $this->MsLoader->MsOrderData->getOrderProducts(array('order_id' => $order['order_id'], 'seller_id' => $seller_id));
			
			if ($this->config->get('msconf_hide_customer_email')) {
				$customer_name = "{$order['firstname']} {$order['lastname']}";
			} else {
				$customer_name = "{$order['firstname']} {$order['lastname']} ({$order['email']})";
			}
			
			$products = "";
			foreach ($order_products as $p) {
                $products .= "<p style='text-align:left'>";
				$products .= "<span class='name'>" . ($p['quantity'] > 1 ? "{$p['quantity']} x " : "") . "<a href='" . $this->url->link('product/product', 'product_id=' . $p['product_id'], 'SSL') . "'>{$p['name']}</a></span>";

                $options   = $this->model_account_order->getOrderOptions($order['order_id'], $p['order_product_id']);
                $order_array = $this->model_account_order->getOrderDetail($order['order_id']);
                
                foreach ($options as $option)
                {
                    if ($option['type'] != 'file') {
                        $value = $option['value'];
                    } else {
                        $value = utf8_substr($option['value'], 0, utf8_strrpos($option['value'], '.'));
                    }

                    $option['value']	=  utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value;

                    $products .= "<br />";
                    $products .= "<small> - {$option['name']} : {$option['value']} </small>";
                }

                $products .= "<span class='total'>" . $this->currency->format($p['seller_net_amt'], $this->config->get('config_currency')) . "</span>";
				$products .= "</p>";
			}
			
			$this->load->model('localisation/order_status');
			$order_statuses = $this->model_localisation_order_status->getOrderStatuses();
			$order_status_id = $this->model_localisation_order_status->getSuborderStatusId($order['order_id'], $this->customer->getId());

			$order_status_name = '';
			foreach ($order_statuses as $order_status) {
				if ($order_status['order_status_id'] == $order_status_id) {
					$order_status_name = ($order_status_id==5)?'<span class="label label-success">'.$order_status['name'].'</span>':'<span class="label label-info">'.$order_status['name'].'</span>';
				}
			}
                        
                        $review_html = '';
                        if($order_status_id==5 && $order_array['review_status']==0){
                            $review_html = '&nbsp;<a href="' . $this->url->link('seller/account-order/review', 'order_id=' . md5($order['order_id'])) . '" class="btn-sm btn-primary custom_pading_btn" title="' . $this->language->get('ms_write_review') . '"><i class="fa fa-pencil"></i></a>';
                        }
                        
			
			$columns[] = array_merge(
				$order,
				array(
					'order_id' => $order['order_id'],
					'customer_name' => '<a target="_blank" href="' . $this->url->link('seller/account-order/viewdetail', 'id=' . md5($order['customer_id'])) . '">'.$customer_name.'</a>',
					'products' => $products,
					'date_created' => date($this->language->get('date_format_short'), strtotime($order['date_added'])),
					'total_amount' => $this->currency->format($order['total_amount'], $this->config->get('config_currency')),
					'suborder_status' => $order_status_name,
                                        'view_order' => '<a href="' . $this->url->link('seller/account-order/viewOrder', 'order_id=' . $order['order_id']) . '" class="btn-sm btn-default" title="' . $this->language->get('ms_view_modify') . '"><i class="fa fa-search"></i></a>'.$review_html
				)
			);
		}
		
		$this->response->setOutput(json_encode(array(
			'iTotalRecords' => $total_orders,
			'iTotalDisplayRecords' => $total_orders,
			'aaData' => $columns
		)));
	}
        public function review(){
            if (isset($this->request->get['order_id'])) {
			$order_id = $this->request->get['order_id'];
		} else {
			$order_id = 0;
		}
                
            $this->load->model('account/order');
            $order_detail = $this->model_account_order->getOrderDetailEnc($order_id);
            if(empty($order_detail)){
                $this->response->redirect($this->url->link('seller/account-order', '', 'SSL'));
            }else if ($order_detail['review_status']==1){
                $this->response->redirect($this->url->link('seller/account-order', '', 'SSL'));
            }
            $this->document->setTitle($this->language->get('ms_account_order_information'));
            
            $this->data['customer_id'] = $order_detail['customer_id'];
            $this->data['order_id'] = $order_detail['order_id'];
            
            $this->data['breadcrumbs'] = $this->MsLoader->MsHelper->setBreadcrumbs(array(
			
			array(
				'text' => $this->language->get('ms_account_dashboard_breadcrumbs'),
				'href' => $this->url->link('seller/account-dashboard', '', 'SSL'),
			),			
			array(
				'text' => $this->language->get('ms_account_orders_breadcrumbs'),
				'href' => $this->url->link('seller/account-order', '', 'SSL'),
			)
		));
            $this->data['link_to_dashboard'] = $this->url->link('seller/account-dashboard', '', 'SSL');
            list($template, $children) = $this->MsLoader->MsHelper->loadTemplate('revieworder');
	    $this->response->setOutput($this->load->view($template, array_merge($this->data, $children)));
                
        }
        public function savereview(){
            $this->load->language('product/quote');

        $json = array();
        $json['error'] = '';
        $flg = 0;
        if (trim($this->request->post['review']) == "") {
            $json['required']['review'] = '1';
            $flg = $flg + 1;
        }
        
        if ($flg == 0) {
            $json['status'] = 'success';
            $this->load->model('account/supplier');
            $this->model_account_supplier->addBuyerReview($this->request->post);
        } else {
            $json['status'] = 'error';
            $json['error'] = $this->language->get('error_required');
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
            
        }
	public function viewOrder() {
		if (isset($this->request->get['order_id'])) {
			$order_id = $this->request->get['order_id'];
		} else {
			$order_id = 0;
		}

		$this->data['redirect'] = $this->url->link('seller/account-order/viewOrder', 'order_id=' . $order_id, 'SSL');
		if (!$this->customer->isLogged()) {
			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}

		$this->data['breadcrumbs'] = $this->MsLoader->MsHelper->setBreadcrumbs(array(
			
			array(
				'text' => $this->language->get('ms_account_dashboard_breadcrumbs'),
				'href' => $this->url->link('seller/account-dashboard', '', 'SSL'),
			),
			array(
				'text' => $this->language->get('ms_account_orders_breadcrumbs'),
				'href' => $this->url->link('seller/account-order', '', 'SSL'),
			)
		));
		$this->data['link_to_dashboard'] = $this->url->link('seller/account-dashboard', '', 'SSL');
		$this->load->model('localisation/order_status');
		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();
		$this->data['order_status_id'] = $this->model_localisation_order_status->getSuborderStatusId($order_id, $this->customer->getId());
		$suborder_id = $this->model_localisation_order_status->getSuborderId($order_id);

		if (isset($this->request->post['order_status_edit'])) {
			$this->model_localisation_order_status->editSuborderStatus($suborder_id, $this->request->post['order_status_edit']);
			$this->data['success'] = $this->language->get('ms_account_orders_status_update');
                        //$this->response->redirect($this->data['redirect']);
                }

		$this->load->model('account/order');

		$order_info = $this->model_account_order->getOrder($order_id, 'seller');

		$this->data['products'] = array();
		$products = $this->MsLoader->MsOrderData->getOrderProducts(array( 'order_id' => $order_id, 'seller_id' => $this->customer->getId() ));

		if ($order_info && !empty($products)) {
			$this->document->setTitle($this->language->get('text_order'));

			$this->data = array_merge($this->data, $this->load->language('account/order'));

			if ($order_info['invoice_no']) {
				$this->data['invoice_no'] = $order_info['invoice_prefix'] . $order_info['invoice_no'];
			} else {
				$this->data['invoice_no'] = '';
			}

			$this->data['order_id'] = $this->request->get['order_id'];
			$this->data['date_added'] = date($this->language->get('date_format_short'), strtotime($order_info['date_added']));

			$types = array("payment", "shipping");

			foreach ($types as $key => $type) {
				if ($order_info[$type . '_address_format']) {
					$format = $order_info[$type . '_address_format'];
				} else {
					$format = '{firstname} {lastname}' . "\n" . '{company}' . "\n" . '{address_1}' . "\n" . '{address_2}' . "\n" . '{city} {postcode}' . "\n" . '{zone}' . "\n" . '{country}' . "\n" . '{telephone}';
				}

				$find = array(
					'{firstname}',
					'{lastname}',
					'{company}',
					'{address_1}',
					'{address_2}',
					'{city}',
					'{postcode}',
					'{zone}',
					'{zone_code}',
					'{country}',
					'{telephone}'
				);

				$replace = array(
					'firstname' => $order_info[$type . '_firstname'],
					'lastname'  => $order_info[$type . '_lastname'],
					'company'   => $order_info[$type . '_company'],
					'address_1' => $order_info[$type . '_address_1'],
					'address_2' => $order_info[$type . '_address_2'],
					'city'      => $order_info[$type . '_city'],
					'postcode'  => $order_info[$type . '_postcode'],
					'zone'      => $order_info[$type . '_zone'],
					'zone_code' => $order_info[$type . '_zone_code'],
					'country'   => $order_info[$type . '_country'],
					'telephone'   => $order_info['telephone']
				);

				$this->data[$type . '_address'] = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));

				$this->data[$type . '_method'] = $order_info[$type . '_method'];
			}

			foreach ($products as $product) {

				$this->data['products'][] = array(
					'product_id' => $product['product_id'],
					'name'     => $product['name'],
					'model'    => $product['model'],
					'quantity' => $product['quantity'],
					'price'    => $this->currency->format($product['price'] + ($this->config->get('config_tax') ? $product['tax'] : 0), $order_info['currency_code'], $order_info['currency_value']),
					'total'    => $this->currency->format($product['total'] + ($this->config->get('config_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value']),
					'return'   => $this->url->link('account/return/insert', 'order_id=' . $order_info['order_id'] . '&product_id=' . $product['product_id'], 'SSL')
				);
			}

			$subordertotal = $this->currency->format($this->MsLoader->MsOrderData->getOrderTotal($order_id, array('seller_id' => $this->customer->getId() )));
			//$this->data['totals'] = $this->model_account_order->getOrderTotals($this->request->get['order_id']);
			$this->data['totals'][0] = array('text' => $subordertotal, 'title' => 'Total');
			$this->data['link_back'] = $this->url->link('seller/account-order', '', 'SSL');
			$this->data['continue'] = $this->url->link('account/order', '', 'SSL');

			list($template, $children) = $this->MsLoader->MsHelper->loadTemplate('account-order-info');
			$this->response->setOutput($this->load->view($template, array_merge($this->data, $children)));

		} else {
			$this->response->redirect($this->url->link('seller/account-order-info', '', 'SSL'));
		}
	}
        
        public function viewdetail(){
                if (isset($this->request->get['id'])) {
			$id = $this->request->get['id'];
		} else {
			$id = 0;
		}

		if (!$this->customer->isLogged()) {
			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}
                $this->data['link_to_dashboard'] = $this->url->link('seller/account-dashboard', '', 'SSL');
                $this->load->model('account/supplier');

		$customer_info = $this->model_account_supplier->getCustomerEnc($id);
                if(empty($customer_info)){
                    $this->response->redirect($this->url->link('seller/account-order', '', 'SSL'));
                }
                $this->document->setTitle($customer_info['firstname'].' '.$customer_info['lastname']);

                $this->data['customer_info'] = $customer_info;
                
                $customer_reviews = $this->model_account_supplier->getBuyerReview($customer_info['customer_id']);
                $all_reviews_array = array();
                if(!empty($customer_reviews)){
                    foreach ($customer_reviews as $row) {
                        $supplier_info = $this->model_account_supplier->getDetail($row['seller_id']);
                        $all_reviews_array[] = array(
                            'text' => $row['text'],
                            'date_added' => $row['date_added'],
                            'rating' => $row['rating'],
                            'seller_company' => $supplier_info['company'],
                            'seller_href' => $this->url->link('seller/catalog-seller/profile', '&seller_id=' . $row['seller_id'])
                        );
                    }
                }
                $this->data['all_reviews'] = $all_reviews_array;
		$this->data['breadcrumbs'] = $this->MsLoader->MsHelper->setBreadcrumbs(array(
			
			array(
				'text' => $this->language->get('ms_account_dashboard_breadcrumbs'),
				'href' => $this->url->link('seller/account-dashboard', '', 'SSL'),
			),
			array(
				'text' => $this->language->get('ms_account_orders_breadcrumbs'),
				'href' => $this->url->link('seller/account-order', '', 'SSL'),
			)
		));
                
                list($template, $children) = $this->MsLoader->MsHelper->loadTemplate('buyer-detail');
		$this->response->setOutput($this->load->view($template, array_merge($this->data, $children)));
                
        }
		
	public function index() {
		$this->data['link_back'] = $this->url->link('account/account', '', 'SSL');
		$this->data['link_to_dashboard'] = $this->url->link('seller/account-dashboard', '', 'SSL');
		$this->document->setTitle($this->language->get('ms_account_order_information'));
		
		$this->data['breadcrumbs'] = $this->MsLoader->MsHelper->setBreadcrumbs(array(
			
			array(
				'text' => $this->language->get('ms_account_dashboard_breadcrumbs'),
				'href' => $this->url->link('seller/account-dashboard', '', 'SSL'),
			),			
			array(
				'text' => $this->language->get('ms_account_orders_breadcrumbs'),
				'href' => $this->url->link('seller/account-order', '', 'SSL'),
			)
		));
		
		list($template, $children) = $this->MsLoader->MsHelper->loadTemplate('account-order');
		$this->response->setOutput($this->load->view($template, array_merge($this->data, $children)));
	}
}

?>
