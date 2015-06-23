<?php

class ControllerSellerProductMessage extends ControllerSellerAccount {

    public function index() {
        $this->data['link_back'] = $this->url->link('account/account', '', 'SSL');
        $this->document->setTitle($this->language->get('ms_product_message'));

        $this->data['breadcrumbs'] = $this->MsLoader->MsHelper->setBreadcrumbs(array(
            array(
                'text' => $this->language->get('text_account'),
                'href' => $this->url->link('account/account', '', 'SSL'),
            ),
            array(
                'text' => $this->language->get('ms_product_message'),
                'href' => '',
            ),
        ));
        $this->data['link_to_dashboard'] = $this->url->link('seller/account-dashboard', '', 'SSL');
        $this->load->model('account/thread');
        $this->load->model('account/customer');
        $this->load->model('catalog/product');
        $seller_id = $this->customer->getId();
        $message = $this->model_account_thread->getAllMessage($seller_id,'seller_id');
       
        $this->data['all_message'] = array();
        if(!empty($message)) {
            foreach ($message as $msg) {
                $seller_info = $this->model_account_customer->getCustomer($msg['seller_id']);
                $customer_info = $this->model_account_customer->getCustomer($msg['customer_id']);
                $product_info = $this->model_catalog_product->getProduct($msg['product_id']);
                
                $msg_status = '';
                $status_check = $this->model_account_thread->getMsgStatus($msg['id'],$this->customer->getId(),'seller');
                if($status_check==0){
                    $msg_status = 1;
                }else {
                    $msg_status = 0;
                }
                
                $msg_date = $this->model_account_thread->getMsgDate($msg['id'],$this->customer->getId(),'seller');
                
                $this->data['all_message'][] = array(
                        'id' => $msg['id'],
                        'seller_id' => $msg['seller_id'],
                        'seller_name' => $seller_info['firstname'].' '.$seller_info['lastname'],
                        'customer_id' => $msg['customer_id'],
                        'customer_name' => $customer_info['firstname'].' '.$customer_info['lastname'],
                        'product_id' => $msg['product_id'],
                        'product_name' => $product_info['name'],
                        'status' => $msg_status,
                        'created_at' => $msg_date,
                    );
            }
        }
        
        list($template, $children) = $this->MsLoader->MsHelper->loadTemplate('productmessage');
        $this->response->setOutput($this->load->view($template, array_merge($this->data, $children)));
    }

    
    
    public function view() {

        $this->data['link_back'] = $this->url->link('account/account', '', 'SSL');
        $this->document->setTitle($this->language->get('ms_product_message'));

        $this->data['breadcrumbs'] = $this->MsLoader->MsHelper->setBreadcrumbs(array(
            array(
                'text' => $this->language->get('text_account'),
                'href' => $this->url->link('account/account', '', 'SSL'),
            ),
            array(
                'text' => $this->language->get('ms_product_message'),
                'href' => '',
            ),
        ));
        
        $id = $this->request->get['r_id'];
        $this->load->model('account/thread');
        $rs_message = $this->model_account_thread->getMessageByIdEnc($id);
        if(empty($rs_message)){
            $this->response->redirect($this->url->link('seller/product-message', '', 'SSL'));
        }
        
        $this->model_account_thread->updateMessageStatus($rs_message['id'],'seller');
        
        $this->data['all_message'] = array();
        
        $this->data['all_message'] = $this->model_account_thread->getAllComments($rs_message['id'],'seller');
        $this->load->model('account/customer');
        $this->load->model('account/supplier');
        $this->data['seller_info']= $this->model_account_supplier->getDetail($rs_message['seller_id']);
        $this->data['customer_info'] = $this->model_account_customer->getCustomer($rs_message['customer_id']);
        $this->data['message_id']= $rs_message['id'];
                
        
        
        

        list($template, $children) = $this->MsLoader->MsHelper->loadTemplate('messageview');
        $this->response->setOutput($this->load->view($template, array_merge($this->data, $children)));
    }

    public function replyback() {
        $this->load->language('product/quote');

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
            
            $subject = $this->language->get('ms_mail_reply_back');
                                
                                
            $mail_text ='<tr>
                         <td style="line-height:22px;">
                         <h2 style="color:#000;">Hi '.$receiver_info['firstname'].',</h2>
                         <p>'.$this->language->get('ms_mail_reply_back_msg').'</p>       
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

?>
