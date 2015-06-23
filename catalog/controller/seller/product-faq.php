<?php

class ControllerSellerProductFaq extends ControllerSellerAccount {

    public function index() {
        $this->data['link_back'] = $this->url->link('account/account', '', 'SSL');
        $this->document->setTitle($this->language->get('ms_product_faq'));

        $this->data['breadcrumbs'] = $this->MsLoader->MsHelper->setBreadcrumbs(array(
            array(
                'text' => $this->language->get('text_account'),
                'href' => $this->url->link('account/account', '', 'SSL'),
            ),
            array(
                'text' => $this->language->get('ms_product_faq'),
                'href' => '',
            ),
        ));
        $this->load->model('catalog/faqs');
        $seller_id = $this->customer->getId();
        $this->data['all_faqs'] = $this->model_catalog_faqs->getAllFaq($seller_id);


        list($template, $children) = $this->MsLoader->MsHelper->loadTemplate('productfaq');
        $this->response->setOutput($this->load->view($template, array_merge($this->data, $children)));
    }

    public function create() {

        $this->data['link_back'] = $this->url->link('account/account', '', 'SSL');
        $this->document->setTitle($this->language->get('ms_product_faq'));

        $this->data['breadcrumbs'] = $this->MsLoader->MsHelper->setBreadcrumbs(array(
            array(
                'text' => $this->language->get('text_account'),
                'href' => $this->url->link('account/account', '', 'SSL'),
            ),
            array(
                'text' => $this->language->get('ms_product_faq'),
                'href' => '',
            ),
        ));

        $this->data['id'] = '';
        $this->data['question'] = '';
        $this->data['answer'] = '';
        $this->data['seller_id'] = $this->customer->getId();
        $this->data['status'] = '';
        $this->data['sort_order'] = '';

        list($template, $children) = $this->MsLoader->MsHelper->loadTemplate('productfaqform');
        $this->response->setOutput($this->load->view($template, array_merge($this->data, $children)));
    }
    
    public function edit() {

        $this->data['link_back'] = $this->url->link('account/account', '', 'SSL');
        $this->document->setTitle($this->language->get('ms_product_faq'));

        $this->data['breadcrumbs'] = $this->MsLoader->MsHelper->setBreadcrumbs(array(
            array(
                'text' => $this->language->get('text_account'),
                'href' => $this->url->link('account/account', '', 'SSL'),
            ),
            array(
                'text' => $this->language->get('ms_product_faq'),
                'href' => '',
            ),
        ));
        
        $id = $this->request->get['r_id'];
        $this->load->model('catalog/faqs');
        $rs_faq = $this->model_catalog_faqs->getFaqByIdEnc($id);
        if(empty($rs_faq)){
            $this->response->redirect($this->url->link('seller/product-faq', '', 'SSL'));
        }

        $this->data['id'] = $rs_faq['id'];
        $this->data['question'] = $rs_faq['question'];
        $this->data['answer'] = html_entity_decode($rs_faq['answer'], ENT_QUOTES, 'UTF-8');
        $this->data['seller_id'] = $this->customer->getId();
        $this->data['status'] = '';
        $this->data['sort_order'] = $rs_faq['sort_order'];

        list($template, $children) = $this->MsLoader->MsHelper->loadTemplate('productfaqform');
        $this->response->setOutput($this->load->view($template, array_merge($this->data, $children)));
    }

    public function save() {
        $this->load->language('product/quote');

        $json = array();
        $json['error'] = '';
        $flg = 0;
        if (trim($this->request->post['question']) == "") {
            $json['required']['question'] = '1';
            $flg = $flg + 1;
        }
        
        if (trim($this->request->post['answer']) == "") {
            $json['required']['answer'] = '1';
            $flg = $flg + 1;
        }
        if (trim($this->request->post['sort_order']) == "") {
            $json['required']['sort_order'] = '1';
            $flg = $flg + 1;
        }
        
        if ($flg == 0) {
            $json['status'] = 'success';
            $this->load->model('catalog/faqs');
            if($this->request->post['id']==""){
                $this->model_catalog_faqs->addFaq($this->request->post);
            }else {
                $this->model_catalog_faqs->editFaq($this->request->post);
            }
            
        } else {
            $json['status'] = 'error';
            $json['error'] = $this->language->get('error_required');
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function updatestatus() {
        $json['status'] = 'success';
        $status = '';
        $this->load->model('catalog/faqs');
        $current_status = $this->model_catalog_faqs->setFaqStatus($this->request->post['id']);

        if ($current_status == '0') {
            $status = '<a href="javascript:void(0)" onclick="set_review_status(' . $this->request->post['id'] . ')"><span class="label label-success" >Enable</span></a>';
        } else {
            $status = '<a href="javascript:void(0)" onclick="set_review_status(' . $this->request->post['id'] . ')"><span class="label label-default" >Disable</span></a>';
        }

        $json['html'] = $status;
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function delete() {
        $q_id = $this->request->get['r_id'];
        $this->load->model('catalog/faqs');
        $this->model_catalog_faqs->deleteSellerProductReview($q_id);
        $this->response->redirect($this->url->link('seller/product-faq', '', 'SSL'));
    }

    public function getdetail() {
        $data = array();
        $this->load->model('catalog/faqs');
        $faq_detail = $this->model_catalog_faqs->getFaqById($this->request->post['id']);
        $json['faq_question'] = $faq_detail['question'];
        $json['faq_answer'] = html_entity_decode($faq_detail['answer'], ENT_QUOTES, 'UTF-8');
        $json['status'] = 'success';
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

}

?>
