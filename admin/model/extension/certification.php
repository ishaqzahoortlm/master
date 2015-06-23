<?php

class ModelExtensionCertification extends Model {

    public function addCertification($data) {
        $this->db->query("INSERT INTO " . DB_PREFIX . "certification SET status = '" . (int) $data['status'] . "'");

        $certification_id = $this->db->getLastId();
        foreach ($data['certification'] as $key => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "certification_description SET certification_id = '" . (int) $certification_id . "', language_id = '" . (int) $key . "', title = '" . $this->db->escape($value['title']) . "'");
        }
    }

    public function editCertification($certification_id, $data) {
        $this->db->query("UPDATE " . DB_PREFIX . "certification SET  status = '" . (int) $data['status'] . "' WHERE certification_id = '" . (int) $certification_id . "'");

        $this->db->query("DELETE FROM " . DB_PREFIX . "certification_description WHERE certification_id = '" . (int) $certification_id . "'");

        foreach ($data['certification'] as $key => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "certification_description SET certification_id = '" . (int) $certification_id . "', language_id = '" . (int) $key . "', title = '" . $this->db->escape($value['title']) . "'");
        }
    }

    public function getCertification($certification_id) {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "certification WHERE certification_id = '" . (int) $certification_id . "'");

        if ($query->num_rows) {
            return $query->row;
        } else {
            return false;
        }
    }

    public function getCertificationDescription($certification_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "certification_description WHERE certification_id = '" . (int) $certification_id . "'");

        foreach ($query->rows as $result) {
            $certification_description[$result['language_id']] = array(
                'title' => $result['title']
            );
        }

        return $certification_description;
    }

    public function getAllCertification($data) {
        $sql = "SELECT * FROM " . DB_PREFIX . "certification n LEFT JOIN " . DB_PREFIX . "certification_description nd ON n.certification_id = nd.certification_id WHERE nd.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY title DESC";

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

    public function deleteCertification($certification_id) {
        $this->db->query("DELETE FROM " . DB_PREFIX . "certification WHERE certification_id = '" . (int) $certification_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "certification_description WHERE certification_id = '" . (int) $certification_id . "'");
    }

    public function getTotalCertification() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "certification");

        return $query->row['total'];
    }
    
    public function getAll() {
        $sql = "SELECT * FROM " . DB_PREFIX . "certification n LEFT JOIN " . DB_PREFIX . "certification_description nd ON n.certification_id = nd.certification_id WHERE n.status='1' AND nd.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY title DESC";
        $query = $this->db->query($sql);
        return $query->rows;
    }

}
