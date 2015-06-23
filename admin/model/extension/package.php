<?php

class ModelExtensionPackage extends Model {

    public function addPackage($data) {
        $this->db->query("INSERT INTO " . DB_PREFIX . "package SET duration = '" . $this->db->escape($data['duration']) . "',duration_type = '" . $this->db->escape($data['duration_type']) . "',price = '" . $this->db->escape($data['price']) . "',modules = '" . implode(',',$data['modules']) . "',trial = '" . $this->db->escape($data['trial']) . "',sort_order = '" . $this->db->escape($data['sort_order']) . "', date_added = NOW(), status = '" . (int) $data['status'] . "'");

        $package_id = $this->db->getLastId();
        foreach ($data['package'] as $key => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "package_description SET package_id = '" . (int) $package_id . "', language_id = '" . (int) $key . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "'");
        }
    }

    public function editPackage($package_id, $data) {
        $this->db->query("UPDATE " . DB_PREFIX . "package SET duration = '" . $this->db->escape($data['duration']) . "',duration_type = '" . $this->db->escape($data['duration_type']) . "',price = '" . $this->db->escape($data['price']) . "',modules = '" . implode(',',$data['modules']) . "',trial = '" . $this->db->escape($data['trial']) . "',sort_order = '" . $this->db->escape($data['sort_order']) . "', status = '" . (int) $data['status'] . "' WHERE package_id = '" . (int) $package_id . "'");

        $this->db->query("DELETE FROM " . DB_PREFIX . "package_description WHERE package_id = '" . (int) $package_id . "'");

        foreach ($data['package'] as $key => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "package_description SET package_id = '" . (int) $package_id . "', language_id = '" . (int) $key . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "'");
        }
    }

    public function getPackage($package_id) {
        $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "package WHERE package_id = '" . (int) $package_id . "'");

        if ($query->num_rows) {
            return $query->row;
        } else {
            return false;
        }
    }

    public function getPackageDescription($package_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "package_description WHERE package_id = '" . (int) $package_id . "'");

        foreach ($query->rows as $result) {
            $package_description[$result['language_id']] = array(
                'title' => $result['title'],
                'description' => $result['description']
            );
        }

        return $package_description;
    }

    public function getAllPackage($data) {
        $sql = "SELECT * FROM " . DB_PREFIX . "package n LEFT JOIN " . DB_PREFIX . "package_description nd ON n.package_id = nd.package_id WHERE nd.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY date_added DESC";

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

    public function deletePackage($package_id) {
        $this->db->query("DELETE FROM " . DB_PREFIX . "package WHERE package_id = '" . (int) $package_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "package_description WHERE package_id = '" . (int) $package_id . "'");
    }

    public function getTotalPackage() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "package");

        return $query->row['total'];
    }
    
    public function getAllModules(){
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "package_modules WHERE status = '1'");
        return $query->rows;
    }

}
