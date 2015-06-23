<?php
class ControllerAccountMessage extends Controller {
	private $error = array();

	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/message', '', 'SSL');

			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}

		$this->load->language('account/message');

		$this->document->setTitle($this->language->get('heading_title'));

		

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('account/account', '', 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => ''
		);

		$data['heading_title'] = $this->language->get('heading_title');
                $data['ms_product_message_by'] = $this->language->get('ms_product_message_by');
                $data['ms_message_product'] = $this->language->get('ms_message_product');
                $data['ms_all_message'] = $this->language->get('ms_all_message');
                $data['ms_btn_reply'] = $this->language->get('ms_btn_reply');
                $data['ms_title_reply'] = $this->language->get('ms_title_reply');
                $data['ms_reply_send'] = $this->language->get('ms_reply_send');
                $data['ms_action'] = $this->language->get('ms_action');
                $data['ms_status'] = $this->language->get('ms_status');
                $data['ms_date'] = $this->language->get('ms_date');
                
                
        $this->load->model('account/thread');
        $this->load->model('account/customer');
        $this->load->model('account/supplier');
        $this->load->model('catalog/product');
        $message = $this->model_account_thread->getAllMessage($this->customer->getId(),'customer_id');
       
        $data['all_message'] = array();
        if(!empty($message)) {
            foreach ($message as $msg) {
                
                $seller_info = $this->model_account_supplier->getDetail($msg['seller_id']);
                $customer_info = $this->model_account_customer->getCustomer($msg['customer_id']);
                $product_info = $this->model_catalog_product->getProduct($msg['product_id']);
                
                $msg_status = '';
                $status_check = $this->model_account_thread->getMsgStatus($msg['id'],$this->customer->getId(),'customer');
                if($status_check==0){
                    $msg_status = 1;
                }else {
                    $msg_status = 0;
                }
                
                $msg_date = $this->model_account_thread->getMsgDate($msg['id'],$this->customer->getId(),'customer');
                
                $data['all_message'][] = array(
                        'id' => $msg['id'],
                        'seller_id' => $msg['seller_id'],
                        'seller_name' => $seller_info['company'],
                        'customer_id' => $msg['customer_id'],
                        'customer_name' => $customer_info['firstname'].' '.$customer_info['lastname'],
                        'product_id' => $msg['product_id'],
                        'product_name' => $product_info['name'],
                        'status' => $msg_status,
                        'created_at' => $msg_date,
                    );
            }
        }
                
                
		
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/message.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/message.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/message.tpl', $data));
		}
	}
        
        public function view() {
            
            if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/message', '', 'SSL');

			$this->response->redirect($this->url->link('account/login', '', 'SSL'));
		}

		$this->load->language('account/message');

		$this->document->setTitle($this->language->get('heading_title'));

		

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_account'),
			'href' => $this->url->link('account/account', '', 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => ''
		);

		$data['heading_title'] = $this->language->get('heading_title');
                $data['ms_product_message_by'] = $this->language->get('ms_product_message_by');
                $data['ms_message_product'] = $this->language->get('ms_message_product');
                $data['ms_all_message'] = $this->language->get('ms_all_message');
                $data['ms_btn_reply'] = $this->language->get('ms_btn_reply');
                $data['ms_title_reply'] = $this->language->get('ms_title_reply');
                $data['ms_reply_send'] = $this->language->get('ms_reply_send');
                $data['ms_action'] = $this->language->get('ms_action');
                $data['ms_status'] = $this->language->get('ms_status');
                $data['ms_date'] = $this->language->get('ms_date');
                
                
                $id = $this->request->get['r_id'];
                $this->load->model('account/thread');
                $rs_message = $this->model_account_thread->getMessageByIdEnc($id);
                if(empty($rs_message)){
                    $this->response->redirect($this->url->link('seller/product-message', '', 'SSL'));
                }

                $this->model_account_thread->updateMessageStatus($rs_message['id'],'customer');

                $data['all_message'] = array();

                $data['all_message'] = $this->model_account_thread->getAllComments($rs_message['id'],'seller');
                $this->load->model('account/customer');
                $this->load->model('account/supplier');
                $data['seller_info']= $this->model_account_supplier->getDetail($rs_message['seller_id']);
                $data['customer_info'] = $this->model_account_customer->getCustomer($rs_message['customer_id']);
                $data['message_id']= $rs_message['id'];

                
                
		
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/messageview.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/account/messageview.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/account/messageview.tpl', $data));
		}
            
            
            
        }
        
        public function replyback() {
        $this->load->language('product/quote');
        $this->load->language('account/message');

        $json = array();
        $json['error'] = '';
        $flg = 0;
        if (trim($this->request->post['message_reply']) == "") {
            $json['required']['message_reply'] = '1';
            $flg = $flg + 1;
        }
        
        
        
        if ($flg == 0) {
            $json['status'] = 'success';
            $json['error'] =  $this->language->get('ms_reply_send');
            
            $this->load->model('account/thread');
            $data['thread_id']= $this->request->post['thread_id'];
            $data['receiver_id']= $this->request->post['receiver_id'];
            $data['receiver_type']= $this->request->post['receiver_type'];
            $data['body']= $this->request->post['message_reply'];
            $data['status']= '0';
            
            $this->model_account_thread->addThreadComments($data);
            
            $this->load->model('account/customer');
            $receiver_info = $this->model_account_customer->getCustomer($this->request->post['receiver_id']);
            
            $subject = $this->language->get('ms_mail_contact');
                                
                                
            $mail_text ='<tr>
                         <td style="line-height:22px;">
                         <h2 style="color:#000;">Hi '.$receiver_info['firstname'].',</h2>
                         <p>'.$this->language->get('ms_mail_contact_new_msg').'</p>       
                         <br/>
                         '.$this->language->get('ms_mail_ending_html').$this->config->get('config_name').'
                         </td>
                        </tr>';
            
            
            
            $data['message'] = $mail_text;

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/template.tpl')) {
                    $html = $this->load->view($this->config->get('config_template') . '/template/mail/template.tpl', $data);
            } else {
                    $html = $this->load->view('default/template/mail/template.tpl', $data);
            }
                    
            $mail = new Mail($this->config->get('config_mail'));
            $mail->setTo(array($receiver_info['email']));
            $mail->setFrom($this->config->get('config_email'));
            $mail->setSender($this->config->get('config_name'));
            $mail->setSubject($subject);
            $mail->setHtml($html);
            $mail->send();     
            
            
        } else {
            $json['status'] = 'error';
            $json['error'] = $this->language->get('error_required');
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
	
}