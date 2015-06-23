<?php

class ControllerProductProduct extends Controller {

    private $error = array();

    public function index() {
        $this->load->language('product/product');

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        $this->load->model('catalog/category');

        if (isset($this->request->get['path'])) {
            $path = '';

            $parts = explode('_', (string) $this->request->get['path']);

            $category_id = (int) array_pop($parts);

            foreach ($parts as $path_id) {
                if (!$path) {
                    $path = $path_id;
                } else {
                    $path .= '_' . $path_id;
                }

                $category_info = $this->model_catalog_category->getCategory($path_id);

                if ($category_info) {
                    $data['breadcrumbs'][] = array(
                        'text' => $category_info['name'],
                        'href' => $this->url->link('product/category', 'path=' . $path)
                    );
                }
            }

            // Set the last category breadcrumb
            $category_info = $this->model_catalog_category->getCategory($category_id);

            if ($category_info) {
                $url = '';

                if (isset($this->request->get['sort'])) {
                    $url .= '&sort=' . $this->request->get['sort'];
                }

                if (isset($this->request->get['order'])) {
                    $url .= '&order=' . $this->request->get['order'];
                }

                if (isset($this->request->get['page'])) {
                    $url .= '&page=' . $this->request->get['page'];
                }

                if (isset($this->request->get['limit'])) {
                    $url .= '&limit=' . $this->request->get['limit'];
                }

                $data['breadcrumbs'][] = array(
                    'text' => $category_info['name'],
                    'href' => $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url)
                );
            }
        }

        $this->load->model('catalog/manufacturer');

        if (isset($this->request->get['manufacturer_id'])) {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_brand'),
                'href' => $this->url->link('product/manufacturer')
            );

            $url = '';

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($this->request->get['manufacturer_id']);

            if ($manufacturer_info) {
                $data['breadcrumbs'][] = array(
                    'text' => $manufacturer_info['name'],
                    'href' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $this->request->get['manufacturer_id'] . $url)
                );
            }
        }

        if (isset($this->request->get['search']) || isset($this->request->get['tag'])) {
            $url = '';

            if (isset($this->request->get['search'])) {
                $url .= '&search=' . $this->request->get['search'];
            }

            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . $this->request->get['tag'];
            }

            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }

            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }

            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_search'),
                'href' => $this->url->link('product/search', $url)
            );
        }

        if (isset($this->request->get['product_id'])) {
            $product_id = (int) $this->request->get['product_id'];
        } else {
            $product_id = 0;
        }

        $this->load->model('catalog/product');

        $product_info = $this->model_catalog_product->getProduct($product_id);
        
        $seller_info = $this->model_catalog_product->getProductSeller($product_id);
        $data['seller_id'] = $seller_info;
        $this->load->model('catalog/faqs');
        $data['seller_faqs'] = $this->model_catalog_faqs->getAllFaqs($seller_info);
        
        if ($product_info) {
            $url = '';

            if (isset($this->request->get['path'])) {
                $url .= '&path=' . $this->request->get['path'];
            }

            if (isset($this->request->get['filter'])) {
                $url .= '&filter=' . $this->request->get['filter'];
            }

            if (isset($this->request->get['manufacturer_id'])) {
                $url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
            }

            if (isset($this->request->get['search'])) {
                $url .= '&search=' . $this->request->get['search'];
            }

            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . $this->request->get['tag'];
            }

            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }

            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }

            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $data['breadcrumbs'][] = array(
                'text' => $product_info['name'],
                'href' => $this->url->link('product/product', $url . '&product_id=' . $this->request->get['product_id'])
            );

            $this->document->setTitle($product_info['meta_title']);
            $this->document->setDescription($product_info['meta_description']);
            $this->document->setKeywords($product_info['meta_keyword']);
            $this->document->addLink($this->url->link('product/product', 'product_id=' . $this->request->get['product_id']), 'canonical');
            $this->document->addScript('catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js');
            $this->document->addStyle('catalog/view/javascript/jquery/magnific/magnific-popup.css');
            $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/moment.js');
            $this->document->addScript('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js');
            $this->document->addStyle('catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css');

            $data['heading_title'] = $product_info['name'];

            $data['text_select'] = $this->language->get('text_select');
            $data['text_manufacturer'] = $this->language->get('text_manufacturer');
            $data['text_model'] = $this->language->get('text_model');
            $data['text_reward'] = $this->language->get('text_reward');
            $data['text_points'] = $this->language->get('text_points');
            $data['text_stock'] = $this->language->get('text_stock');
            $data['text_discount'] = $this->language->get('text_discount');
            $data['text_tax'] = $this->language->get('text_tax');
            $data['text_option'] = $this->language->get('text_option');
            $data['text_minimum'] = sprintf($this->language->get('text_minimum'), $product_info['minimum']);
            $data['text_write'] = $this->language->get('text_write');
            $data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));
            $data['text_note'] = $this->language->get('text_note');
            $data['text_tags'] = $this->language->get('text_tags');
            $data['text_related'] = $this->language->get('text_related');
            $data['text_loading'] = $this->language->get('text_loading');
            $data['alert_login'] = $this->language->get('alert_login');

            $data['entry_qty'] = $this->language->get('entry_qty');
            $data['entry_name'] = $this->language->get('entry_name');
            $data['entry_review'] = $this->language->get('entry_review');
            $data['entry_rating'] = $this->language->get('entry_rating');
            $data['entry_good'] = $this->language->get('entry_good');
            $data['entry_bad'] = $this->language->get('entry_bad');
            $data['entry_captcha'] = $this->language->get('entry_captcha');

            $data['button_cart'] = $this->language->get('button_cart');
            $data['button_wishlist'] = $this->language->get('button_wishlist');
            $data['button_compare'] = $this->language->get('button_compare');
            $data['button_upload'] = $this->language->get('button_upload');
            $data['button_continue'] = $this->language->get('button_continue');

            $this->load->model('catalog/review');

            $data['tab_description'] = $this->language->get('tab_description');
            $data['tab_attribute'] = $this->language->get('tab_attribute');
            $data['tab_review'] = sprintf($this->language->get('tab_review'), $product_info['reviews']);
            $data['tab_seller'] = $this->language->get('tab_seller');
            $data['tab_supplier_faq'] = $this->language->get('tab_supplier_faq');
            $data['btn_get_quote'] = $this->language->get('btn_get_quote');
            $data['btn_seller_contact'] = $this->language->get('btn_seller_contact');
            $data['text_certification'] = $this->language->get('text_certification');

            $data['product_id'] = (int) $this->request->get['product_id'];
            $data['manufacturer'] = $product_info['manufacturer'];
            $data['manufacturers'] = $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']);
            $data['model'] = $product_info['model'];
            $data['reward'] = $product_info['reward'];
            $data['points'] = $product_info['points'];

            $data['info_certifications'] = '';
            if ($product_info['certifications'] != "") {
                $res_certification = $this->model_catalog_product->getCertificationDescription($product_info['certifications']);
                $data['info_certifications'] = (isset($res_certification['title']))?$res_certification['title']:'';
            }

            if ($product_info['quantity'] <= 0) {
                $data['stock'] = $product_info['stock_status'];
            } elseif ($this->config->get('config_stock_display')) {
                $data['stock'] = $product_info['quantity'];
            } else {
                $data['stock'] = $this->language->get('text_instock');
            }
            $data['stock'] = $product_info['stock_status'];
            $this->load->model('tool/image');

            if ($product_info['image']) {
                $data['popup'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height'));
            } else {
                $data['popup'] = '';
            }

            if ($product_info['image']) {
                $data['thumb'] = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
            } else {
                $data['thumb'] = '';
            }

            $data['images'] = array();

            $results = $this->model_catalog_product->getProductImages($this->request->get['product_id']);

            foreach ($results as $result) {
                $data['images'][] = array(
                    'popup' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_popup_width'), $this->config->get('config_image_popup_height')),
                    'thumb' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_additional_width'), $this->config->get('config_image_additional_height')),
					'thumb2' => $this->model_tool_image->resize($result['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'))
                );
            }

            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $data['price'] = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $data['price'] = false;
            }
            $data['price_for'] = $product_info['price_for'];
            if ((float) $product_info['special']) {
                $data['special'] = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $data['special'] = false;
            }

            if ($this->config->get('config_tax')) {
                $data['tax'] = $this->currency->format((float) $product_info['special'] ? $product_info['special'] : $product_info['price']);
            } else {
                $data['tax'] = false;
            }

            $discounts = $this->model_catalog_product->getProductDiscounts($this->request->get['product_id']);

            $data['discounts'] = array();

            foreach ($discounts as $discount) {
                $data['discounts'][] = array(
                    'quantity' => $discount['quantity'],
                    'price' => $this->currency->format($this->tax->calculate($discount['price'], $product_info['tax_class_id'], $this->config->get('config_tax')))
                );
            }

            $data['options'] = array();

            foreach ($this->model_catalog_product->getProductOptions($this->request->get['product_id']) as $option) {
                $product_option_value_data = array();

                foreach ($option['product_option_value'] as $option_value) {
                    if (!$option_value['subtract'] || ($option_value['quantity'] > 0)) {
                        if ((($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) && (float) $option_value['price']) {
                            $price = $this->currency->format($this->tax->calculate($option_value['price'], $product_info['tax_class_id'], $this->config->get('config_tax') ? 'P' : false));
                        } else {
                            $price = false;
                        }

                        $product_option_value_data[] = array(
                            'product_option_value_id' => $option_value['product_option_value_id'],
                            'option_value_id' => $option_value['option_value_id'],
                            'name' => $option_value['name'],
                            'image' => $this->model_tool_image->resize($option_value['image'], 50, 50),
                            'price' => $price,
                            'price_prefix' => $option_value['price_prefix']
                        );
                    }
                }

                $data['options'][] = array(
                    'product_option_id' => $option['product_option_id'],
                    'product_option_value' => $product_option_value_data,
                    'option_id' => $option['option_id'],
                    'name' => $option['name'],
                    'type' => $option['type'],
                    'value' => $option['value'],
                    'required' => $option['required']
                );
            }

            if ($product_info['minimum']) {
                $data['minimum'] = $product_info['minimum'];
            } else {
                $data['minimum'] = 1;
            }

            $data['review_status'] = $this->config->get('config_review_status');

            if ($this->config->get('config_review_guest') || $this->customer->isLogged()) {
                $data['review_guest'] = true;
            } else {
                $data['review_guest'] = false;
            }

            if ($this->customer->isLogged()) {
                $data['customer_name'] = $this->customer->getFirstName() . '&nbsp;' . $this->customer->getLastName();
            } else {
                $data['customer_name'] = '';
            }

            $data['reviews'] = sprintf($this->language->get('text_reviews'), (int) $product_info['reviews']);
            $data['rating'] = (int) $product_info['rating'];
            $data['description'] = html_entity_decode($product_info['description'], ENT_QUOTES, 'UTF-8');
            $data['attribute_groups'] = $this->model_catalog_product->getProductAttributes($this->request->get['product_id']);

            $data['products'] = array();

            $results = $this->model_catalog_product->getProductRelated($this->request->get['product_id']);
            
            foreach ($results as $result) {
                $seller_id = $this->MsLoader->MsProduct->getSellerId($result['product_id']);
                $seller = $this->MsLoader->MsSeller->getSeller($seller_id);
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
                } else {
                    $image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_related_width'), $this->config->get('config_image_related_height'));
                }

                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $price = false;
                }

                if ((float) $result['special']) {
                    $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $special = false;
                }

                if ($this->config->get('config_tax')) {
                    $tax = $this->currency->format((float) $result['special'] ? $result['special'] : $result['price']);
                } else {
                    $tax = false;
                }

                if ($this->config->get('config_review_status')) {
                    $rating = (int) $result['rating'];
                } else {
                    $rating = false;
                }

                $data['products'][] = array(
                    'product_id' => $result['product_id'],
					'href' => $this->url->link('product/product', 'product_id=' . $result['product_id']),
                    'thumb' => $image,
                    'name' => $result['name'],
                    'stock_status' => $result['stock_status'],
                    'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
                    'price' => $price,
                    'special' => $special,
                    'tax' => $tax,
                    'rating' => $result['rating'],
                    'manufacturer' => $result['manufacturer'],
                    'manufacturer_id' => $result['manufacturer_id'],
                    'manufacturers' => $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $result['manufacturer_id']),
                    'seller_name' => $seller['name'],
                    'seller_company' => $seller['ms.company'],
                    'seller_href' => $this->url->link('seller/catalog-seller/profile', 'seller_id=' . $seller['seller_id']),

                    );
            }

            $data['tags'] = array();

            if ($product_info['tag']) {
                $tags = explode(',', $product_info['tag']);

                foreach ($tags as $tag) {
                    $data['tags'][] = array(
                        'tag' => trim($tag),
                        'href' => $this->url->link('product/search', 'tag=' . trim($tag))
                    );
                }
            }

            $data['text_payment_recurring'] = $this->language->get('text_payment_recurring');
            $data['recurrings'] = $this->model_catalog_product->getProfiles($this->request->get['product_id']);

            $this->model_catalog_product->updateViewed($this->request->get['product_id']);

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/product.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/product/product.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/product/product.tpl', $data));
            }
        } else {
            $url = '';

            if (isset($this->request->get['path'])) {
                $url .= '&path=' . $this->request->get['path'];
            }

            if (isset($this->request->get['filter'])) {
                $url .= '&filter=' . $this->request->get['filter'];
            }

            if (isset($this->request->get['manufacturer_id'])) {
                $url .= '&manufacturer_id=' . $this->request->get['manufacturer_id'];
            }

            if (isset($this->request->get['search'])) {
                $url .= '&search=' . $this->request->get['search'];
            }

            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . $this->request->get['tag'];
            }

            if (isset($this->request->get['description'])) {
                $url .= '&description=' . $this->request->get['description'];
            }

            if (isset($this->request->get['category_id'])) {
                $url .= '&category_id=' . $this->request->get['category_id'];
            }

            if (isset($this->request->get['sub_category'])) {
                $url .= '&sub_category=' . $this->request->get['sub_category'];
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_error'),
                'href' => $this->url->link('product/product', $url . '&product_id=' . $product_id)
            );

            $this->document->setTitle($this->language->get('text_error'));

            $data['heading_title'] = $this->language->get('text_error');

            $data['text_error'] = $this->language->get('text_error');

            $data['button_continue'] = $this->language->get('button_continue');

            $data['continue'] = $this->url->link('common/home');

            $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $data));
            }
        }
    }

    public function review() {
        $this->load->language('product/product');

        $this->load->model('catalog/review');

        $data['text_no_reviews'] = $this->language->get('text_no_reviews');

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $data['reviews'] = array();

        $review_total = $this->model_catalog_review->getTotalReviewsByProductId($this->request->get['product_id']);

        $results = $this->model_catalog_review->getReviewsByProductId($this->request->get['product_id'], ($page - 1) * 5, 5);

        foreach ($results as $result) {
            $data['reviews'][] = array(
                'author' => $result['author'],
                'text' => nl2br($result['text']),
                'rating' => (int) $result['rating'],
                'date_added' => date($this->language->get('date_format_short'), strtotime($result['date_added']))
            );
        }

        $pagination = new Pagination();
        $pagination->total = $review_total;
        $pagination->page = $page;
        $pagination->limit = 5;
        $pagination->url = $this->url->link('product/product/review', 'product_id=' . $this->request->get['product_id'] . '&page={page}');

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($review_total) ? (($page - 1) * 5) + 1 : 0, ((($page - 1) * 5) > ($review_total - 5)) ? $review_total : ((($page - 1) * 5) + 5), $review_total, ceil($review_total / 5));

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/review.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/product/review.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/product/review.tpl', $data));
        }
    }

    public function getRecurringDescription() {
        $this->language->load('product/product');
        $this->load->model('catalog/product');

        if (isset($this->request->post['product_id'])) {
            $product_id = $this->request->post['product_id'];
        } else {
            $product_id = 0;
        }

        if (isset($this->request->post['recurring_id'])) {
            $recurring_id = $this->request->post['recurring_id'];
        } else {
            $recurring_id = 0;
        }

        if (isset($this->request->post['quantity'])) {
            $quantity = $this->request->post['quantity'];
        } else {
            $quantity = 1;
        }

        $product_info = $this->model_catalog_product->getProduct($product_id);
        $recurring_info = $this->model_catalog_product->getProfile($product_id, $recurring_id);

        $json = array();

        if ($product_info && $recurring_info) {
            if (!$json) {
                $frequencies = array(
                    'day' => $this->language->get('text_day'),
                    'week' => $this->language->get('text_week'),
                    'semi_month' => $this->language->get('text_semi_month'),
                    'month' => $this->language->get('text_month'),
                    'year' => $this->language->get('text_year'),
                );

                if ($recurring_info['trial_status'] == 1) {
                    $price = $this->currency->format($this->tax->calculate($recurring_info['trial_price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')));
                    $trial_text = sprintf($this->language->get('text_trial_description'), $price, $recurring_info['trial_cycle'], $frequencies[$recurring_info['trial_frequency']], $recurring_info['trial_duration']) . ' ';
                } else {
                    $trial_text = '';
                }

                $price = $this->currency->format($this->tax->calculate($recurring_info['price'] * $quantity, $product_info['tax_class_id'], $this->config->get('config_tax')));

                if ($recurring_info['duration']) {
                    $text = $trial_text . sprintf($this->language->get('text_payment_description'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
                } else {
                    $text = $trial_text . sprintf($this->language->get('text_payment_cancel'), $price, $recurring_info['cycle'], $frequencies[$recurring_info['frequency']], $recurring_info['duration']);
                }

                $json['success'] = $text;
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function write() {
        $this->load->language('product/product');

        $json = array();

        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
                $json['error'] = $this->language->get('error_name');
            }

            if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
                $json['error'] = $this->language->get('error_text');
            }

            if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
                $json['error'] = $this->language->get('error_rating');
            }

            if (empty($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post['captcha'])) {
                $json['error'] = $this->language->get('error_captcha');
            }

            unset($this->session->data['captcha']);

            if (!isset($json['error'])) {
                $this->load->model('catalog/review');

                $this->model_catalog_review->addReview($this->request->get['product_id'], $this->request->post);

                $json['success'] = $this->language->get('text_success');
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function Quote() {
        if (!$this->customer->getId()) {
            $this->response->redirect($this->url->link('account/login', '', 'SSL'));
            exit;
        }
        $this->load->language('product/quote');

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('common/home')
        );
        $data['heading_title'] = $this->language->get('heading_title');
        $data['heading_buyer'] = $this->language->get('heading_buyer');
        $data['heading_product'] = $this->language->get('heading_product');
        $data['entry_company'] = $this->language->get('entry_company');
        $data['entry_name'] = $this->language->get('entry_name');
        $data['entry_email'] = $this->language->get('entry_email');
        $data['entry_phone'] = $this->language->get('entry_phone');
        $data['entry_country'] = $this->language->get('entry_country');
        $data['entry_state'] = $this->language->get('entry_state');
        $data['entry_city'] = $this->language->get('entry_city');
        $data['entry_address'] = $this->language->get('entry_address');
        $data['btn_submit'] = $this->language->get('btn_submit');
        $data['entry_select'] = $this->language->get('entry_select');
        $data['entry_product_detail'] = $this->language->get('entry_product_detail');
        $data['entry_qty'] = $this->language->get('entry_qty');
        $data['entry_additional_detail'] = $this->language->get('entry_additional_detail');
        $data['entry_other'] = $this->language->get('entry_other');
        $data['entry_reference'] = $this->language->get('entry_reference');
        $data['entry_currency'] = $this->language->get('entry_currency');
        $data['entry_unit'] = $this->language->get('entry_unit');
        $data['heading_title_multiple'] = $this->language->get('heading_title_multiple');
        $data['text_category'] = $this->language->get('text_category');
        $data['text_manufacturers'] = $this->language->get('text_manufacturers');
        $data['text_q_popup'] = $this->language->get('text_q_popup');
        
        $data['heading_shipping'] = $this->language->get('heading_shipping');
        $data['heading_shipping_sub'] = $this->language->get('heading_shipping_sub');
        $data['text_destination'] = $this->language->get('text_destination');
        $data['text_payment_terms'] = $this->language->get('text_payment_terms');
        $data['text_shipping_method'] = $this->language->get('text_shipping_method');
        
        $data['text_required_shipping'] = $this->language->get('text_required_shipping');
        
        $data['heading_shipping_subheading'] = $this->language->get('heading_shipping_subheading');
        $data['text_origin'] = $this->language->get('text_origin');
        $data['text_lead_time'] = $this->language->get('text_lead_time');
        $data['text_transit_time'] = $this->language->get('text_transit_time');
        $data['text_dispatch'] = $this->language->get('text_dispatch');
        $data['text_port_name'] = $this->language->get('text_port_name');
        $data['text_gp_container'] = $this->language->get('text_gp_container');
        $data['text_up_inco_terms'] = $this->language->get('text_up_inco_terms');
        
        
        $this->document->setTitle($this->language->get('heading_title'));
        $this->document->setDescription($this->language->get('heading_title'));
        $this->document->setKeywords($this->language->get('heading_title'));

        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        /* -------------------------------------------------------------------- */
        $res_customer_detail = $res_address = array();
        if ($this->customer->getId()) {
            $this->load->model('account/customer');
            $this->load->model('account/address');

            $res_customer_detail = $this->model_account_customer->getCustomer($this->customer->getId());
            $res_address = $this->model_account_address->getAddress($res_customer_detail['address_id']);
        }

        $this->load->model('localisation/country');
        $data['countries'] = $this->model_localisation_country->getCountries();
        
        $this->load->model('localisation/currency');
        $data['currency'] = $this->model_localisation_currency->getCurrencies();
        
        $this->load->model('localisation/weight_class');
        $data['weight_classes'] = $this->model_localisation_weight_class->getWeightClasses();



        $data['buyer_company'] = (!empty($res_address)) ? $res_address['company'] : '';
        $data['buyer_name'] = (!empty($res_customer_detail)) ? $res_customer_detail['firstname'] . ' ' . $res_customer_detail['lastname'] : '';
        $data['buyer_email'] = (!empty($res_customer_detail)) ? $res_customer_detail['email'] : '';
        $data['buyer_phone'] = (!empty($res_customer_detail)) ? $res_customer_detail['telephone'] : '';

        $data['buyer_country'] = (!empty($res_address)) ? $res_address['country_id'] : '';
        $data['zone_id'] = (!empty($res_address)) ? $res_address['zone_id'] : '';
        $data['buyer_city'] = (!empty($res_address)) ? $res_address['city'] : '';
        $data['buyer_address'] = (!empty($res_address)) ? $res_address['address_1'] . ' ' . $res_address['address_2'] : '';
        $data['buyer_id'] = ($this->customer->getId()) ? $this->customer->getId() : '';

        /* -------------------------------------------------------------------- */

        if (isset($this->request->get['product_id'])) {
            $data['product_id'] = $this->request->get['product_id'];
            $this->load->model('catalog/product');
            $product_info = $this->model_catalog_product->getProduct($this->request->get['product_id']);
            $seller_info = $this->model_catalog_product->getProductSeller($this->request->get['product_id']);
            $data['seller_id'] = $seller_info;
            $data['product_name'] = $product_info['name'];
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/quote.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/product/quote.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/product/quote.tpl', $data));
            }
        } else {
            
            $this->load->model('catalog/category');
            $data['categories'] = $this->model_catalog_category->getCategories(0);
            
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/product/quote_multiple.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/product/quote_multiple.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/product/quote_multiple.tpl', $data));
            }
        }
    }
    
    public function getproducts(){
        $this->load->model('catalog/product');
        $this->load->model('catalog/quote');
        $this->load->language('product/quote');
        $entry_select = $this->language->get('entry_select');
        $array_products =  array(0);
        $filter_data = array(
                'filter_category_id' => $this->request->post['category_id']
            );
        
        $results = $this->model_catalog_product->getProducts($filter_data);
        
        $html_products = $html_manufacturer = '';
        
        $html_products = '<select name="product_name" id="product_name" class="form-control" onchange="set_product_id(this.value)">
                            <option value="">'.$entry_select.'</option>';
        foreach ($results as $row) {
            $array_products[] = $row['product_id'];
            $html_products .= '<option value="'.$row['product_id'].'">'.$row['name'].'</option>';
        }
        $html_products .= '</select>';
        
        
        $sellers = $this->model_catalog_quote->getProductSellers($array_products);
        
        
        $html_manufacturer = '<select name="manufacturer[]" id="manufacturer" multiple class="form-control" >
                                ';
        if(!empty($sellers)) {
            foreach ($sellers as $seller) {
                $html_manufacturer .= '<option value="'.$seller['seller_id'].'">'.$seller['company'].'</option>';
            }
        }
        $html_manufacturer .= "</select>
                    <script>
                    $(document).ready(function() {
                     $('select[multiple]').bsmSelect({
        
                        highlight: 'highlight',
                        addItemTarget: 'original',
                        removeLabel: '<strong>X</strong>',
                        containerClass: 'bsmContainer',                // Class for container that wraps this widget
                        listClass: 'bsmList-custom',                   // Class for the list ()
                        listItemClass: 'bsmListItem-custom',           // Class for the <li> list items
                        listItemLabelClass: 'bsmListItemLabel-custom', // Class for the label text that appears in list items
                        removeClass: 'bsmListItemRemove-custom'
                      });
                    }); </script>";
        
        $json['status'] = 'success';
        $json['products'] = $html_products;
        $json['manufacturer'] = $html_manufacturer;
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    public function addquote() {
        $this->load->language('product/quote');

        $json = array();
        $json['error'] = '';
        $flg = 0;
        if (trim($this->request->post['buyer_company']) == "") {
            $json['required']['buyer_company'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_name']) == "") {
            $json['required']['buyer_name'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_email']) == "") {
            $json['required']['buyer_email'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_email']) != "") {
            $expression = "/^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.([a-zA-Z]{2,4})$/";
            if (!preg_match($expression, $this->request->post['buyer_email'])) {
                $json['required']['buyer_email'] = '1';
                $flg = $flg + 1;
            }
        }
        if (trim($this->request->post['buyer_phone']) == "") {
            $json['required']['buyer_phone'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_country']) == "") {
            $json['required']['buyer_country'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['zone_id']) == "") {
            $json['required']['input-zone'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_city']) == "") {
            $json['required']['buyer_city'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_address']) == "") {
            $json['required']['buyer_address'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['product_name']) == "") {
            $json['required']['product_name'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['product_detail']) == "") {
            $json['required']['product_detail'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['quantity']) == "") {
            $json['required']['quantity'] = '1';
            $flg = $flg + 1;
        }
        
        if (trim($this->request->post['buyer_destination']) == "") {
            $json['required']['buyer_destination'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_payment_terms']) == "") {
            $json['required']['buyer_payment_terms'] = '1';
            $flg = $flg + 1;
        }
        if (empty($this->request->post['buyer_shipping_method'])) {
            $json['required']['buyer_shipping_method'] = '1';
            $flg = $flg + 1;
        }
        
        if ($flg == 0) {
            $json['status'] = 'success';
            $this->load->model('catalog/quote');
            $q_id = $this->model_catalog_quote->add($this->request->post);

            /* ---------------------------------------------------------------- */

            $this->load->language('product/quote');

            $data['heading_title'] = $this->language->get('heading_title');
            $data['heading_buyer'] = $this->language->get('heading_buyer');
            $data['heading_product'] = $this->language->get('heading_product');
            $data['entry_company'] = $this->language->get('entry_company');
            $data['entry_name'] = $this->language->get('entry_name');
            $data['entry_email'] = $this->language->get('entry_email');
            $data['entry_phone'] = $this->language->get('entry_phone');
            $data['entry_country'] = $this->language->get('entry_country');
            $data['entry_state'] = $this->language->get('entry_state');
            $data['entry_city'] = $this->language->get('entry_city');
            $data['entry_address'] = $this->language->get('entry_address');
            $data['btn_submit'] = $this->language->get('btn_submit');
            $data['entry_select'] = $this->language->get('entry_select');
            $data['entry_product_detail'] = $this->language->get('entry_product_detail');
            $data['entry_qty'] = $this->language->get('entry_qty');
            $data['entry_price'] = $this->language->get('entry_price');
            $data['entry_additional_detail'] = $this->language->get('entry_additional_detail');
            $data['entry_other'] = $this->language->get('entry_other');
            $data['entry_reference'] = $this->language->get('entry_reference');
            $data['entry_id'] = $this->language->get('entry_id');
            $data['entry_date'] = $this->language->get('entry_date');
            $data['entry_currency'] = $this->language->get('entry_currency');
            $data['entry_unit'] = $this->language->get('entry_unit');
            $data['entry_status'] = $this->language->get('entry_status');
            $data['entry_date_responded'] = $this->language->get('entry_date_responded');
            $data['entry_billing'] = $this->language->get('entry_billing');
            $data['heading_shipping'] = $this->language->get('heading_shipping');
            $data['heading_shipping_sub'] = $this->language->get('heading_shipping_sub');
            $data['text_destination'] = $this->language->get('text_destination');
            $data['text_payment_terms'] = $this->language->get('text_payment_terms');
            $data['text_shipping_method'] = $this->language->get('text_shipping_method');
            
            $data['heading_shipping_subheading'] = $this->language->get('heading_shipping_subheading');
            $data['text_origin'] = $this->language->get('text_origin');
            $data['text_lead_time'] = $this->language->get('text_lead_time');
            $data['text_transit_time'] = $this->language->get('text_transit_time');
            $data['text_dispatch'] = $this->language->get('text_dispatch');
            $data['text_port_name'] = $this->language->get('text_port_name');
            $data['text_gp_container'] = $this->language->get('text_gp_container');
            $data['text_up_inco_terms'] = $this->language->get('text_up_inco_terms');

            
            $data['quote_detail'] = $this->model_catalog_quote->getById($q_id);
            
            $this->load->model('localisation/country');
            $rs_country = $this->model_localisation_country->getCountry($data['quote_detail'][0]['buyer_country']);
            $data['quote_country'] = $rs_country['name'];

            $this->load->model('localisation/zone');
            $rs_zone = $this->model_localisation_zone->getZone($data['quote_detail'][0]['buyer_state']);
            $data['quote_state'] = $rs_zone['name'];
            
            $rs_country = $this->model_localisation_country->getCountry($data['quote_detail'][0]['buyer_destination']);
            $data['buyer_country'] = $rs_country['name'];
            
            $seller_email = $this->model_catalog_quote->getSellerById($data['quote_detail'][0]['seller_id']);
            $data['flag_type'] = 'mail';
            $data['mail_type'] = 'to_seller';
            $subject = 'New RFQ';
            $message = $this->load->view('default/template/product/viewquote.tpl', $data);
            
            $mail = new Mail($this->config->get('config_mail'));
            $mail->setTo(array($seller_email));
            $mail->setFrom($this->config->get('config_name'));
            $mail->setSender($this->config->get('config_email'));
            $mail->setSubject($subject);
            $mail->setHtml(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
            $mail->send();

            /* ---------------------------------------------------------------- */

            $json['error'] = $this->language->get('request_success');
        } else {
            $json['status'] = 'error';
            $json['error'] = $this->language->get('error_required');
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
     public function addmultiplequote() {
        $this->load->language('product/quote');

        $json = array();
        $json['error'] = '';
        $flg = 0;
        if (trim($this->request->post['buyer_company']) == "") {
            $json['required']['buyer_company'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_name']) == "") {
            $json['required']['buyer_name'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_email']) == "") {
            $json['required']['buyer_email'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_email']) != "") {
            $expression = "/^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.([a-zA-Z]{2,4})$/";
            if (!preg_match($expression, $this->request->post['buyer_email'])) {
                $json['required']['buyer_email'] = '1';
                $flg = $flg + 1;
            }
        }
        if (trim($this->request->post['buyer_phone']) == "") {
            $json['required']['buyer_phone'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_country']) == "") {
            $json['required']['buyer_country'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['zone_id']) == "") {
            $json['required']['input-zone'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_city']) == "") {
            $json['required']['buyer_city'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_address']) == "") {
            $json['required']['buyer_address'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['category_id']) == "") {
            $json['required']['category_id'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['product_detail']) == "") {
            $json['required']['product_detail'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['product_name']) == "") {
            $json['required']['product_name'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['product_detail']) == "") {
            $json['required']['product_detail'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['quantity']) == "") {
            $json['required']['quantity'] = '1';
            $flg = $flg + 1;
        }
        
        if(empty($this->request->post['manufacturer'])){
            $json['required']['manufacturer'] = '1';
            $flg = $flg + 1;
        }
        
        
        if (trim($this->request->post['buyer_destination']) == "") {
            $json['required']['buyer_destination'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_payment_terms']) == "") {
            $json['required']['buyer_payment_terms'] = '1';
            $flg = $flg + 1;
        }
        if (empty($this->request->post['buyer_shipping_method'])) {
            $json['required']['buyer_shipping_method'] = '1';
            $flg = $flg + 1;
        }
        
        
        if ($flg == 0) {
            $json['status'] = 'success';
            $this->load->model('catalog/quote');
            $this->load->model('catalog/product');
            
            $manufacturer_array = array();
            $manufacturer_array = $this->request->post['manufacturer'];
            $product_info = $this->model_catalog_product->getProduct($this->request->post['product_id']);
            
            $post_data = $this->request->post;
            foreach ($manufacturer_array as $key=>$val){
            $post_data['seller_id'] = $val;
            $post_data['product_name'] = $product_info['name'];
                $q_id[$val] = $this->model_catalog_quote->add($post_data);
            }
            
            /* ---------------------------------------------------------------- */

            $this->load->language('product/quote');

            $data['heading_title'] = $this->language->get('heading_title');
            $data['heading_buyer'] = $this->language->get('heading_buyer');
            $data['heading_product'] = $this->language->get('heading_product');
            $data['entry_company'] = $this->language->get('entry_company');
            $data['entry_name'] = $this->language->get('entry_name');
            $data['entry_email'] = $this->language->get('entry_email');
            $data['entry_phone'] = $this->language->get('entry_phone');
            $data['entry_country'] = $this->language->get('entry_country');
            $data['entry_state'] = $this->language->get('entry_state');
            $data['entry_city'] = $this->language->get('entry_city');
            $data['entry_address'] = $this->language->get('entry_address');
            $data['btn_submit'] = $this->language->get('btn_submit');
            $data['entry_select'] = $this->language->get('entry_select');
            $data['entry_product_detail'] = $this->language->get('entry_product_detail');
            $data['entry_qty'] = $this->language->get('entry_qty');
            $data['entry_price'] = $this->language->get('entry_price');
            $data['entry_additional_detail'] = $this->language->get('entry_additional_detail');
            $data['entry_other'] = $this->language->get('entry_other');
            $data['entry_reference'] = $this->language->get('entry_reference');
            $data['entry_id'] = $this->language->get('entry_id');
            $data['entry_date'] = $this->language->get('entry_date');
            $data['entry_currency'] = $this->language->get('entry_currency');
            $data['entry_unit'] = $this->language->get('entry_unit');
            $data['entry_status'] = $this->language->get('entry_status');
            $data['entry_date_responded'] = $this->language->get('entry_date_responded');
            $data['entry_billing'] = $this->language->get('entry_billing');
            
            $data['heading_shipping'] = $this->language->get('heading_shipping');
            $data['heading_shipping_sub'] = $this->language->get('heading_shipping_sub');
            $data['text_destination'] = $this->language->get('text_destination');
            $data['text_payment_terms'] = $this->language->get('text_payment_terms');
            $data['text_shipping_method'] = $this->language->get('text_shipping_method');
            
            $data['heading_shipping_subheading'] = $this->language->get('heading_shipping_subheading');
            $data['text_origin'] = $this->language->get('text_origin');
            $data['text_lead_time'] = $this->language->get('text_lead_time');
            $data['text_transit_time'] = $this->language->get('text_transit_time');
            $data['text_dispatch'] = $this->language->get('text_dispatch');
            $data['text_port_name'] = $this->language->get('text_port_name');
            $data['text_gp_container'] = $this->language->get('text_gp_container');
            $data['text_up_inco_terms'] = $this->language->get('text_up_inco_terms');

            if(!empty($q_id)) {
                foreach ($q_id  as $seller_id=>$req_id) {
                $data['quote_detail'] = $this->model_catalog_quote->getById($req_id);

                $this->load->model('localisation/country');
                $rs_country = $this->model_localisation_country->getCountry($data['quote_detail'][0]['buyer_country']);
                $data['quote_country'] = $rs_country['name'];

                $this->load->model('localisation/zone');
                $rs_zone = $this->model_localisation_zone->getZone($data['quote_detail'][0]['buyer_state']);
                $data['quote_state'] = $rs_zone['name'];
                
                $rs_country = $this->model_localisation_country->getCountry($data['quote_detail'][0]['buyer_destination']);
                $data['buyer_country'] = $rs_country['name'];
            

                $seller_email = $this->model_catalog_quote->getSellerById($seller_id);
                $data['flag_type'] = 'mail';
                $data['mail_type'] = 'to_seller';
                $subject = 'New RFQ';
                $message = $this->load->view('default/template/product/viewquote.tpl', $data);

                $mail = new Mail($this->config->get('config_mail'));
                $mail->setTo(array($seller_email));
                $mail->setFrom($this->config->get('config_name'));
                $mail->setSender($this->config->get('config_email'));
                $mail->setSubject($subject);
                $mail->setHtml(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
                $mail->send();
                }
            }
            /* ---------------------------------------------------------------- */

            $json['error'] = $this->language->get('request_success');
        } else {
            $json['status'] = 'error';
            $json['error'] = $this->language->get('error_required');
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
   
    
    public function editquote() {
        $this->load->language('product/quote');

        $json = array();
        $json['error'] = '';
        $flg = 0;
        if (trim($this->request->post['buyer_company']) == "") {
            $json['required']['buyer_company'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_name']) == "") {
            $json['required']['buyer_name'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_email']) == "") {
            $json['required']['buyer_email'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_email']) != "") {
            $expression = "/^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.([a-zA-Z]{2,4})$/";
            if (!preg_match($expression, $this->request->post['buyer_email'])) {
                $json['required']['buyer_email'] = '1';
                $flg = $flg + 1;
            }
        }
        if (trim($this->request->post['buyer_phone']) == "") {
            $json['required']['buyer_phone'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_country']) == "") {
            $json['required']['buyer_country'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['zone_id']) == "") {
            $json['required']['input-zone'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_city']) == "") {
            $json['required']['buyer_city'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_address']) == "") {
            $json['required']['buyer_address'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['product_name']) == "") {
            $json['required']['product_name'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['product_detail']) == "") {
            $json['required']['product_detail'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['quantity']) == "") {
            $json['required']['quantity'] = '1';
            $flg = $flg + 1;
        }
        
        if (trim($this->request->post['buyer_destination']) == "") {
            $json['required']['buyer_destination'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['buyer_payment_terms']) == "") {
            $json['required']['buyer_payment_terms'] = '1';
            $flg = $flg + 1;
        }
        if (empty($this->request->post['buyer_shipping_method'])) {
            $json['required']['buyer_shipping_method'] = '1';
            $flg = $flg + 1;
        }
        
        if($this->request->post['req_shipping']==1) {
        
            if (trim($this->request->post['origin_country']) == "") {
                $json['required']['origin_country'] = '1';
                $flg = $flg + 1;
            }

            if (trim($this->request->post['lead_time']) == "") {
                $json['required']['lead_time'] = '1';
                $flg = $flg + 1;
            }

            if (trim($this->request->post['transit_time']) == "") {
                $json['required']['transit_time'] = '1';
                $flg = $flg + 1;
            }

            if (trim($this->request->post['dispatch_place']) == "") {
                $json['required']['dispatch_place'] = '1';
                $flg = $flg + 1;
            }

            if (trim($this->request->post['nearest_port']) == "") {
                $json['required']['nearest_port'] = '1';
                $flg = $flg + 1;
            }

            if (empty($this->request->post['goods_per_container'])) {
                $json['required']['goods_per_container'] = '1';
                $flg = $flg + 1;
            }
        
        }
        
        if ($flg == 0) {
            $json['status'] = 'success';
            $this->load->model('catalog/quote');
            $this->model_catalog_quote->edit($this->request->post);
            if($this->request->post['btn_type']=='send') {
                $q_id = $this->request->post['req_id'];
                /* ---------------------------------------------------------------- */

                $this->load->language('product/quote');

                $data['heading_title'] = $this->language->get('heading_title');
                $data['heading_buyer'] = $this->language->get('heading_buyer');
                $data['heading_product'] = $this->language->get('heading_product');
                $data['entry_company'] = $this->language->get('entry_company');
                $data['entry_name'] = $this->language->get('entry_name');
                $data['entry_email'] = $this->language->get('entry_email');
                $data['entry_phone'] = $this->language->get('entry_phone');
                $data['entry_country'] = $this->language->get('entry_country');
                $data['entry_state'] = $this->language->get('entry_state');
                $data['entry_city'] = $this->language->get('entry_city');
                $data['entry_address'] = $this->language->get('entry_address');
                $data['btn_submit'] = $this->language->get('btn_submit');
                $data['entry_select'] = $this->language->get('entry_select');
                $data['entry_product_detail'] = $this->language->get('entry_product_detail');
                $data['entry_qty'] = $this->language->get('entry_qty');
                $data['entry_price'] = $this->language->get('entry_price');
                $data['entry_additional_detail'] = $this->language->get('entry_additional_detail');
                $data['entry_other'] = $this->language->get('entry_other');
                $data['entry_reference'] = $this->language->get('entry_reference');
                $data['entry_id'] = $this->language->get('entry_id');
                $data['entry_date'] = $this->language->get('entry_date');
                $data['entry_currency'] = $this->language->get('entry_currency');
                $data['entry_unit'] = $this->language->get('entry_unit');
                $data['entry_status'] = $this->language->get('entry_status');
                $data['entry_date_responded'] = $this->language->get('entry_date_responded');
                $data['entry_billing'] = $this->language->get('entry_billing');
                
                $data['heading_shipping'] = $this->language->get('heading_shipping');
                $data['heading_shipping_sub'] = $this->language->get('heading_shipping_sub');
                $data['text_destination'] = $this->language->get('text_destination');
                $data['text_payment_terms'] = $this->language->get('text_payment_terms');
                $data['text_shipping_method'] = $this->language->get('text_shipping_method');

                $data['heading_shipping_subheading'] = $this->language->get('heading_shipping_subheading');
                $data['text_origin'] = $this->language->get('text_origin');
                $data['text_lead_time'] = $this->language->get('text_lead_time');
                $data['text_transit_time'] = $this->language->get('text_transit_time');
                $data['text_dispatch'] = $this->language->get('text_dispatch');
                $data['text_port_name'] = $this->language->get('text_port_name');
                $data['text_gp_container'] = $this->language->get('text_gp_container');
                $data['text_up_inco_terms'] = $this->language->get('text_up_inco_terms');
                

                $data['quote_detail'] = $this->model_catalog_quote->getById($q_id);

                $this->load->model('localisation/country');
                $rs_country = $this->model_localisation_country->getCountry($data['quote_detail'][0]['buyer_country']);
                $data['quote_country'] = $rs_country['name'];

                $this->load->model('localisation/zone');
                $rs_zone = $this->model_localisation_zone->getZone($data['quote_detail'][0]['buyer_state']);
                $data['quote_state'] = $rs_zone['name'];

                $seller_email = $this->model_catalog_quote->getSellerById($data['quote_detail'][0]['seller_id']);
                $seller_company = $this->model_catalog_quote->getSellerDetailId($data['quote_detail'][0]['seller_id']);
                
                $rs_country = $this->model_localisation_country->getCountry($data['quote_detail'][0]['buyer_destination']);
                $data['buyer_country'] = (isset($rs_country['name']))?$rs_country['name']:'';
            
                
                $data['flag_type'] = 'mail';
                $data['mail_type'] = 'to_buyer';
                $subject = 'RFQ Response from '.html_entity_decode($seller_company);
                $message = $this->load->view('default/template/product/viewquote.tpl', $data);

                $mail = new Mail($this->config->get('config_mail'));
                $mail->setTo(array($this->request->post['buyer_email']));
                $mail->setFrom($seller_email);
                $mail->setSender($this->config->get('config_email'));
                $mail->setSubject($subject);
                $mail->setHtml(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
                $mail->send();
            }
            /* ---------------------------------------------------------------- */
            if($this->request->post['btn_type']=='send') {
                $json['error'] = $this->language->get('request_send');
            }else {
                $json['error'] = $this->language->get('request_save');
            }
        } else {
            $json['status'] = 'error';
            $json['error'] = $this->language->get('error_required');
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    

    public function getquote() {

        $data = array();
        $this->load->language('product/quote');

        $data['heading_title'] = $this->language->get('heading_title');
        $data['heading_buyer'] = $this->language->get('heading_buyer');
        $data['heading_product'] = $this->language->get('heading_product');
        $data['entry_company'] = $this->language->get('entry_company');
        $data['entry_name'] = $this->language->get('entry_name');
        $data['entry_email'] = $this->language->get('entry_email');
        $data['entry_phone'] = $this->language->get('entry_phone');
        $data['entry_country'] = $this->language->get('entry_country');
        $data['entry_state'] = $this->language->get('entry_state');
        $data['entry_city'] = $this->language->get('entry_city');
        $data['entry_address'] = $this->language->get('entry_address');
        $data['btn_submit'] = $this->language->get('btn_submit');
        $data['entry_select'] = $this->language->get('entry_select');
        $data['entry_product_detail'] = $this->language->get('entry_product_detail');
        $data['entry_qty'] = $this->language->get('entry_qty');
        $data['entry_price'] = $this->language->get('entry_price');
        $data['entry_additional_detail'] = $this->language->get('entry_additional_detail');
        $data['entry_other'] = $this->language->get('entry_other');
        $data['entry_reference'] = $this->language->get('entry_reference');
        $data['entry_id'] = $this->language->get('entry_id');
        $data['entry_date'] = $this->language->get('entry_date');
        $data['entry_currency'] = $this->language->get('entry_currency');
        $data['entry_unit'] = $this->language->get('entry_unit');
        $data['entry_status'] = $this->language->get('entry_status');
        $data['entry_date_responded'] = $this->language->get('entry_date_responded');
        $data['entry_billing'] = $this->language->get('entry_billing');
        $data['heading_shipping'] = $this->language->get('heading_shipping');
        $data['heading_shipping_sub'] = $this->language->get('heading_shipping_sub');
        $data['text_destination'] = $this->language->get('text_destination');
        $data['text_payment_terms'] = $this->language->get('text_payment_terms');
        $data['text_shipping_method'] = $this->language->get('text_shipping_method');

        $data['heading_shipping_subheading'] = $this->language->get('heading_shipping_subheading');
        $data['text_origin'] = $this->language->get('text_origin');
        $data['text_lead_time'] = $this->language->get('text_lead_time');
        $data['text_transit_time'] = $this->language->get('text_transit_time');
        $data['text_dispatch'] = $this->language->get('text_dispatch');
        $data['text_port_name'] = $this->language->get('text_port_name');
        $data['text_gp_container'] = $this->language->get('text_gp_container');
        $data['text_up_inco_terms'] = $this->language->get('text_up_inco_terms');
        
        $this->load->model('catalog/quote');
        $data['quote_detail'] = $this->model_catalog_quote->getById($this->request->post['id']);
        $this->load->model('localisation/country');
        $rs_country = $this->model_localisation_country->getCountry($data['quote_detail'][0]['buyer_country']);
        $data['quote_country'] = $rs_country['name'];
        
        $rs_country = $this->model_localisation_country->getCountry($data['quote_detail'][0]['buyer_destination']);
        $data['buyer_country'] = (isset($rs_country['name']))?$rs_country['name']:'';
        
        
            

        $this->load->model('localisation/zone');
        $rs_zone = $this->model_localisation_zone->getZone($data['quote_detail'][0]['buyer_state']);
        $data['quote_state'] = $rs_zone['name'];
        
        $json['status'] = 'success';
        $data['flag_type'] = 'view';
        $data['mail_type'] = 'to_buyer';
        $json['html'] = $this->load->view('default/template/product/viewquote.tpl', $data);
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    public function getreview() {

        $data = array();
        $this->load->language('product/quote');
        $data['heading_title_review'] = $this->language->get('heading_title_review');
        $data['heading_title_product'] = $this->language->get('heading_title_product');
        $data['heading_title_review_name'] = $this->language->get('heading_title_review_name');
        $data['heading_title_review'] = $this->language->get('heading_title_review');
        $data['heading_rating_review'] = $this->language->get('heading_rating_review');
        $this->load->model('catalog/review');
        $data['review_detail'] = $this->model_catalog_review->getSellerProductReview($this->request->post['id']);
        
        $json['status'] = 'success';
        $data['flag_type'] = 'view';
        $json['html'] = $this->load->view('default/template/product/viewreview.tpl', $data);
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    

}
