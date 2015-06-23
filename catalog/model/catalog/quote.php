<?php

class ModelCatalogQuote extends Model {

    public function add($data) {
        $query_seller = $this->db->query("SELECT * FROM " . DB_PREFIX . "ms_seller WHERE seller_id = '" . (int) $data['seller_id'] . "' ");
        $query_customer = $this->db->query("SELECT email as 'email' FROM `" . DB_PREFIX . "customer`	WHERE customer_id = " . (int) $data['seller_id']);
        $query_customer->row['email'];
        
        $this->db->query("INSERT INTO " . DB_PREFIX . "product_quotation SET seller_id = '" . $this->db->escape($data['seller_id']) . "',buyer_id = '" . $this->db->escape($data['buyer_id']) . "', buyer_name = '" . $this->db->escape($data['buyer_name']) . "', buyer_email = '" . $this->db->escape($data['buyer_email']) . "', buyer_phone = '" . $this->db->escape($data['buyer_phone']) . "', buyer_company = '" . $this->db->escape($data['buyer_company']) . "', buyer_country = '" . $this->db->escape($data['buyer_country']) . "', buyer_state = '" . $this->db->escape($data['zone_id']) . "', buyer_city = '" . $this->db->escape($data['buyer_city']) . "', buyer_address = '" . $this->db->escape($data['buyer_address']) . "', product_id = '" . $this->db->escape($data['product_id']) . "', product_name = '" . $this->db->escape($data['product_name']) . "', product_detail = '" . $this->db->escape($data['product_detail']) . "', quantity = '" . $this->db->escape($data['quantity']) . "', currency = '" . $this->db->escape($data['currency']) . "', unit = '" . $this->db->escape($data['unit']) . "', message = '" . $this->db->escape($data['message']) . "', reference = '" . $this->db->escape($data['reference']) . "', billing_address = '" . $this->db->escape($query_seller->row['billing_address']) . "', buyer_destination = '" . $this->db->escape($data['buyer_destination']) . "', buyer_payment_terms = '" . $this->db->escape($data['buyer_payment_terms']) . "', buyer_shipping_method = '" . implode(',',$data['buyer_shipping_method']) . "', need_seller_shipping = '" . $this->db->escape($data['need_seller_shipping']) . "', create_date = NOW()");
    
        return $this->db->getLastId();
    }
    
    public function edit($data){
        $all_units = (isset($data['all_units']))?$data['all_units']:array();
        $inco_terms = '';
        if(!empty($all_units)){
            foreach ($all_units as $k=>$v){
                $inco_terms[$v] = $data['unit_option_price'][$v];
            }
        }
        
        if(!empty($inco_terms)){
            $inco_terms = json_encode($inco_terms);
        }
        if(!empty($data['goods_per_container'])){
            $goods_per = implode(',',$data['goods_per_container']);
        }else {
            $goods_per = '';  
        }
        
       $this->db->query("UPDATE " . DB_PREFIX . "product_quotation SET seller_id = '" . $this->db->escape($data['seller_id']) . "',buyer_id = '" . $this->db->escape($data['buyer_id']) . "', buyer_name = '" . $this->db->escape($data['buyer_name']) . "', buyer_email = '" . $this->db->escape($data['buyer_email']) . "', buyer_phone = '" . $this->db->escape($data['buyer_phone']) . "', buyer_company = '" . $this->db->escape($data['buyer_company']) . "', buyer_country = '" . $this->db->escape($data['buyer_country']) . "', buyer_state = '" . $this->db->escape($data['zone_id']) . "', buyer_city = '" . $this->db->escape($data['buyer_city']) . "', buyer_address = '" . $this->db->escape($data['buyer_address']) . "', product_id = '" . $this->db->escape($data['product_id']) . "', product_name = '" . $this->db->escape($data['product_name']) . "', product_detail = '" . $this->db->escape($data['product_detail']) . "', quantity = '" . $this->db->escape($data['quantity']) . "', price = '" . $this->db->escape($data['price']) . "', currency = '" . $this->db->escape($data['currency']) . "', unit = '" . $this->db->escape($data['unit']) . "', message = '" . $this->db->escape($data['message']) . "', reference = '" . $this->db->escape($data['reference']) . "', billing_address = '" . $this->db->escape($data['billing_address']) . "', status = '" . $this->db->escape($data['status']) . "',buyer_destination = '" . $this->db->escape($data['buyer_destination']) . "', buyer_payment_terms = '" . $this->db->escape($data['buyer_payment_terms']) . "', buyer_shipping_method = '" . implode(',',$data['buyer_shipping_method']) . "', origin_country = '" . $this->db->escape($data['origin_country']) . "', lead_time = '" . $this->db->escape($data['lead_time']) . "', transit_time = '" . $this->db->escape($data['transit_time']) . "', dispatch_place = '" . $this->db->escape($data['dispatch_place']) . "',nearest_port = '" . $this->db->escape($data['nearest_port']) . "', goods_per_container = '" . $goods_per . "', unit_inco_terms = '" .  $inco_terms . "', responded_date = NOW() WHERE id ='".$data['req_id']."' ");
    
    }
    
    public function delete($id) {
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_quotation  WHERE md5(id) ='".$id."' ");
    }
    public function getAll($seller_id){
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_quotation WHERE seller_id = '" . (int) $seller_id . "'");
        return $query->rows;
    }
    
    public function getById($id){
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_quotation WHERE id = '" . (int) $id . "'");
        return $query->rows;
    }
    
    public function getByIdEnc($id){
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_quotation WHERE md5(id) = '" . $id . "'");
        return $query->row;
    }
    
    public function getSellerById($id){
        $query_customer = $this->db->query("SELECT email as 'email' FROM `" . DB_PREFIX . "customer`	WHERE customer_id = " . (int) $id);
        return $query_customer->row['email'];
    }
    
    public function getSellerDetailId($id){
        $query_seller = $this->db->query("SELECT company as 'company' FROM `" . DB_PREFIX . "ms_seller`	WHERE seller_id = " . (int) $id);
        return $query_seller->row['company'];
    }
    
    public function getProductSellers($array_products){
        $query = $this->db->query("SELECT DISTINCT seller_id FROM `" . DB_PREFIX . "ms_product`	WHERE product_id  IN(".implode(',',$array_products).") ");
        $sellers = array(0);
        foreach ($query->rows as $row){
            $sellers[] = $row['seller_id'];
        }
        $query_seller = $this->db->query("SELECT seller_id,company FROM `" . DB_PREFIX . "ms_seller`	WHERE seller_id IN(".implode(',',$sellers).") ");
        return  $query_seller->rows;
    }
}
