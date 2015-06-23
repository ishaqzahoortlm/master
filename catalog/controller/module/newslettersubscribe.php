<?php

class ControllerModuleNewslettersubscribe extends Controller {

    private $error = array();

    public function index() {
        $this->load->model('account/customer');
        $num_check = $this->model_account_customer->getTotalCustomersByEmail($_POST['email']);
        if ($num_check == 0) {
             $this->model_account_customer->addCustomerCustom($_POST['email']); 
             echo json_encode(array('status'=>'success'));
        }
         
        }
        
    public function setsession(){
        $this->session->data['buyer_to_seller'] = $_POST['flag'];
        echo json_encode(array('status'=>'success'));
        
    } 
    
    public function setpackage(){
        $this->session->data['seller_selected_package'] = $_POST['package_id'];
        $this->session->data['package_plane_page'] = $_POST['package_plane_page'];
        if($_POST['package_plane_page']=='yes'){
            $link = $this->url->link('account/register-seller');
        }else if($_POST['package_plane_page']=='update'){
            $link = $this->url->link('account/payment');
        }
        echo json_encode(array('status'=>'success','link'=>$link));
        
    }  
    
}

?>