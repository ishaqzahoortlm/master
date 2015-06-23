<?php

class ControllerSellerProductReturn extends ControllerSellerAccount {

    public function index() {
        $this->data['link_back'] = $this->url->link('account/account', '', 'SSL');
        $this->document->setTitle($this->language->get('ms_product_return_heading'));

        $this->data['breadcrumbs'] = $this->MsLoader->MsHelper->setBreadcrumbs(array(
            array(
                'text' => $this->language->get('text_account'),
                'href' => $this->url->link('account/account', '', 'SSL'),
            ),
            array(
                'text' => $this->language->get('ms_product_return_heading'),
                'href' => '',
            ),
        ));
        $this->load->model('account/supplier');
        $seller_id = $this->customer->getId();
        $this->data['all_returns'] = $this->model_account_supplier->getAllReturns($seller_id);
$this->data['link_to_dashboard'] = $this->url->link('seller/account-dashboard', '', 'SSL');

        list($template, $children) = $this->MsLoader->MsHelper->loadTemplate('productreturns');
        $this->response->setOutput($this->load->view($template, array_merge($this->data, $children)));
    }

    public function save() {
        $this->load->language('product/quote');
        $json = array();
        $json['error'] = '';
        $flg = 0;
        if (trim($this->request->post['action']) == "") {
            $json['required']['action'] = '1';
            $flg = $flg + 1;
        }
        
        if ($flg == 0) {
            $json['status'] = 'success';
            $json['error'] = $this->language->get('update_success');
            $this->load->model('account/supplier');
            $this->model_account_supplier->updateReturn($this->request->post);
         } else {
            $json['status'] = 'error';
            $json['error'] = $this->language->get('error_required');
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
        
    }
    
    public function savehistory(){
        $this->load->language('product/quote');
        $json = array();
        $json['error'] = '';
        $flg = 0;
        if ($flg == 0) {
            $json['status'] = 'success';
            $json['error'] = $this->language->get('update_success');
            $this->load->model('account/supplier');
            $this->model_account_supplier->addReturnHistory($this->request->post);
        }
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    
    public function history(){
        //getReturnHistories
        $this->load->language('multiseller/multiseller');
        $this->load->model('account/supplier');
        $json = array();
        $json['error'] = '';
        $json['status'] = 'success';
        //$json['html'] = 'listing '.$this->request->post['return_id'];
        $data = array();
        $data['ms_clm_date_add'] = $this->language->get('ms_clm_date_add');
        $data['ms_text_rc'] = $this->language->get('ms_text_rc');
        $data['ms_text_status'] = $this->language->get('ms_text_status');
        $data['ms_text_nc'] = $this->language->get('ms_text_nc');
        $data['ms_no_record'] = $this->language->get('ms_no_record');
        $data['return_history'] = $this->model_account_supplier->getReturnHistories($this->request->post['return_id']);
        
        
        $json['html'] = $this->load->view('default/template/multiseller/returnhistory.tpl', $data);
        
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function edit() {
        $return_id = $this->request->get['return_id'];
        $this->load->language('account/return');

        if (isset($this->request->get['return_id'])) {
            $return_id = $this->request->get['return_id'];
        } else {
            $return_id = 0;
        }

        if (!$this->customer->isLogged()) {
            $this->response->redirect($this->url->link('account/login', '', 'SSL'));
        }

        $this->load->model('account/return');
        $id = $this->model_account_return->getReturnEnc($return_id);
        $return_info = $this->model_account_return->getReturnSeller($id);
        $this->data['return_info'] = $return_info;
        $this->document->setTitle($this->language->get('ms_product_return_heading'));

        $this->load->model('account/supplier');

        $this->data['all_return_actions'] = $this->model_account_supplier->getReturnActions();
        
        $this->load->model('localisation/return_status');
        $this->data['return_statuses'] = $this->model_localisation_return_status->getReturnStatuses();
        
        $this->data['breadcrumbs'] = $this->MsLoader->MsHelper->setBreadcrumbs(array(
            array(
                'text' => $this->language->get('text_account'),
                'href' => $this->url->link('account/account', '', 'SSL'),
            ),
            array(
                'text' => $this->language->get('ms_product_return_heading'),
                'href' => '',
            ),
        ));

        list($template, $children) = $this->MsLoader->MsHelper->loadTemplate('returnedit');
        $this->response->setOutput($this->load->view($template, array_merge($this->data, $children)));
    }

}

?>
