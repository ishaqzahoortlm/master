<?php

class ModelAccountSupplier extends Model {

    public function getAccount($id) {

        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "ms_seller WHERE seller_status=1 AND  seller_id = '" . (int) $id . "'");
        return $query->row['total'];
    }

    public function createSellerAccount($id) {
        $this->db->query("INSERT INTO `" . DB_PREFIX . "ms_seller` SET `seller_id` = '" . (int) $id . "', seller_status=1,seller_approved=1, `date_created` = NOW()");
    }

    public function updateSellerPackage($id, $package_id) {
        $this->db->query("UPDATE  `" . DB_PREFIX . "ms_seller` SET  package_id='" . $package_id . "',package_date = NOW() where `seller_id` = '" . (int) $id . "' ");
    }

    public function updateSellerAccount($id, $seller_status) {
        $this->db->query("UPDATE  `" . DB_PREFIX . "ms_seller` SET  seller_status='" . $seller_status . "' where `seller_id` = '" . (int) $id . "' ");
    }

    public function getAccountEnc($id) {

        $query = $this->db->query("SELECT seller_id FROM " . DB_PREFIX . "ms_seller WHERE  md5(seller_id) = '" . $id . "'");
        return $query->row['seller_id'];
    }

    public function getAccounts() {
        $query = $this->db->query("SELECT seller_id,seller_status,company,package_id,DATE(package_date) as package_date,DATE(date_created) as date_created FROM " . DB_PREFIX . "ms_seller WHERE seller_status = '1'");

        return $query->rows;
    }

    public function getPackageUpdateDays($id, $date) {
        $query = $this->db->query("SELECT DATEDIFF( CURDATE(), DATE(`" . $date . "`)) as days  FROM " . DB_PREFIX . "ms_seller WHERE  seller_id = '" . $id . "'");
        return $query->row['days'];
    }

    public function getDetail($id) {

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ms_seller WHERE seller_id = '" . (int) $id . "'");
        return $query->row;
    }

    public function addBuyerReview($data) {
        $this->db->query("INSERT INTO `" . DB_PREFIX . "ms_order_buyer_reviews` SET seller_id = '" . (int) $this->customer->getId() . "',customer_id = '" . $data['customer_id'] . "',order_id = '" . $data['order_id'] . "',rating = '" . $data['rating'] . "',text = '" . $this->db->escape($data['review']) . "', status=0, date_added = NOW()");
        $this->db->query("UPDATE  `" . DB_PREFIX . "order` SET  review_status='1' where order_id = '" . $data['order_id'] . "' ");
        $subject = 'New Buyer Review';
        $message = '<tr>
                        <td style="line-height:22px;">
                         <h2 style="color:#000;">Hi ,</h2>
                         <p>You have a new buyer review waiting</p>       
                        </td>
                    </tr>';


        $data['message'] = $message;

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/template.tpl')) {
            $html = $this->load->view($this->config->get('config_template') . '/template/mail/template.tpl', $data);
        } else {
            $html = $this->load->view('default/template/mail/template.tpl', $data);
        }

        $mail = new Mail($this->config->get('config_mail'));
        $mail->setTo(array($this->config->get('config_email')));
        $mail->setFrom($this->config->get('config_email'));
        $mail->setSender($this->config->get('config_name'));
        $mail->setSubject($subject);
        $mail->setHtml($html);
        $mail->send();
    }
    
    public function getBuyerReview($id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ms_order_buyer_reviews WHERE status = 1 AND  customer_id = '" . $id . "' order by review_id DESC");
        return $query->rows;
    }
    
    public function getCustomerEnc($customer_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE md5(customer_id) = '" . $customer_id . "'");

        return $query->row;
    }
    
    public function getAllReturns($id){
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ms_product WHERE seller_id = '" . $id . "'");
        $array_products [] = -1;
        foreach ($query->rows as $result) {
            $array_products[] = $result['product_id'];
        }
        $query_returns = $this->db->query("SELECT * FROM " . DB_PREFIX . "return WHERE product_id IN (" .implode(',',$array_products)  . ")");
        return $query_returns->rows;
    }
    
    public function getReturnActions(){
        $query_returns = $this->db->query("SELECT * FROM " . DB_PREFIX . "return_action WHERE language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY name ");
        return $query_returns->rows;
    }
    
    public function updateReturn($data) {
          $this->db->query("UPDATE  " . DB_PREFIX . "return SET  return_action_id='" . $data['action'] . "',date_modified = NOW() where return_id = '" . $data['rid'] . "' ");
    }
    
    public function addReturnHistory($data) {
        $this->db->query("UPDATE `" . DB_PREFIX . "return` SET return_status_id = '" . (int) $data['return_status_id'] . "', date_modified = NOW() WHERE return_id = '" . (int) $data['return_id'] . "'");
        $this->db->query("INSERT INTO " . DB_PREFIX . "return_history SET return_id = '" . (int) $data['return_id'] . "', return_status_id = '" . (int) $data['return_status_id'] . "', notify = '" . (isset($data['notify']) ? (int) $data['notify'] : 0) . "', comment = '" . $this->db->escape(strip_tags($data['history_comment'])) . "', date_added = NOW()");
        if ($data['notify']) {
            $return_query = $this->db->query("SELECT *, rs.name AS status FROM `" . DB_PREFIX . "return` r LEFT JOIN " . DB_PREFIX . "return_status rs ON (r.return_status_id = rs.return_status_id) WHERE r.return_id = '" . (int) $data['return_id'] . "' AND rs.language_id = '" . (int) $this->config->get('config_language_id') . "'");
            $return_id = $data['return_id'];
            if ($return_query->num_rows) {
                $this->load->language('mail/return');

                $subject = sprintf($this->language->get('text_subject'), $this->config->get('config_name'), $return_id);
                $message = '<tr>
                                        <td style="line-height:22px;">
                                         <h2 style="color:#000;">Hi  '.$return_query->row['firstname'].',</h2>
                                         <p>' . $this->language->get('text_return_id') . ' ' . $return_id . '</p>       
                                         <br/>
                                         <p>' . $this->language->get('text_date_added') . ' ' . date($this->language->get('date_format_short'), strtotime($return_query->row['date_added'])) . '</p> 
                                         <p>' . $this->language->get('text_return_status') . ' ' . $return_query->row['status'] . '</p>';
                if ($data['history_comment']) {
                    $message .='<p>' . $this->language->get('text_comment') . ' ' . strip_tags(html_entity_decode($data['history_comment'], ENT_QUOTES, 'UTF-8')) . '</p>';
                }
                $message .='</td>
                                </tr>';


                $data['message'] = $message;

                if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/template.tpl')) {
                    $html = $this->load->view($this->config->get('config_template') . '/template/mail/template.tpl', $data);
                } else {
                    $html = $this->load->view('default/template/mail/template.tpl', $data);
                }



                $mail = new Mail($this->config->get('config_mail'));
                $mail->setTo($return_query->row['email']);
                $mail->setFrom($this->config->get('config_email'));
                $mail->setSender($this->config->get('config_name'));
                $mail->setSubject($subject);
                $mail->setHtml($html);
                $mail->send();
            }
        }
    }

    public function getReturnHistories($return_id) {
        $query = $this->db->query("SELECT rh.date_added, rs.name AS status, rh.comment, rh.notify FROM " . DB_PREFIX . "return_history rh LEFT JOIN " . DB_PREFIX . "return_status rs ON rh.return_status_id = rs.return_status_id WHERE rh.return_id = '" . (int) $return_id . "' AND rs.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY rh.date_added ASC ");
        
        return $query->rows;
    }
    
    public function getFeatured() {

        $query = $this->db->query("SELECT seller_id,company FROM " . DB_PREFIX . "ms_seller WHERE seller_status=1 AND  featured = '1'");
        return $query->rows;
    }

}
