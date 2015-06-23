<?php
class ModelCatalogReview extends Model {
	public function addReview($product_id, $data) {
		$this->event->trigger('pre.review.add', $data);

		$this->db->query("INSERT INTO " . DB_PREFIX . "review SET author = '" . $this->db->escape($data['name']) . "', customer_id = '" . (int)$this->customer->getId() . "', product_id = '" . (int)$product_id . "', text = '" . $this->db->escape($data['text']) . "', rating = '" . (int)$data['rating'] . "', date_added = NOW()");

		$review_id = $this->db->getLastId();

		if ($this->config->get('config_review_mail')) {
                        
                        $sql = "select s.seller_id,c.firstname,c.lastname,c.email FROM " . DB_PREFIX . "ms_product as s, " . DB_PREFIX . "customer as c where s.product_id = '".$product_id."' AND  s.seller_id = c.customer_id ";
                        $query_seller = $this->db->query($sql);
                    
                        $seller_email = $query_seller->row['email'];
                    
			$this->load->language('mail/review');
			$this->load->model('catalog/product');
			$product_info = $this->model_catalog_product->getProduct($product_id);

			$subject = sprintf($this->language->get('text_subject'), $this->config->get('config_name'));
                        /*
                        $message  = 'Hi '.$query_seller->row['firstname'].','. "\n";
			$message  .= $this->language->get('text_waiting') . "\n";
			$message .= sprintf($this->language->get('text_product'), $this->db->escape(strip_tags($product_info['name']))) . "\n";
			$message .= sprintf($this->language->get('text_reviewer'), $this->db->escape(strip_tags($data['name']))) . "\n";
			$message .= sprintf($this->language->get('text_rating'), $this->db->escape(strip_tags($data['rating']))) . "\n";
			$message .= $this->language->get('text_review') . "\n";
			$message .= $this->db->escape(strip_tags($data['text'])) . "\n\n";
                        */
                        $message ='<tr>
                                        <td style="line-height:22px;">
                                         <h2 style="color:#000;">Hi ,</h2>
                                         <p>'.$this->language->get('text_waiting').'</p>       
                                         <br/>
                                         <p>'.sprintf($this->language->get('text_product'), $this->db->escape(strip_tags($product_info['name']))).'</p>
                                         <p>'.sprintf($this->language->get('text_reviewer'), $this->db->escape(strip_tags($data['name']))).'</p>
                                         <p>'.sprintf($this->language->get('text_rating'), $this->db->escape(strip_tags($data['rating']))).'</p>
                                         <p>'.$this->language->get('text_review').' '.$this->db->escape(strip_tags($data['text'])).'</p>
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
                        //$mail->setTo(array($seller_email));
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender($this->config->get('config_name'));
			$mail->setSubject($subject);
			$mail->setHtml($html);
			$mail->send();

			// Send to additional alert emails
			/*$emails = explode(',', $this->config->get('config_mail_alert'));

			foreach ($emails as $email) {
				if ($email && preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {
					$mail->setTo($email);
					$mail->send();
				}
			}*/
		}

		$this->event->trigger('post.review.add', $review_id);
	}

	public function getReviewsByProductId($product_id, $start = 0, $limit = 20) {
		if ($start < 0) {
			$start = 0;
		}

		if ($limit < 1) {
			$limit = 20;
		}

		$query = $this->db->query("SELECT r.review_id, r.author, r.rating, r.text, p.product_id, pd.name, p.price, p.image, r.date_added FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product p ON (r.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND p.date_available <= NOW() AND p.status = '1' AND r.status = '1' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY r.date_added DESC LIMIT " . (int)$start . "," . (int)$limit);

		return $query->rows;
	}

	public function getTotalReviewsByProductId($product_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "review r LEFT JOIN " . DB_PREFIX . "product p ON (r.product_id = p.product_id) LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE p.product_id = '" . (int)$product_id . "' AND p.date_available <= NOW() AND p.status = '1' AND r.status = '1' AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "'");

		return $query->row['total'];
	}
        
        public function getAllSeller($id){
            $q =  "SELECT review.* ,dp.name FROM " . DB_PREFIX . "ms_product as msp," . DB_PREFIX . "product_description as dp, " . DB_PREFIX . "review as review where msp.product_id = review.product_id AND review.product_id=dp.product_id AND msp.seller_id ='".$id."' ";
            $query = $this->db->query($q);
            return $query->rows;
        }
        
        public function getSellerProductReview($id){
            $q =  "SELECT review.* ,dp.name FROM " . DB_PREFIX . "ms_product as msp," . DB_PREFIX . "product_description as dp, " . DB_PREFIX . "review as review where msp.product_id = review.product_id AND review.product_id=dp.product_id AND review.review_id ='".$id."' ";
            $query = $this->db->query($q);
            return $query->row;
        }
        
        public function setSellerProductReviewStatus($id){
            $q =  "SELECT *  FROM  " . DB_PREFIX . "review  where  review_id ='".$id."' ";
            $query = $this->db->query($q);
            if($query->row['status']==1){
                $set_status = 0;
            }
            else {
                $set_status = 1;
            }
            $this->db->query("update " . DB_PREFIX . "review set status = ".$set_status." where  review_id ='".$id."' ");
            
            return $query->row['status'];
        }
        
        public function deleteSellerProductReview($id){
            $query = $this->db->query("DELETE FROM  " . DB_PREFIX . "review where md5(review_id) ='".$id."' ");
        }
        
}