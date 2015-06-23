<?php
class ModelAccountThread extends Model {
	
        public function addThread ($data){
          $this->db->query("INSERT INTO `" . DB_PREFIX . "ms_thread` SET `seller_id` = '" . (int)$data['seller_id'] . "', `customer_id` = '" . (int)$data['customer_id'] . "', `product_id` = '" . (int)$data['product_id'] . "', `created_at` = NOW()");
          $thread_id = $this->db->getLastId();
          $this->db->query("INSERT INTO `" . DB_PREFIX . "ms_thread_comments` SET `thread_id` = '" . (int)$thread_id . "',`receiver_id` = '" . (int)$data['receiver_id'] . "', `receiver_type` = '" . $data['receiver_type'] . "',`status` = '" . (int)$data['status'] . "', `body` = '" . $this->db->escape($data['body']) . "', `created_at` = NOW()");
         }
        
        public function addThreadComments ($data){
          $this->db->query("INSERT INTO `" . DB_PREFIX . "ms_thread_comments` SET `thread_id` = '" . (int)$data['thread_id'] . "',`receiver_id` = '" . (int)$data['receiver_id'] . "', `receiver_type` = '" . $data['receiver_type'] . "',`status` = '" . (int)$data['status'] . "', `body` = '" . $this->db->escape($data['body']) . "', `created_at` = NOW()");
         } 
         
        public function getNewMessage ($id,$type){
         $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "ms_thread_comments WHERE receiver_id = '" . $id . "' AND receiver_type = '".$type."' AND status=0 ");
         return $query->row['total'];
            
        } 
        
        public function getAllMessage($id,$type){
           $query = $this->db->query("SELECT *  FROM " . DB_PREFIX . "ms_thread WHERE ".$type." = '" . $id . "'");
           return $query->rows;
        }
        
        public function getMsgStatus($id,$rid,$type){
           $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "ms_thread_comments WHERE thread_id = '" . $id . "' AND  receiver_id = '" . $rid . "' AND receiver_type = '".$type."' AND status=0 ");
           return $query->row['total'];
        }
        
         public function getMsgDate($id,$rid,$type){
           $query = $this->db->query("SELECT created_at  FROM " . DB_PREFIX . "ms_thread_comments WHERE thread_id = '" . $id . "'  ORDER BY id DESC limit 1 ");
           return $query->row['created_at'];
        }
        
        public function getMessageByIdEnc($id){
           $query = $this->db->query("SELECT *  FROM " . DB_PREFIX . "ms_thread WHERE md5(id) = '" . $id . "'");
           return $query->row;
        }
        
        public function updateMessageStatus($id,$type){
           $query = $this->db->query("UPDATE  " . DB_PREFIX . "ms_thread_comments set status = 1 WHERE thread_id = '" . $id . "' AND receiver_type = '".$type."' ");
        }
        
        public function getAllComments($id,$type){
           $query = $this->db->query("SELECT *  FROM " . DB_PREFIX . "ms_thread_comments  WHERE thread_id = '" . $id . "'  ");
           return $query->rows;
        }
        
        
        
        
}