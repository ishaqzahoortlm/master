<?php

class ModelExtensionEmails extends Model {

    public function add($data) {
        $this->db->query("INSERT INTO " . DB_PREFIX . "email_contents SET email_type = '" . $this->db->escape($data['email_type']) . "', subject = '" . $this->db->escape($data['subject']) . "', contents = '" . $this->db->escape($data['contents']) . "', status = '" . (int) $data['status'] . "', created_at = NOW()");
    }

    public function edit($id, $data) {
        $this->db->query("UPDATE " . DB_PREFIX . "email_contents SET email_type = '" . $this->db->escape($data['email_type']) . "', subject = '" . $this->db->escape($data['subject']) . "', contents = '" . $this->db->escape($data['contents']) . "',status = '" . (int) $data['status'] . "' WHERE id = '" . (int) $id . "'");
    }

    public function get($id) {
        $query = $this->db->query("SELECT  * FROM " . DB_PREFIX . "email_contents WHERE id = '" . (int) $id . "'");

        if ($query->num_rows) {
            return $query->row;
        } else {
            return false;
        }
    }

    

    public function getAll($data) {
        $sql = "SELECT * FROM " . DB_PREFIX . "email_contents  ORDER BY id DESC";

        if (isset($data['start']) && isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }

            if ($data['limit'] < 1) {
                $data['limit'] = 20;
            }

            $sql .= " LIMIT " . (int) $data['start'] . "," . (int) $data['limit'];
        }

        $query = $this->db->query($sql);

        return $query->rows;
    }

   

    public function getTotal() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "email_contents");

        return $query->row['total'];
    }
    
   

}
