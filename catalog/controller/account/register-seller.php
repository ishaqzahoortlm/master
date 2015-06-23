<?php

class ControllerAccountRegisterSeller extends Controller {

    public $data = array();

    public function __construct($registry) {
        parent::__construct($registry);

        $this->language->load('account/register');
        $this->load->model('account/customer');
        $this->data = array_merge($this->data, $this->load->language('multiseller/multiseller'));
        $this->document->addScript('catalog/view/javascript/multimerch/account-register-seller.js');
    }

    public function index() {
        
        if ($this->customer->isLogged()) {
            $this->response->redirect($this->url->link('account/account', '', 'SSL'));
        }
        
        $this->data['seller_selected_package'] =  (isset($this->session->data['seller_selected_package']))?$this->session->data['seller_selected_package']:'';
        $this->data['package_plane_page'] = (isset($this->session->data['package_plane_page']))?$this->session->data['package_plane_page']:'';
        
        if (!$this->customer->isLogged() && $this->data['seller_selected_package']=="" ) {
            $this->response->redirect($this->url->link('information/membershipplane', '', 'SSL'));
        }
        
        if ($this->config->get('msconf_seller_terms_page')) {
            $this->load->model('catalog/information');
            $information_info = $this->model_catalog_information->getInformation($this->config->get('msconf_seller_terms_page'));
            $information_info_terms = $this->model_catalog_information->getInformation($this->config->get('msconf_seller_terms_use_page'));

            if ($information_info) {
                $this->data['seller_terms'] = str_replace('%s','',$this->language->get('ms_account_sellerinfo_terms_note')).' <a href="'.$this->url->link('information/information/agree', 'information_id=' . $this->config->get('msconf_seller_terms_use_page'), 'SSL').'" class="agree">'.$information_info_terms['title'].'</a> and <a href="'.$this->url->link('information/information/agree', 'information_id=' . $this->config->get('msconf_seller_terms_page'), 'SSL').'" class="agree">'.$information_info['title'].'</a>'; //sprintf($this->language->get('text_agree'), $this->url->link('information/information/agree', 'information_id=' . $this->config->get('config_account_id'), 'SSL'), $information_info['title'], $information_info['title']);
	    }
        }

        $this->document->setTitle($this->language->get('ms_account_register_seller'));
        $this->data['breadcrumbs'] = $this->MsLoader->MsHelper->setBreadcrumbs(array(
            array(
                'text' => $this->language->get('text_account'),
                'href' => $this->url->link('account/account', '', 'SSL'),
                'separator' => $this->language->get('text_separator')
            ),
            array(
                'text' => $this->language->get('ms_account_register_seller'),
                'href' => $this->url->link('account/register-seller', '', 'SSL')
            )
        ));
        

        list($template, $children) = $this->MsLoader->MsHelper->loadTemplate('account/register-seller');
        $this->response->setOutput($this->load->view($template, array_merge($this->data, $children)));
    }
    
    public function customer(){
        $this->load->model('account/supplier');
        $total = $this->model_account_supplier->getAccount($this->customer->getId());
        if($total==0){
        //$customer_info = $this->model_account_customer->getCustomer($this->customer->getId());
        $this->model_account_supplier->createSellerAccount($this->customer->getId());
        $this->response->redirect($this->url->link('seller/account-profile', '', 'SSL'));
        }else {
            $this->response->redirect($this->url->link('seller/account-dashboard', '', 'SSL'));
        }
    }

    public function jxsavesellerinfo() {
        $data = $this->request->post;
        $json = array();

        if ((utf8_strlen($data['seller']['firstname']) < 1) || (utf8_strlen($data['seller']['firstname']) > 32)) {
            $json['errors']['seller[firstname]'] = $this->language->get('error_firstname');
        }

        if ((utf8_strlen($data['seller']['lastname']) < 1) || (utf8_strlen($data['seller']['lastname']) > 32)) {
            $json['errors']['seller[lastname]'] = $this->language->get('error_lastname');
        }

        if ((utf8_strlen($data['seller']['email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $data['seller']['email'])) {
            $json['errors']['seller[email]'] = $this->language->get('error_email');
        } else {
            if ($this->model_account_customer->getTotalCustomersByEmail($data['seller']['email'])) {
                $json['errors']['seller[email]'] = $this->language->get('error_exists');
            }
        }

        if ((utf8_strlen($data['seller']['password']) < 4) || (utf8_strlen($data['seller']['password']) > 20)) {
            $json['errors']['seller[password]'] = $this->language->get('error_password');
        }

        if ($data['seller']['password_confirm'] != $data['seller']['password']) {
            $json['errors']['seller[password_confirm]'] = $this->language->get('error_confirm');
        }

        if (empty($data['seller']['nickname'])) {
            $json['errors']['seller[nickname]'] = $this->language->get('ms_error_sellerinfo_nickname_empty');
        } else if (mb_strlen($data['seller']['nickname']) < 4 || mb_strlen($data['seller']['nickname']) > 128) {
            $json['errors']['seller[nickname]'] = $this->language->get('ms_error_sellerinfo_nickname_length');
        } else if (($this->MsLoader->MsSeller->nicknameTaken($data['seller']['nickname']))) {
            $json['errors']['seller[nickname]'] = $this->language->get('ms_error_sellerinfo_nickname_taken');
        } else {
            switch ($this->config->get('msconf_nickname_rules')) {
                case 1:
                    // extended latin
                    if (!preg_match("/^[a-zA-Z0-9_\-\s\x{00C0}-\x{017F}]+$/u", $data['seller']['nickname'])) {
                        $json['errors']['seller[nickname]'] = $this->language->get('ms_error_sellerinfo_nickname_latin');
                    }
                    break;

                case 2:
                    // utf8
                    if (!preg_match("/((?:[\x01-\x7F]|[\xC0-\xDF][\x80-\xBF]|[\xE0-\xEF][\x80-\xBF]{2}|[\xF0-\xF7][\x80-\xBF]{3}){1,100})./x", $data['seller']['nickname'])) {
                        $json['errors']['seller[nickname]'] = $this->language->get('ms_error_sellerinfo_nickname_utf8');
                    }
                    break;

                case 0:
                default:
                    // alnum
                    if (!preg_match("/^[a-zA-Z0-9_\-\s]+$/", $data['seller']['nickname'])) {
                        $json['errors']['seller[nickname]'] = $this->language->get('ms_error_sellerinfo_nickname_alphanumeric');
                    }
                    break;
            }
        }
        
        if ((utf8_strlen($data['seller']['company']) < 1) || (utf8_strlen($data['seller']['company']) > 32)) {
            $json['errors']['seller[company]'] = $this->language->get('error_company');
        }

        if ($this->config->get('msconf_seller_terms_page')) {
            $this->load->model('catalog/information');
            $information_info = $this->model_catalog_information->getInformation($this->config->get('msconf_seller_terms_page'));
            $information_info_terms = $this->model_catalog_information->getInformation($this->config->get('msconf_seller_terms_use_page'));

            if ($information_info && !isset($data['seller']['terms'])) {
                $json['errors']['seller[terms]'] = htmlspecialchars_decode(sprintf($this->language->get('ms_error_sellerinfo_terms'),$information_info_terms['title'], $information_info['title']));
            }
        }

        if (empty($json['errors'])) {
            // Create buyer account
            $data['seller']['telephone'] = '';
            $data['seller']['fax'] = '';
            //$data['seller']['company'] = '';
            $data['seller']['address_1'] = '';
            $data['seller']['address_2'] = '';
            $data['seller']['city'] = '';
            $data['seller']['postcode'] = '';
            $data['seller']['country_id'] = 0;
            $data['seller']['zone_id'] = 0;
            $data['seller']['customer_group_id'] = $this->config->get('config_customer_group_id');
            $customer_id = $this->model_account_customer->addCustomer($data['seller']);
            $this->session->data['seller_registered_id'] = $customer_id;
            
            // Clear any previous login attempts for unregistered accounts.
            $this->model_account_customer->deleteLoginAttempts($data['seller']['email']);
            $this->customer->login($data['seller']['email'], $data['seller']['password']);
            unset($this->session->data['guest']);

            // Add to activity log
            $this->load->model('account/activity');
            $activity_data = array(
                'customer_id' => $this->session->data['seller_registered_id'],
                'name' => $data['seller']['firstname'] . ' ' . $data['seller']['lastname']
            );
            $this->model_account_activity->addActivity('register', $activity_data);

            // Register seller
            $data['seller']['approved'] = 0;
            if($this->config->get('msconf_seller_validation')==1){
             $row_email = $this->model_account_customer->get_email_contents(4);
            } else {
               $row_email = $this->model_account_customer->get_email_contents(3);
            }
            
            $array_find = array('{COMPANY}','{SITE_NAME}');
            $array_replace = array($data['seller']['company'],$this->config->get('config_name'));
        
            $email_contents = html_entity_decode($row_email['contents'], ENT_QUOTES, 'UTF-8');
            $email_contents = str_replace($array_find,$array_replace,$email_contents);
            
            $subject = $row_email['subject'];
        
            $message ='<tr>
                        <td style="line-height:22px;">'.$email_contents.'</td>
                       </tr>';

            $data['message'] = $message;

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/template.tpl')) {
                    $html = $this->load->view($this->config->get('config_template') . '/template/mail/template.tpl', $data);
            } else {
                    $html = $this->load->view('default/template/mail/template.tpl', $data);
            }


            $mail = new Mail($this->config->get('config_mail'));
            $mail->setTo($data['seller']['email']);
            $mail->setFrom($this->config->get('config_email'));
            $mail->setSender($this->config->get('config_name'));
            $mail->setSubject($subject);
            $mail->setHtml($html);
            $mail->send();
            
            
            switch ($this->config->get('msconf_seller_validation')) {
                case MsSeller::MS_SELLER_VALIDATION_APPROVAL:
                    
                    $mails[] = array(
                        'type' => MsMail::AMT_SELLER_ACCOUNT_AWAITING_MODERATION,
                        'data' => array(
                            'message' => '',
                            'seller_name' => $data['seller']['nickname'],
                            'seller_company' => $data['seller']['company'],
                            'customer_name' => $data['seller']['firstname'] . ' ' . $data['seller']['lastname'],
                            'customer_email' => $data['seller']['email']
                        )
                    );
                    $data['seller']['status'] = MsSeller::STATUS_INACTIVE;
                    break;

                case MsSeller::MS_SELLER_VALIDATION_NONE:
                default:
                    
                    $mails[] = array(
                        'type' => MsMail::AMT_SELLER_ACCOUNT_CREATED,
                        'data' => array(
                            'seller_name' => $data['seller']['nickname'],
                            'seller_company' => $data['seller']['company'],
                            'customer_name' => $data['seller']['firstname'] . ' ' . $data['seller']['lastname'],
                            'customer_email' => $data['seller']['email']
                        )
                    );
                    $data['seller']['status'] = MsSeller::STATUS_ACTIVE;
                    $data['seller']['approved'] = 1;
                    break;
            }

            $data['seller']['seller_id'] = $this->session->data['seller_registered_id'];
            $this->MsLoader->MsSeller->createSeller($data['seller']);
            $this->MsLoader->MsMail->sendMails($mails);
            if($data['package_plane_page']=='yes'){
                $json['redirect'] = $this->url->link('account/payment','','SSL');
            }
            else if($data['package_plane_page']=='update'){
                $json['redirect'] = $this->url->link('account/payment','','SSL');
            }
            else {
                $json['redirect'] = $this->url->link('seller/account-profile');
            }
        }

        $this->response->setOutput(json_encode($json));
    }

}

?>