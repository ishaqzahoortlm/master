<?php
    class ControllerSimpleSupportInstall extends Controller {
        public function index() {
            $this->language->load('simple_support/install');
            
            if (isset($this->error['warning'])) {
    			$data['error_warning'] = $this->error['warning'];
    		} else if (isset($this->session->data['warning']) ) {
    			$data['error_warning'] = $this->session->data['warning'];
    			unset($this->session->data['warning']);
    		}
    		else {
    			$data['error_warning'] = '';
    		}
            
            if (isset($this->session->data['success'])) {
    			$data['success'] = $this->session->data['success'];
    
    			unset($this->session->data['success']);
    		} else {
    			$data['success'] = '';
    		}
            
            $data['database_found'] = $this->validateTable();
            
            $data['error_database'] = $this->language->get('error_database');
            
            //$this->template = 'simple_support/install.tpl';
		
            //$this->response->setOutput($this->render());
            
            $this->response->setOutput($this->load->view('simple_support/install.tpl', $data));
            
        }
        
        public function validateTable() {
            $table_name = $this->db->escape('simple_support_ticket');
            
            $table = DB_PREFIX . $table_name;
            
    		$query = $this->db->query("SHOW TABLES LIKE '{$table}'");
            
			/*if ($query->num_rows) {
                return true;
			}
   			return false;*/
               
            return $query->num_rows;    
        }
        
         public function installDatabase() {
            $this->language->load('simple_support/install');
            
            $this->load->model('simple_support/install');
            
            $this->model_simple_support_install->addExtensionTables();
            
            $this->session->data['success'] = $this->language->get('text_success');
            
            $route = $this->request->get['url'];
            
            $this->response->redirect($this->url->link($route, 'token=' . $this->session->data['token'], 'SSL'));
         }
        
    }
?> 