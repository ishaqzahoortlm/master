<?php

class ControllerAccountPayment extends Controller {

    public function index() {

        if (isset($this->session->data['seller_registered_id'])) {
            
            $seller_selected_package = (isset($this->session->data['seller_selected_package'])) ? $this->session->data['seller_selected_package'] : '';
            $package_plane_page = (isset($this->session->data['package_plane_page'])) ? $this->session->data['package_plane_page'] : '';

            if ($seller_selected_package != "") {
                
                $alphabet = "abcdefghijklmnopqrstuwxyzABCDEFGHIJKLMNOPQRSTUWXYZ0123456789";
                $pass = array(); 
                $alphaLength = strlen($alphabet) - 1;
                for ($i = 1; $i <= 8; $i++) {
                    $n = rand(0, $alphaLength);
                    $pass[] = $alphabet[$n];
                }
                $random_str =  implode($pass); 
                
                $this->load->model('extension/package');
                $this->load->model('account/supplier');
                if($package_plane_page=='yes') {
                    $this->model_account_supplier->updateSellerPackage($this->session->data['seller_registered_id'],1);
                }
                $package_info = $this->model_extension_package->getPackage($seller_selected_package);
                $pkg_detail = $this->model_extension_package->getPackageDescription($seller_selected_package);
                
                if ($package_info['trial'] == 1) {
                    $this->model_account_supplier->updateSellerPackage($this->session->data['seller_registered_id'],$seller_selected_package);
                    $this->response->redirect($this->url->link('seller/account-profile'));
                }else {
                    
                    if ($this->config->get('config_mem_pay_sandbox')=='No') {
			$data['action'] = 'https://www.paypal.com/cgi-bin/webscr';
                    } else {
                        $data['action'] = 'https://www.sandbox.paypal.com/cgi-bin/webscr';
                    }
                    
                    $data['business'] = $this->config->get('config_mem_pay_email');
                    $amount = 0;
                    $discount = 0;
                    $amount = $package_info['price'];
                    if(floatval($this->config->get('config_mem_offer_discount'))!=0){
                      $discount =   (floatval($amount) * floatval($this->config->get('config_mem_offer_discount')))/100;
                    }
                    $amount = floatval($amount) - floatval($discount); 
                    
                    $data['amount'] = floatval($amount);
                    
                    $data['quantity'] = 1;
                    
                    $this->load->model('account/customer');
                    $customer_info = $this->model_account_customer->getCustomer($this->session->data['seller_registered_id']);

                    $data['currency_code'] = 'USD';
                    $data['first_name'] = html_entity_decode($customer_info['firstname'], ENT_QUOTES, 'UTF-8');
                    $data['last_name'] = html_entity_decode($customer_info['lastname'], ENT_QUOTES, 'UTF-8');
                    $data['email'] = $customer_info['email'];
                    $data['lc'] = 'US';
                    $data['return'] = $this->url->link('account/payment/success', 'key=' .$random_str.md5($this->session->data['seller_registered_id']).'&token=' .md5($seller_selected_package), 'SSL');
                    $data['cancel_return'] = $this->url->link('account/payment/cancel', '', 'SSL');
                    $data['paymentaction'] = 'sale';
                    
                    $html = '<div style="color:#999; float:left; width:100%; text-align:center;"><h3>Redirecting...</h3></div>';
                    
                    $html .= '<form name="payment_frm" id="payment_frm" action="'.$data['action'].'" method="post">';
                    $html .= '<input type="hidden" name="business" value="'.$data['business'].'" />';
                    $html .= '<input type="hidden" name="cmd" value="_xclick" />';
                    $html .= '<input type="hidden" name="item_name" value="'.$pkg_detail[$this->config->get('config_language_id')]['title'].'" />';
                    $html .= '<input type="hidden" name="amount" value="'.$data['amount'].'" />';
                    $html .= '<input type="hidden" name="quantity" value="'.$data['quantity'].'" />';
                    $html .= '<input type="hidden" name="currency_code" value="'.$data['currency_code'].'" />';
                    $html .= '<input type="hidden" name="first_name" value="'.$data['first_name'].'" />';
                    $html .= '<input type="hidden" name="last_name" value="'.$data['last_name'].'" />';
                    $html .= '<input type="hidden" name="email" value="'.$data['email'].'" />';
                    $html .= '<input type="hidden" name="lc" value="'.$data['lc'].'" />';
                    $html .= '<input type="hidden" name="return" value="'.$data['return'].'" />';
                    $html .= '<input type="hidden" name="cancel_return" value="'.$data['cancel_return'].'" />';
                    $html .= '<input type="hidden" name="paymentaction" value="'.$data['paymentaction'].'" />';
                    $html .= '</form>';
                    
                    $html .= '<script> document.payment_frm.submit(); </script>'; 
                    echo $html;
                    
                }
            }
        } else {
            $this->response->redirect($this->url->link('account/login', '', 'SSL'));
        }
    }
    
    public function success() {
       if($this->request->get['key']){
           $key = $this->request->get['key'];
       } 
       if($this->request->get['token']){
           $token = $this->request->get['token'];
           
       }
       
       if($this->request->get['key']){
           $key = substr($key, 8);
           $this->load->model('account/supplier');
           $account_info = $this->model_account_supplier->getAccountEnc($key);
           $this->load->model('account/customer');
           $customer_info = $this->model_account_customer->getCustomer($account_info);
           $this->load->model('extension/package');
           $package_info = $this->model_extension_package->getPackageEnc($token);
           $this->model_account_supplier->updateSellerPackage($account_info,$package_info['package_id']);
           $this->model_account_supplier->updateSellerAccount ($account_info,1);
           
       }
       
       $subject = 'Supplier Membership - '.$this->config->get('config_name');
       $message ='<tr>
                     <td style="line-height:22px;">
                     <h2 style="color:#000;">Hi '.$customer_info['firstname'].',</h2>
                     <p>Your supplier membership plan has been update successfully</p>       
                    </td>
                   </tr>';
                        
                        
        $data['message'] = $message;

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/template.tpl')) {
                $html = $this->load->view($this->config->get('config_template') . '/template/mail/template.tpl', $data);
        } else {
                $html = $this->load->view('default/template/mail/template.tpl', $data);
        }

        $mail = new Mail($this->config->get('config_mail'));
        $mail->setTo(array($customer_info['email']));
        $mail->setFrom($this->config->get('config_email'));
        $mail->setSender($this->config->get('config_name'));
        $mail->setSubject($subject);
        $mail->setHtml($html);
        $mail->send();
       
       unset($this->session->data['seller_selected_package']);
       unset($this->session->data['selected_package_page']); 
       $this->response->redirect($this->url->link('account/payment/thanks', '', 'SSL')); 
    }
    
    public function thanks() {
        $this->load->language('information/information');
        unset($this->session->data['seller_registered_id']);
        

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_home'),
                'href' => $this->url->link('common/home')
        );
        $this->document->setTitle($this->config->get('config_mem_pay_thanks'));
        $this->document->setDescription($this->config->get('config_mem_pay_thanks'));
        $this->document->setKeywords($this->config->get('config_mem_pay_thanks'));

        $data['breadcrumbs'][] = array(
                'text' => $this->config->get('config_mem_pay_thanks'),
                'href' => ''
        );

        $data['heading_title'] = $this->config->get('config_mem_pay_thanks');

        $data['button_continue'] = $this->language->get('button_continue');

        $data['description'] = html_entity_decode($this->config->get('config_mem_pay_thanks_detail'), ENT_QUOTES, 'UTF-8');

        $data['continue'] = $this->url->link('common/home');

        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/paymentthanks.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/information/paymentthanks.tpl', $data));
        } else {
                $this->response->setOutput($this->load->view('default/template/information/paymentthanks.tpl', $data));
        }
        
        
    }
    
    public function cancel() {
        unset($this->session->data['seller_registered_id']);
        $this->response->redirect($this->url->link('seller/account-profile'));
    }

}
