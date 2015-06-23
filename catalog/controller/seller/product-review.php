<?php

class ControllerSellerProductReview extends ControllerSellerAccount {

  	public function index() {
		$this->data['link_back'] = $this->url->link('account/account', '', 'SSL');
		$this->document->setTitle($this->language->get('ms_product_review_heading'));
		
		$this->data['breadcrumbs'] = $this->MsLoader->MsHelper->setBreadcrumbs(array(
			array(
				'text' => $this->language->get('text_account'),
				'href' => $this->url->link('account/account', '', 'SSL'),
			),
			array(
				'text' => $this->language->get('ms_product_review_heading'),
				'href' => '',
			),			
			
		));
                $this->load->model('catalog/review');
                $seller_id = $this->customer->getId();
                $this->data['all_reviews'] = $this->model_catalog_review->getAllSeller($seller_id);
                
		
		list($template, $children) = $this->MsLoader->MsHelper->loadTemplate('productreview');
		$this->response->setOutput($this->load->view($template, array_merge($this->data, $children)));
	}
        
        public function updatestatus(){
               $json['status'] = 'success';
               $status = '';
               $this->load->model('catalog/review');
               $current_status = $this->model_catalog_review->setSellerProductReviewStatus($this->request->post['id']);
               
               if($current_status=='0'){
                $status = '<a href="javascript:void(0)" onclick="set_review_status('.$this->request->post['id'].')"><span class="label label-success" >Approved</span></a>';
                }else {
                $status = '<a href="javascript:void(0)" onclick="set_review_status('.$this->request->post['id'].')"><span class="label label-info" >Pending</span></a>';
                }
               
               $json['html'] = $status ;
               $this->response->addHeader('Content-Type: application/json');
               $this->response->setOutput(json_encode($json));
        }
        
        public function delete(){
            $q_id = $this->request->get['r_id'];
            $this->load->model('catalog/review');
            $this->model_catalog_review->deleteSellerProductReview($q_id);
            $this->response->redirect($this->url->link('seller/product-review', '', 'SSL'));
        }
}

?>
