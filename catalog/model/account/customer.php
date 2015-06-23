<?php

class ModelAccountCustomer extends Model {

    public function addCustomer($data) {
        $this->event->trigger('pre.customer.add', $data);

       if (isset($data['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($data['customer_group_id'], $this->config->get('config_customer_group_display'))) {
            $customer_group_id = $data['customer_group_id'];
        } else {
            $customer_group_id = $this->config->get('config_customer_group_id');
        }

        $this->load->model('account/customer_group');

        $customer_group_info = $this->model_account_customer_group->getCustomerGroup($customer_group_id);

         $this->db->query("INSERT INTO " . DB_PREFIX . "customer SET customer_group_id = '" . (int) $customer_group_id . "', store_id = '" . (int) $this->config->get('config_store_id') . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', custom_field = '" . $this->db->escape(isset($data['custom_field']['account']) ? serialize($data['custom_field']['account']) : '') . "', salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($data['password'])))) . "', newsletter = '" . (isset($data['newsletter']) ? (int) $data['newsletter'] : 0) . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', status = '1', approved = '" . (int) !$customer_group_info['approval'] . "', date_added = NOW()");

        $customer_id = $this->db->getLastId();

        $this->db->query("INSERT INTO " . DB_PREFIX . "address SET customer_id = '" . (int) $customer_id . "', firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', company = '" . $this->db->escape($data['company']) . "', address_1 = '" . $this->db->escape($data['address_1']) . "', address_2 = '" . $this->db->escape($data['address_2']) . "', city = '" . $this->db->escape($data['city']) . "', postcode = '" . $this->db->escape($data['postcode']) . "', country_id = '" . (int) $data['country_id'] . "', zone_id = '" . (int) $data['zone_id'] . "', custom_field = '" . $this->db->escape(isset($data['custom_field']['address']) ? serialize($data['custom_field']['address']) : '') . "'");

        $address_id = $this->db->getLastId();

        $this->db->query("UPDATE " . DB_PREFIX . "customer SET address_id = '" . (int) $address_id . "' WHERE customer_id = '" . (int) $customer_id . "'");

        $this->load->language('mail/customer');

        if (!$customer_group_info['approval']) {
           $row_email = $this->get_email_contents(1);
        } else {
           $row_email = $this->get_email_contents(2);
        }
        
        $array_find = array('{NAME}','{SITE_NAME}','{LOGIN_URL}');
        $array_replace = array($data['firstname'].' '.$data['lastname'],$this->config->get('config_name'),'<a style="color:#000;" target="_blank" href="'.$this->url->link('account/login', '', 'SSL').'">Login Here</a>');
        
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
        $mail->setTo($data['email']);
        $mail->setFrom($this->config->get('config_email'));
        $mail->setSender($this->config->get('config_name'));
        $mail->setSubject($subject);
        $mail->setHtml($html);
        $mail->send();

        // Send to main admin email if new account email is enabled
        if ($this->config->get('config_account_mail')) {
            
            
            
            $message ='<tr>
                    <td style="line-height:22px;">
                     <p>'.$this->language->get('text_signup').'</p>       
                     <p><b>'.$this->language->get('text_website') . '</b> ' . $this->config->get('config_name').'</p>
                     <p><b>'.$this->language->get('text_firstname') . '</b> ' . $data['firstname'].'</p>
                     <p><b>'.$this->language->get('text_customer_group') . '</b> ' . $customer_group_info['name'].'</p>
                     <p><b>'.$this->language->get('text_email') . '</b> ' . $data['email'].'</p>
                     <p><b>'.$this->language->get('text_telephone') . '</b> ' . $data['telephone'].'</p>
                    </td>
            </tr>';
                        
                        
            $data['message'] = $message;

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/template.tpl')) {
                    $html = $this->load->view($this->config->get('config_template') . '/template/mail/template.tpl', $data);
            } else {
                    $html = $this->load->view('default/template/mail/template.tpl', $data);
            }
            
            

            $mail->setTo($this->config->get('config_email'));
            $mail->setSubject(html_entity_decode($this->language->get('text_new_customer'), ENT_QUOTES, 'UTF-8'));
            //$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
            $mail->setHtml($html);
            $mail->send();

            // Send to additional alert emails if new account email is enabled
            $emails = explode(',', $this->config->get('config_mail_alert'));

            foreach ($emails as $email) {
                if (utf8_strlen($email) > 0 && preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {
                    $mail->setTo($email);
                    $mail->send();
                }
            }
        }

        $this->event->trigger('post.customer.add', $customer_id);

        return $customer_id;
    }

    public function editCustomer($data) {
        $this->event->trigger('pre.customer.edit', $data);

        $customer_id = $this->customer->getId();

        $this->db->query("UPDATE " . DB_PREFIX . "customer SET firstname = '" . $this->db->escape($data['firstname']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "', custom_field = '" . $this->db->escape(isset($data['custom_field']) ? serialize($data['custom_field']) : '') . "' WHERE customer_id = '" . (int) $customer_id . "'");

        $this->event->trigger('post.customer.edit', $customer_id);
    }

    public function editPassword($email, $password) {
        $this->event->trigger('pre.customer.edit.password');

        $this->db->query("UPDATE " . DB_PREFIX . "customer SET salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($password)))) . "' WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

        $this->event->trigger('post.customer.edit.password');
    }

    public function editNewsletter($newsletter) {
        $this->event->trigger('pre.customer.edit.newsletter');

        $this->db->query("UPDATE " . DB_PREFIX . "customer SET newsletter = '" . (int) $newsletter . "' WHERE customer_id = '" . (int) $this->customer->getId() . "'");

        $this->event->trigger('post.customer.edit.newsletter');
    }

    public function getCustomer($customer_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE customer_id = '" . (int) $customer_id . "'");

        return $query->row;
    }

    public function getCustomerByEmail($email) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

        return $query->row;
    }

    public function getCustomerByToken($token) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE token = '" . $this->db->escape($token) . "' AND token != ''");

        $this->db->query("UPDATE " . DB_PREFIX . "customer SET token = ''");

        return $query->row;
    }

    public function getTotalCustomersByEmail($email) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

        return $query->row['total'];
    }

    public function getIps($customer_id) {
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "customer_ip` WHERE customer_id = '" . (int) $customer_id . "'");

        return $query->rows;
    }

    public function isBanIp($ip) {
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "customer_ban_ip` WHERE ip = '" . $this->db->escape($ip) . "'");

        return $query->num_rows;
    }

    public function addLoginAttempt($email) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer_login WHERE email = '" . $this->db->escape(utf8_strtolower((string) $email)) . "' AND ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "'");

        if (!$query->num_rows) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "customer_login SET email = '" . $this->db->escape(utf8_strtolower((string) $email)) . "', ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "', total = 1, date_added = '" . $this->db->escape(date('Y-m-d H:i:s')) . "', date_modified = '" . $this->db->escape(date('Y-m-d H:i:s')) . "'");
        } else {
            $this->db->query("UPDATE " . DB_PREFIX . "customer_login SET total = (total + 1), date_modified = '" . $this->db->escape(date('Y-m-d H:i:s')) . "' WHERE customer_login_id = '" . (int) $query->row['customer_login_id'] . "'");
        }
    }

    public function getLoginAttempts($email) {
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "customer_login` WHERE email = '" . $this->db->escape(utf8_strtolower($email)) . "'");

        return $query->row;
    }

    public function deleteLoginAttempts($email) {
        $this->db->query("DELETE FROM `" . DB_PREFIX . "customer_login` WHERE email = '" . $this->db->escape(utf8_strtolower($email)) . "'");
    }

    public function addCustomerCustom($email) {
        $arry_user = explode('@', $email);
        $query = "INSERT INTO " . DB_PREFIX . "customer (store_id,firstname,email,newsletter,customer_group_id,ip,status,approved,date_added)
																				values(
																				'0',
																				'" . $arry_user[0] . "',
																				'" . $email . "',
																				'1',
																				'1',
																				'" . $_SERVER['SERVER_ADDR'] . "',
																				'1',
																				'1',
																				NOW()
																				)";


        $this->db->query($query);
        $customer_id = $this->db->getLastId();

        $query2 = "INSERT INTO " . DB_PREFIX . "address (customer_id,firstname) values(
																				'" . $customer_id . "',
																				'" . $arry_user[0] . "'
																				)";

        $this->db->query($query2);
        $address_id = $this->db->getLastId();

        $query3 = "UPDATE " . DB_PREFIX . "customer SET address_id = '" . (int) $address_id . "' WHERE customer_id = '" . (int) $customer_id . "'";
        $this->db->query($query3);
    }
    
    public function get_email_contents($id) {
        $query = $this->db->query("SELECT  * FROM " . DB_PREFIX . "email_contents WHERE id = '" . $id . "'");
        return $query->row;
    }

}
