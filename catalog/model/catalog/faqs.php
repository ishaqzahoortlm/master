<?php
class ModelCatalogFaqs extends Model {
	public function addFaq($data) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "ms_faq SET question = '" . $this->db->escape($data['question']) . "', answer = '" . $this->db->escape($data['question']) . "', seller_id = '" . (int)$data['seller_id'] . "', sort_order = '" . (int)$data['sort_order'] . "', status = '1'");
        }
        
        public function editFaq($data) {
            $this->db->query("UPDATE " . DB_PREFIX . "ms_faq SET question = '" . $this->db->escape($data['question']) . "', answer = '" . $this->db->escape($data['question']) . "', seller_id = '" . (int)$data['seller_id'] . "', sort_order = '" . (int)$data['sort_order'] . "'  WHERE id = '".$data['id']."'");
        }

	public function getFaqById($id) {
            $q =  "SELECT *  FROM " . DB_PREFIX . "ms_faq  where id ='".$id."' ";
            $query = $this->db->query($q);
            return $query->row;
	}

	public function getFaqByIdEnc($id) {
            $q =  "SELECT *  FROM " . DB_PREFIX . "ms_faq  where md5(id) ='".$id."' ";
            $query = $this->db->query($q);
            return $query->row;
	}
        
        
        
        public function getAllFaq($seller_id){
            $q =  "SELECT *  FROM " . DB_PREFIX . "ms_faq  where seller_id ='".$seller_id."' ";
            $query = $this->db->query($q);
            return $query->rows;
        }
        
        public function getAllFaqs($seller_id){
            $q =  "SELECT *  FROM " . DB_PREFIX . "ms_faq  where seller_id ='".$seller_id."' AND status = '1' ORDER BY sort_order ";
            $query = $this->db->query($q);
            return $query->rows;
        }
        
        public function getSellerProductReview($id){
            $q =  "SELECT review.* ,dp.name FROM " . DB_PREFIX . "ms_product as msp," . DB_PREFIX . "product_description as dp, " . DB_PREFIX . "review as review where msp.product_id = review.product_id AND review.product_id=dp.product_id AND review.review_id ='".$id."' ";
            $query = $this->db->query($q);
            return $query->row;
        }
        
        public function setFaqStatus($id){
            $q =  "SELECT *  FROM  " . DB_PREFIX . "ms_faq  where  id ='".$id."' ";
            $query = $this->db->query($q);
            if($query->row['status']==1){
                $set_status = 0;
            }
            else {
                $set_status = 1;
            }
            $this->db->query("update " . DB_PREFIX . "ms_faq set status = ".$set_status." where  id ='".$id."' ");
            
            return $query->row['status'];
        }
        
        public function deleteSellerProductReview($id){
            $query = $this->db->query("DELETE FROM  " . DB_PREFIX . "review where md5(review_id) ='".$id."' ");
        }
        
}