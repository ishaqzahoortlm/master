<?php

class ControllerMultisellerMessages extends ControllerMultisellerBase {
	private $error = array();

	public function __construct($registry) {
		parent::__construct($registry);
	}
	
	public function getTableData() {
		
                $this->load->model('extension/thread');
                $this->load->model('sale/customer');
                $this->load->model('catalog/product');
		$results = $this->model_extension_thread->getAllMessage();
               

		$total = count($results);

		$columns = array();
		foreach ($results as $result) {
			// actions
                        $customer_info = $this->model_sale_customer->getCustomer($result['customer_id']);
                        $seller_info = $this->model_sale_customer->getSupplier($result['seller_id']);
                        $product_info = $this->model_catalog_product->getProduct($result['product_id']);
			
                        $msg_date = $this->model_extension_thread->getMsgDate($result['id']);
                
                        
                        
                        
                        
                        $actions = "";
			$actions .= "<a class='btn btn-primary' href='" . $this->url->link('multiseller/messages/view', 'token=' . $this->session->data['token'] . '&id=' . $result['id'], 'SSL') . "' title='".$this->language->get('button_edit')."'><i class='fa fa-search'></i></a> &nbsp";
			
			
			
			$columns[] = array_merge(
				$result,
				array(
					'by' => $customer_info['firstname'].' '.$customer_info['lastname'],
					'to'  => $seller_info['company'],
					'product' => $product_info['name'],
                                        'date' => date('M d, Y h:i A',strtotime($msg_date)),
                                        'actions' => $actions
				)
			);
		}

		$this->response->setOutput(json_encode(array(
			'iTotalRecords' => $total,
			'iTotalDisplayRecords' => $total,
			'aaData' => $columns
		)));
	}
	
	// List all the seller groups
	public function index() {
		$this->validate(__FUNCTION__);
		
		$this->data['breadcrumbs'] = $this->MsLoader->MsHelper->admSetBreadcrumbs(array(
			array(
				'text' => $this->language->get('ms_menu_multiseller'),
				'href' => $this->url->link('multiseller/dashboard', '', 'SSL'),
			),
			array(
				'text' => 'Messages',
				'href' => '',
			)
		));
		
                
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		$this->data['token'] = $this->session->data['token'];
		$this->data['heading'] = 'Messages';
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		
		$this->document->setTitle('Messages');
		
		$this->data['column_left'] = $this->load->controller('common/column_left');
		$this->data['footer'] = $this->load->controller('common/footer');
		$this->data['header'] = $this->load->controller('common/header');
		$this->response->setOutput($this->load->view('multiseller/messages.tpl', $this->data));
	}
	
	
	// Update a seller group
	public function view() {
		$this->validate(__FUNCTION__);
		$this->load->model('tool/image');
		$this->data['token'] = $this->session->data['token'];
		$this->data['heading'] = 'Message';
		$this->document->setTitle('Message');
		
		
		$this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();		
		
		
		
		
		$this->data['breadcrumbs'] = $this->MsLoader->MsHelper->admSetBreadcrumbs(array(
			array(
				'text' => $this->language->get('ms_menu_multiseller'),
				'href' => $this->url->link('multiseller/dashboard', '', 'SSL'),
			),
			array(
				'text' => 'Message',
				'href' => '',
			)
		));
                
                $this->load->model('extension/thread');
                $this->load->model('sale/customer');
               
                $rs_message = $this->model_extension_thread->getMessageById($this->request->get['id']);
                
                $this->data['all_message'] = array();

                $this->data['all_message'] = $this->model_extension_thread->getAllComments($rs_message['id'],'seller');
              
                $this->data['seller_info']= $this->model_sale_customer->getSupplier($rs_message['seller_id']);
                $this->data['customer_info'] = $this->model_sale_customer->getCustomer($rs_message['customer_id']);
                
		
		$this->data['column_left'] = $this->load->controller('common/column_left');
		$this->data['footer'] = $this->load->controller('common/footer');
		$this->data['header'] = $this->load->controller('common/header');
		$this->response->setOutput($this->load->view('multiseller/viewmessage.tpl', $this->data));
	}
	
}
?>
