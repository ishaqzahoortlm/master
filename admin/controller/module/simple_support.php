<?php
	class ControllerModuleSimpleSupport extends Controller {
		
		private $error = array();
		
        public function index() {
            $url = $this->request->get['route'];
            if($this->validateDatabase()) {
                
                $this->language->load('simple_support/install');
                
                $this->document->setTitle($this->language->get('error_database'));
                
                $data['install_database'] = $this->url->link('simple_support/install/installDatabase', 'token=' . $this->session->data['token'] . '&url=' . $url, 'SSL');
                
                $data['text_install_message'] = $this->language->get('text_install_message');
                
                $data['text_upgrade'] = $this->language->get('text_upgrade');
                
                $data['breadcrumbs'] = array();

    	   		$data['breadcrumbs'][] = array(
    	       		'text'      => $this->language->get('text_home'),
    				'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
    	      		'separator' => false
    	   		);
                
                $data['header'] = $this->load->controller('common/header');
        		$data['column_left'] = $this->load->controller('common/column_left');
        		$data['footer'] = $this->load->controller('common/footer');
        
        		$this->response->setOutput($this->load->view('simple_support/notification.tpl', $data));
                
            } else {
                $this->getData();
            }	
		}
		
        public function validateDatabase() {
            
            $database_not_found = $this->load->controller('simple_support/install/validateTable');
            
            if(!$database_not_found) {
                return true;
            } 
            
            return false;
        }
        
		public function getData() {
			$this->language->load('module/simple_support');

			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('setting/setting');
			
			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
				$this->model_setting_setting->editSetting('simple_support', $this->request->post);		
	
				$this->session->data['success'] = $this->language->get('text_success');
	
				$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
                //$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
			}
			
			$data['heading_title'] = $this->language->get('heading_title');
			
			$data['text_enabled'] = $this->language->get('text_enabled');
			$data['text_disabled'] = $this->language->get('text_disabled');
			$data['text_select_all'] = $this->language->get('text_select_all');
			$data['text_unselect_all'] = $this->language->get('text_unselect_all');
			$data['text_content_top'] = $this->language->get('text_content_top');
			$data['text_content_bottom'] = $this->language->get('text_content_bottom');		
			$data['text_column_left'] = $this->language->get('text_column_left');
			$data['text_column_right'] = $this->language->get('text_column_right');
			$data['text_faq_module'] = $this->language->get('text_faq_module');
            $data['text_edit'] = $this->language->get('text_edit');
	
			$data['entry_layout'] = $this->language->get('entry_layout');
			$data['entry_position'] = $this->language->get('entry_position');
			$data['entry_status'] = $this->language->get('entry_status');
			$data['entry_sort_order'] = $this->language->get('entry_sort_order');
			$data['entry_simple_support_status'] = $this->language->get('entry_simple_support_status');			
			$data['entry_ticket_prefix'] = $this->language->get('entry_ticket_prefix');
			$data['entry_search_faq'] = $this->language->get('entry_search_faq');
			$data['entry_show_ticket_all'] = $this->language->get('entry_show_ticket_all');
			
            $data['help_ticket_prefix'] = $this->language->get('help_ticket_prefix');
			$data['help_search_faq'] = $this->language->get('help_search_faq');
			$data['help_default_simple_support_status'] = $this->language->get('help_default_simple_support_status');
			$data['help_show_ticket_all'] = $this->language->get('help_show_ticket_all');
			
			$data['button_save'] = $this->language->get('button_save');
			$data['button_cancel'] = $this->language->get('button_cancel');
			$data['button_add_module'] = $this->language->get('button_add_module');
			$data['button_remove'] = $this->language->get('button_remove');
			
			if (isset($this->error['warning'])) {
				$data['error_warning'] = $this->error['warning'];
			} else {
				$data['error_warning'] = '';
			}
	
			$data['breadcrumbs'] = array();
	
			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => false
			);
	
			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_module'),
				'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
			);
	
			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('heading_title'),
				'href'      => $this->url->link('module/simple_support', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
			);
			
			$data['action'] = $this->url->link('module/simple_support', 'token=' . $this->session->data['token'], 'SSL');

			$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
			
			$data['simple_support_status'] = '';
			$data['simple_support_ticket_prefix'] = '';
			$data['simple_support_search_faq'] = '';
			$data['simple_support_status_id'] = '';
			$data['simple_support_ticket_permission'] = array();
			
			$this->load->model('simple_support/status');
				
			$data['support_statues'] = $this->model_simple_support_status->getStatues();
			
			if (isset($this->request->post['simple_support_status_id'])) {
				$data['simple_support_status_id'] = $this->request->post['simple_support_status_id'];
			} else {
				$data['simple_support_status_id'] = $this->config->get('simple_support_status_id');
			}	
			
			if (isset($this->request->post['simple_support_status'])) {
				$data['simple_support_status'] = $this->request->post['simple_support_status'];
			} else if ($this->config->get('simple_support_status')) {
				$data['simple_support_status'] = $this->config->get('simple_support_status');
			}	
			
			if (isset($this->request->post['simple_support_ticket_prefix'])) {
				$data['simple_support_ticket_prefix'] = $this->request->post['simple_support_ticket_prefix'];
			} else if ($this->config->get('simple_support_ticket_prefix')) {
				$data['simple_support_ticket_prefix'] = $this->config->get('simple_support_ticket_prefix');
			}	

			if (isset($this->request->post['simple_support_search_faq'])) {
				$data['simple_support_search_faq'] = $this->request->post['simple_support_search_faq'];
			} else if ($this->config->get('simple_support_search_faq')) {
				$data['simple_support_search_faq'] = $this->config->get('simple_support_search_faq');
			}	
			
			$this->load->model('user/user_group');
			
			$data['user_groups'] = $this->model_user_user_group->getUserGroups();
			
			if (isset($this->request->post['simple_support_ticket_permission'])) {
				$data['simple_support_ticket_permission'] = $this->request->post['simple_support_ticket_permission'];
			} else if ($this->config->get('simple_support_ticket_permission')) {
				$data['simple_support_ticket_permission'] = $this->config->get('simple_support_ticket_permission');
			}	
			
			$data['modules'] = array();
			
			if (isset($this->request->post['simple_support_module'])) {
				$data['modules'] = $this->request->post['simple_support_module'];
			} elseif ($this->config->get('simple_support_module')) { 
				$data['modules'] = $this->config->get('simple_support_module');
			}	
			
			$this->load->model('design/layout');

			$data['layouts'] = $this->model_design_layout->getLayouts();
	
            $data['header'] = $this->load->controller('common/header');
    		$data['column_left'] = $this->load->controller('common/column_left');
    		$data['footer'] = $this->load->controller('common/footer');
    
    		$this->response->setOutput($this->load->view('module/simple_support.tpl', $data));
            			
		}

		protected function validate() {
			if (!$this->user->hasPermission('modify', 'module/simple_support')) {
				$this->error['warning'] = $this->language->get('error_permission');
			}
			
			if(utf8_strlen($this->request->post['simple_support_ticket_prefix']) > 5) {
				$this->error['warning'] = $this->language->get('error_ticket_prefix_length');
			}
			
			if(!isset($this->request->post['simple_support_ticket_permission'])) {
				$this->error['warning'] = $this->language->get('error_select_atleast_one_group');
			}
					
			if (!$this->error) {
				return true;
			} else {
				return false;
			}	
		}
	}
?>