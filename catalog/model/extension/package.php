<?php

class ModelExtensionPackage extends Model {

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

    public function getAllPackage() {
        $sql = "SELECT * FROM " . DB_PREFIX . "package n LEFT JOIN " . DB_PREFIX . "package_description nd ON n.package_id = nd.package_id WHERE n.status=1 AND nd.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY n.sort_order ";
        $query = $this->db->query($sql);

        return $query->rows;
    }
    
    public function getAllPackagePlan($id=0) {
        $sql_field = '';
        if($id!=0){
        $sql_field = " AND n.package_id !=1 ";    
        }
        $sql = "SELECT * FROM " . DB_PREFIX . "package n LEFT JOIN " . DB_PREFIX . "package_description nd ON n.package_id = nd.package_id WHERE n.status=1 ".$sql_field." AND nd.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY n.sort_order ";
        $query = $this->db->query($sql);

        return $query->rows;
    }

    public function getTotalPackage() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "package");

        return $query->row['total'];
    }
    
    public function getAllModules(){
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "package_modules WHERE status = '1'");
        return $query->rows;
    }
    
    public function getPackageEnc($package_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "package WHERE md5(package_id) = '" . $package_id . "'");
        return $query->row;
        
    }

}
