<?php
	class ControllerSimpleSupportDepartment extends Controller {
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
            $this->language->load('simple_support/department');

			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/department');
	
			$this->getList();
        }
        
		public function insert() {
			$this->language->load('simple_support/department');
	
			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/department');
	
			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
				
				//print "<pre>"; print_r($this->request->post); exit;
				$this->model_simple_support_department->addDepartment($this->request->post);
	
				$this->session->data['success'] = $this->language->get('text_success');
	
				$url = '';
	
				if (isset($this->request->get['sort'])) {
					$url .= '&sort=' . $this->request->get['sort'];
				}
	
				if (isset($this->request->get['order'])) {
					$url .= '&order=' . $this->request->get['order'];
				}
	
				if (isset($this->request->get['page'])) {
					$url .= '&page=' . $this->request->get['page'];
				}
	
				$this->response->redirect($this->url->link('simple_support/department', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
	
			$this->getForm();
		}
	
		public function update() {
			$this->language->load('simple_support/department');
	
			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/department');
	
			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
				$this->model_simple_support_department->editDepartment($this->request->get['simple_support_department_id'], $this->request->post);
	
				$this->session->data['success'] = $this->language->get('text_success');
	
				$url = '';
	
				if (isset($this->request->get['sort'])) {
					$url .= '&sort=' . $this->request->get['sort'];
				}
	
				if (isset($this->request->get['order'])) {
					$url .= '&order=' . $this->request->get['order'];
				}
	
				if (isset($this->request->get['page'])) {
					$url .= '&page=' . $this->request->get['page'];
				}
	
				$this->response->redirect($this->url->link('simple_support/department', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
	
			$this->getForm();
		}
	
		public function delete() {
			$this->language->load('simple_support/department');
	
			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/department');
	
			if (isset($this->request->post['selected']) && $this->validateDelete()) {
				foreach ($this->request->post['selected'] as $simple_support_department_id) {
					$this->model_simple_support_department->deleteDepartment($simple_support_department_id);
				}
	
				$this->session->data['success'] = $this->language->get('text_success');
	
				$url = '';
	
				if (isset($this->request->get['sort'])) {
					$url .= '&sort=' . $this->request->get['sort'];
				}
	
				if (isset($this->request->get['order'])) {
					$url .= '&order=' . $this->request->get['order'];
				}
	
				if (isset($this->request->get['page'])) {
					$url .= '&page=' . $this->request->get['page'];
				}
	
				$this->response->redirect($this->url->link('simple_support/department', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
	
			$this->getList();
		}
		
		public function getList() {
			if (isset($this->request->get['sort'])) {
				$sort = $this->request->get['sort'];
			} else {
				$sort = 'name';
			}
	
			if (isset($this->request->get['order'])) {
				$order = $this->request->get['order'];
			} else {
				$order = 'ASC';
			}
	
			if (isset($this->request->get['page'])) {
				$page = $this->request->get['page'];
			} else {
				$page = 1;
			}
            
            if (isset($this->request->post['selected'])) {
    			$data['selected'] = (array)$this->request->post['selected'];
    		} else {
    			$data['selected'] = array();
    		}
            
			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}
	
			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
	
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
	
			$data['breadcrumbs'] = array();
			
			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => false
			);
	
			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('heading_title'),
				'href'      => $this->url->link('simple_support/department', 'token=' . $this->session->data['token'] . $url, 'SSL'),
				'separator' => ' :: '
			);
	
			$data['insert'] = $this->url->link('simple_support/department/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
			$data['delete'] = $this->url->link('simple_support/department/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	
	
			$data['departments'] = array();
			
			$filter_data = array(
				'sort'  => $sort,
				'order' => $order,
				'start' => ($page - 1) * $this->config->get('config_admin_limit'),
				'limit' => $this->config->get('config_admin_limit')
			);
			
			$department_total = $this->model_simple_support_department->getTotalDepartments($filter_data);
			
			$results = $this->model_simple_support_department->getDepartments($filter_data);
			
			foreach ($results as $result) {
				
				$user_info = $this->model_simple_support_department->getUserInfo($result['simple_support_department_id']);
				
				$data['departments'][] = array(
					'simple_support_department_id'	=> $result['simple_support_department_id'],
					'name'            				=> $result['name'],
					'username'						=> $user_info['firstname'] . " " . $user_info['lastname'] . " (" . $user_info['email'] .")",
					'status'						=> ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
					'selected'        				=> isset($this->request->post['selected']) && in_array($result['simple_support_department_id'], $this->request->post['selected']),
					'edit'       => $this->url->link('simple_support/department/update', 'token=' . $this->session->data['token'] . '&simple_support_department_id=' . $result['simple_support_department_id'] . $url, 'SSL')
				);
			}	
			
			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_no_results'] = $this->language->get('text_no_results');
            $data['text_confirm'] = $this->language->get('text_confirm');
	
			$data['column_name'] = $this->language->get('column_name');
			$data['column_department_head'] = $this->language->get('column_department_head');
			$data['column_status'] = $this->language->get('column_status');
			$data['column_action'] = $this->language->get('column_action');		
	
			$data['button_insert'] = $this->language->get('button_insert');
			$data['button_delete'] = $this->language->get('button_delete');
            $data['button_edit'] = $this->language->get('button_edit');
			
			if (isset($this->error['warning'])) {
				$data['error_warning'] = $this->error['warning'];
			} else {
				$data['error_warning'] = '';
			}
	
			if (isset($this->session->data['success'])) {
				$data['success'] = $this->session->data['success'];
	
				unset($this->session->data['success']);
			} else {
				$data['success'] = '';
			}
			
			$url = '';

			if ($order == 'ASC') {
				$url .= '&order=DESC';
			} else {
				$url .= '&order=ASC';
			}
	
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
	
			$data['sort_name'] = $this->url->link('simple_support/department', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
			$data['sort_status'] = $this->url->link('simple_support/department', 'token=' . $this->session->data['token'] . '&sort=status' . $url, 'SSL');
	
			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}
	
			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
	
			$pagination = new Pagination();
			$pagination->total = $department_total;
			$pagination->page = $page;
			$pagination->limit = $this->config->get('config_admin_limit');
			$pagination->text = $this->language->get('text_pagination');
			$pagination->url = $this->url->link('simple_support/department', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
	
			$data['pagination'] = $pagination->render();
			
            $data['results'] = sprintf($this->language->get('text_pagination'), ($department_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($department_total - $this->config->get('config_limit_admin'))) ? $department_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $department_total, ceil($department_total / $this->config->get('config_limit_admin')));
            
			$data['sort'] = $sort;
			$data['order'] = $order;
	
			/*$this->template = 'simple_support/department_list.tpl';
			$this->children = array(
				'common/header',
				'common/footer'
			);
	
			$this->response->setOutput($this->render());*/
            
            $data['header'] = $this->load->controller('common/header');
  		    $data['column_left'] = $this->load->controller('common/column_left');
            $data['footer'] = $this->load->controller('common/footer');
    
            $this->response->setOutput($this->load->view('simple_support/department_list.tpl', $data));            			
		}		

		public function getForm() {
			$data['heading_title'] = $this->language->get('heading_title');
			
            $data['text_form'] = !isset($this->request->get['simple_support_department_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
            
			$data['text_enabled'] = $this->language->get('text_enabled');
			$data['text_disabled'] = $this->language->get('text_disabled');
			$data['text_customer'] = $this->language->get('text_customer');
			$data['text_admin'] = $this->language->get('text_admin');
            $data['text_confirm'] = $this->language->get('text_confirm');
            $data['text_username'] = $this->language->get('text_username');
            
            $data['help_department_head'] = $this->language->get('help_department_head');
			$data['help_department_for'] = $this->language->get('help_department_for');
			
			$data['entry_name'] = $this->language->get('entry_name');
			$data['entry_department_head'] = $this->language->get('entry_department_head');
			$data['entry_department_for'] = $this->language->get('entry_department_for');
			$data['entry_status'] = $this->language->get('entry_status');
	
			$data['button_save'] = $this->language->get('button_save');
			$data['button_cancel'] = $this->language->get('button_cancel');
            
			
			$data['token'] = $this->session->data['token'];
			
			if (isset($this->error['warning'])) {
				$data['error_warning'] = $this->error['warning'];
			} else {
				$data['error_warning'] = '';
			}
	
			if (isset($this->error['name'])) {
				$data['error_name'] = $this->error['name'];
			} else {
				$data['error_name'] = array();
			}
			
			if (isset($this->error['department_head_name'])) {
				$data['error_department_head_name'] = $this->error['department_head_name'];
			} else {
				$data['error_department_head_name'] = '';
			}

			if (isset($this->error['department_for'])) {
				$data['error_department_for'] = $this->error['department_for'];
			} else {
				$data['error_department_for'] = '';
			}

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}
	
			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
	
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
	
			$data['breadcrumbs'] = array();
	
			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => false
			);
	
			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('heading_title'),
				'href'      => $this->url->link('simple_support/department', 'token=' . $this->session->data['token'] . $url, 'SSL'),
				'separator' => ' :: '
			);
			
			if (!isset($this->request->get['simple_support_department_id'])) {
				$data['action'] = $this->url->link('simple_support/department/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
			} else {
				$data['action'] = $this->url->link('simple_support/department/update', 'token=' . $this->session->data['token'] . '&simple_support_department_id=' . $this->request->get['simple_support_department_id'] . $url, 'SSL');
			}
			
			$data['cancel'] = $this->url->link('simple_support/department', 'token=' . $this->session->data['token'] . $url, 'SSL');
			
			if (isset($this->request->get['simple_support_department_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
				$department_info = $this->model_simple_support_department->getDepartmentInfo($this->request->get['simple_support_department_id']);
			}
			
			$this->load->model('localisation/language');
	
			$data['languages'] = $this->model_localisation_language->getLanguages();
			
			if (isset($this->request->post['department_name'])) {
				$data['department_name'] = $this->request->post['department_name'];
			} elseif (isset($this->request->get['simple_support_department_id'])) {
				$data['department_name'] = $this->model_simple_support_department->getDepartmentDescriptions($this->request->get['simple_support_department_id']);
			} else {
				$data['department_name'] = array();
			}
			
			if (isset($this->request->post['department_head_id'])) {
				$data['department_head_name'] = $this->request->post['department_head_name'];
				$data['department_head_id'] = $this->request->post['department_head_id'];
			} elseif (isset($this->request->get['simple_support_department_id'])) {
				
				$user_info = $this->model_simple_support_department->getUserInfo($this->request->get['simple_support_department_id']);
				
				$data['department_head_name'] = $user_info['firstname'] . " " . $user_info['lastname'] . " (" . $user_info['email'] .")";
				$data['department_head_id'] = $user_info['user_id'];
				
			} else {
				$data['department_head_name'] = '';
				$data['department_head_id'] = 0;
			}
			
			if (isset($this->request->post['department_for'])) {
				$data['department_for'] = $this->request->post['department_for'];
			} elseif (isset($this->request->get['simple_support_department_id'])) {
				$data['department_for'] = $this->model_simple_support_department->getDepartmentFor($this->request->get['simple_support_department_id']);
			} else {
				$data['department_for'] = array();
			}
			
			if (isset($this->request->post['status'])) {
				$data['status'] = $this->request->post['status'];
			} elseif (!empty($department_info)) {
				$data['status'] = $department_info['status'];
			} else {
				$data['status'] = 0;
			}
			
			/*$this->template = 'simple_support/department_form.tpl';
			$this->children = array(
				'common/header',
				'common/footer'
			);
	
			$this->response->setOutput($this->render());*/
            
            $data['header'] = $this->load->controller('common/header');
  		    $data['column_left'] = $this->load->controller('common/column_left');
            $data['footer'] = $this->load->controller('common/footer');
    
            $this->response->setOutput($this->load->view('simple_support/department_form.tpl', $data));  			
		}
		
		public function autocomplete() {
			$json = array();
			
			if(isset($this->request->get['filter_name'])) {
				$filter_name = $this->request->get['filter_name'];
			} else {
				$filter_name = '';
			}
			
			$this->load->model('simple_support/department');
			
            if($filter_name) {
                $results = $this->model_simple_support_department->getUserName($filter_name);
			
    			foreach($results as $result) {
    				$json[] = array(
    					'user_id' 		=> $result['user_id'],
    					'username'      => strip_tags(html_entity_decode($result['username'], ENT_QUOTES, 'UTF-8')),
    					'name'			=> strip_tags(html_entity_decode($result['firstname'] . " " . $result['lastname'] . " (". $result['email'] . ")", ENT_QUOTES, 'UTF-8'))
    				);	
    			}
            }
            
            $this->response->addHeader('Content-Type: application/json');
            $this->response->setOutput(json_encode($json));
		}
		
		public function validateForm() {
			
			//return true;
			
			if (!$this->user->hasPermission('modify', 'simple_support/department')) {
				$this->error['warning'] = $this->language->get('error_permission');
			}
	
			foreach ($this->request->post['department_name'] as $language_id => $value) {
				if ((utf8_strlen($value['name']) < 3) || (utf8_strlen($value['name']) > 32)) {
					$this->error['name'][$language_id] = $this->language->get('error_name');
				}
			}
			
			if($this->request->post['department_head_name'] == '') {
				$this->error['department_head_name'] = $this->language->get('error_department_head_name');
			} else {
				if($this->request->post['department_head_id']) {
					
				} else {
					$this->error['department_head_name'] = $this->language->get('error_department_head_name_not_found');
				}
			}
			
			if(!isset($this->request->post['department_for'])) {
				$this->error['department_for'] = $this->language->get('error_department_for');
			}
			
			if ($this->error && !isset($this->error['warning'])) {
				$this->error['warning'] = $this->language->get('error_warning');
			}
			
			if (!$this->error) {
				return true;
			} else {
				return false;
			}
		}

		protected function validateDelete() {
			if (!$this->user->hasPermission('modify', 'simple_support/department')) {
				$this->error['warning'] = $this->language->get('error_permission');
			}
			
			foreach ($this->request->post['selected'] as $simple_support_department_id) {
				$found = $this->model_simple_support_department->checkDepartment($simple_support_department_id);
				
				if($found->num_rows) {
					$this->error['warning'] = sprintf($this->language->get('error_department_delete'), $found->row['name'], $found->num_rows);
				}
				
			}
			
			if (!$this->error) { 
				return true;
			} else {
				return false;
			}
		}		
	}
?>