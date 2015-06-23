<?php

class ControllerSellerProductQuote extends ControllerSellerAccount {

  	public function index() {
		$this->data['link_back'] = $this->url->link('account/account', '', 'SSL');
		$this->document->setTitle($this->language->get('ms_product_quote_heading'));
		
		$this->data['breadcrumbs'] = $this->MsLoader->MsHelper->setBreadcrumbs(array(
			array(
				'text' => $this->language->get('text_account'),
				'href' => $this->url->link('account/account', '', 'SSL'),
			),
			array(
				'text' => $this->language->get('ms_product_quote_heading'),
				'href' => '',
			),			
			
		));
                $this->load->model('catalog/quote');
                $seller_id = $this->customer->getId();
                $this->data['all_quotes'] = $this->model_catalog_quote->getAll($seller_id);
                
		$this->data['link_to_dashboard'] = $this->url->link('seller/account-dashboard', '', 'SSL');
		list($template, $children) = $this->MsLoader->MsHelper->loadTemplate('productquote');
		$this->response->setOutput($this->load->view($template, array_merge($this->data, $children)));
	}
        
        public function update(){
                $this->data['link_back'] = $this->url->link('account/account', '', 'SSL');
		$this->document->setTitle($this->language->get('ms_product_quote_heading'));
		
		$this->data['breadcrumbs'] = $this->MsLoader->MsHelper->setBreadcrumbs(array(
			array(
				'text' => $this->language->get('text_account'),
				'href' => $this->url->link('account/account', '', 'SSL'),
			),
                        array(
				'text' => $this->language->get('ms_product_quote_heading'),
				'href' => $this->url->link('seller/product-quote', '', 'SSL'),
			),
			array(
				'text' => $this->language->get('ms_product_quote_update'),
				'href' => '',
			),			
			
		));
                
                $this->load->language('product/quote');

                $this->data['heading_title'] = $this->language->get('heading_title');
                $this->data['heading_buyer'] = $this->language->get('heading_buyer');
                $this->data['heading_product'] = $this->language->get('heading_product');
                $this->data['entry_company'] = $this->language->get('entry_company');
                $this->data['entry_name'] = $this->language->get('entry_name');
                $this->data['entry_email'] = $this->language->get('entry_email');
                $this->data['entry_phone'] = $this->language->get('entry_phone');
                $this->data['entry_country'] = $this->language->get('entry_country');
                $this->data['entry_state'] = $this->language->get('entry_state');
                $this->data['entry_city'] = $this->language->get('entry_city');
                $this->data['entry_address'] = $this->language->get('entry_address');
                $this->data['btn_submit'] = $this->language->get('btn_submit');
                $this->data['entry_select'] = $this->language->get('entry_select');
                $this->data['entry_product_detail'] = $this->language->get('entry_product_detail');
                $this->data['entry_qty'] = $this->language->get('entry_qty');
                $this->data['entry_price'] = $this->language->get('entry_price');
                $this->data['entry_additional_detail'] = $this->language->get('entry_additional_detail');
                $this->data['entry_other'] = $this->language->get('entry_other');
                $this->data['entry_reference'] = $this->language->get('entry_reference');
                $this->data['entry_id'] = $this->language->get('entry_id');
                $this->data['entry_date'] = $this->language->get('entry_date');
                $this->data['entry_currency'] = $this->language->get('entry_currency');
                $this->data['entry_unit'] = $this->language->get('entry_unit');
                $this->data['entry_status'] = $this->language->get('entry_status');
                $this->data['entry_date_responded'] = $this->language->get('entry_date_responded');
                $this->data['btn_send'] = $this->language->get('btn_send');
                $this->data['btn_save'] = $this->language->get('btn_save');
                $this->data['entry_billing'] = $this->language->get('entry_billing');
                
                $this->data['heading_shipping'] = $this->language->get('heading_shipping');
                $this->data['heading_shipping_sub'] = $this->language->get('heading_shipping_sub');
                $this->data['text_destination'] = $this->language->get('text_destination');
                $this->data['text_payment_terms'] = $this->language->get('text_payment_terms');
                $this->data['text_shipping_method'] = $this->language->get('text_shipping_method');

                $this->data['heading_shipping_subheading'] = $this->language->get('heading_shipping_subheading');
                $this->data['text_origin'] = $this->language->get('text_origin');
                $this->data['text_lead_time'] = $this->language->get('text_lead_time');
                $this->data['text_transit_time'] = $this->language->get('text_transit_time');
                $this->data['text_dispatch'] = $this->language->get('text_dispatch');
                $this->data['text_port_name'] = $this->language->get('text_port_name');
                $this->data['text_gp_container'] = $this->language->get('text_gp_container');
                $this->data['text_up_inco_terms'] = $this->language->get('text_up_inco_terms');
                
                $this->load->model('localisation/country');
                $this->data['countries'] = $this->model_localisation_country->getCountries();

                $this->load->model('localisation/currency');
                $this->data['currency'] = $this->model_localisation_currency->getCurrencies();

                $this->load->model('localisation/weight_class');
                $this->data['weight_classes'] = $this->model_localisation_weight_class->getWeightClasses();
                $q_id = $this->request->get['r_id'];
                $this->load->model('catalog/quote');
                $this->data['quote_detail'] = $this->model_catalog_quote->getByIdEnc($q_id);
                $this->load->model('account/supplier');
                $rs_seller_detail = $this->model_account_supplier->getDetail($this->customer->getId());
                $this->data['seller_countries'] = $rs_seller_detail['countries'];
                $this->load->model('catalog/information');
                $rs_cms_resor = $this->model_catalog_information->getInformation(17);
                $this->data['cms_resources'] = (!empty($rs_cms_resor))?$rs_cms_resor['title']:'';
                $this->data['cms_resources_link'] = (!empty($rs_cms_resor))?$this->url->link('information/information', 'information_id=' . $rs_cms_resor['information_id']):'';
        
                
                list($template, $children) = $this->MsLoader->MsHelper->loadTemplate('updatequote');
		$this->response->setOutput($this->load->view($template, array_merge($this->data, $children)));

        }
        
        public function delete(){
            $q_id = $this->request->get['r_id'];
            $this->load->model('catalog/quote');
            $this->model_catalog_quote->delete($q_id);
            $this->response->redirect($this->url->link('seller/product-quote', '', 'SSL'));
        }
}

?>
