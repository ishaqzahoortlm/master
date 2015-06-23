<?php
class ModelExtensionThread extends Model {
	
        public function getAllMessage(){
           $query = $this->db->query("SELECT *  FROM " . DB_PREFIX . "ms_thread ");
           return $query->rows;
        }
        
        public function getMsgStatus($id,$rid,$type){
           $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "ms_thread_comments WHERE thread_id = '" . $id . "' AND  receiver_id = '" . $rid . "' AND receiver_type = '".$type."' AND status=0 ");
           return $query->row['total'];
        }
        
         public function getMsgDate($id){
           $query = $this->db->query("SELECT created_at  FROM " . DB_PREFIX . "ms_thread_comments WHERE thread_id = '" . $id . "'  ");
           return (isset($query->row['created_at']))?$query->row['created_at']:'';
        }
        
        public function getMessageById($id){
           $query = $this->db->query("SELECT *  FROM " . DB_PREFIX . "ms_thread WHERE id = '" . $id . "'");
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