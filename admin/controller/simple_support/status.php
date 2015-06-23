<?php
    class ControllerSimpleSupportStatus extends Controller {
    	
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
            $this->language->load('simple_support/status');

			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/status');
			
			$this->getList();
        }
        
		public function insert() {
			$this->language->load('simple_support/status');
	
			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/status');
	
			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
				//print "<pre>"; print_r($this->request->post); exit;
				$this->model_simple_support_status->addSupportStatus($this->request->post);
	
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
	
				$this->response->redirect($this->url->link('simple_support/status', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
	
			$this->getForm();
		}
	
		public function update() {
			$this->language->load('simple_support/status');
	
			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/status');
	
			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
				//print "<pre>"; print_r($this->request->post); exit;
				$this->model_simple_support_status->editSupportStatus($this->request->get['simple_support_status_id'], $this->request->post);
	
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
	
				$this->response->redirect($this->url->link('simple_support/status', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
	
			$this->getForm();
		}
	
		public function delete() {
			$this->language->load('simple_support/status');
	
			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/status');
	
			if (isset($this->request->post['selected']) && $this->validateDelete()) {
				foreach ($this->request->post['selected'] as $simple_support_status_id) {
					$this->model_simple_support_status->deleteSupportStatus($simple_support_status_id);
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
	
				$this->response->redirect($this->url->link('simple_support/status', 'token=' . $this->session->data['token'] . $url, 'SSL'));
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
				'href'      => $this->url->link('simple_support/status', 'token=' . $this->session->data['token'] . $url, 'SSL'),
				'separator' => ' :: '
			);
	
            $data['insert'] = $this->url->link('simple_support/status/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
			$data['delete'] = $this->url->link('simple_support/status/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	
	
			$data['statues'] = array();
			
			$filter_data = array(
				'sort'  => $sort,
				'order' => $order,
				'start' => ($page - 1) * $this->config->get('config_admin_limit'),
				'limit' => $this->config->get('config_admin_limit')
			);
			
			$status_total = $this->model_simple_support_status->getTotalStatues($filter_data);
			
			$results = $this->model_simple_support_status->getStatues($filter_data);
			
			foreach ($results as $result) {
				$data['statues'][] = array(
					'simple_support_status_id'	=> $result['simple_support_status_id'],
					'name'            			=> $result['name'] . (($result['simple_support_status_id'] == $this->config->get('simple_support_status_id')) ? $this->language->get('text_default') : null),
					'selected'        			=> isset($this->request->post['selected']) && in_array($result['simple_support_status_id'], $this->request->post['selected']),
					'edit'       => $this->url->link('simple_support/status/update', 'token=' . $this->session->data['token'] . '&simple_support_status_id=' . $result['simple_support_status_id'] . $url, 'SSL')
				);
			}	
			
			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_no_results'] = $this->language->get('text_no_results');
	
			$data['column_name'] = $this->language->get('column_name');
			$data['column_action'] = $this->language->get('column_action');	
            
            $data['text_confirm'] = $this->language->get('text_confirm');	
	
			$data['button_insert'] = $this->language->get('button_insert');
            $data['button_edit'] = $this->language->get('button_edit');
			$data['button_delete'] = $this->language->get('button_delete');
			
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
	
			$data['sort_name'] = $this->url->link('simple_support/status', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
			
			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}
	
			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
	
			$pagination = new Pagination();
			$pagination->total = $status_total;
			$pagination->page = $page;
			$pagination->limit = $this->config->get('config_admin_limit');
			$pagination->text = $this->language->get('text_pagination');
			$pagination->url = $this->url->link('simple_support/status', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
	
			$data['pagination'] = $pagination->render();
			
            $data['results'] = sprintf($this->language->get('text_pagination'), ($status_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($status_total - $this->config->get('config_limit_admin'))) ? $status_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $status_total, ceil($status_total / $this->config->get('config_limit_admin')));
            
			$data['sort'] = $sort;
			$data['order'] = $order;
            
            $data['header'] = $this->load->controller('common/header');
  		    $data['column_left'] = $this->load->controller('common/column_left');
            $data['footer'] = $this->load->controller('common/footer');
    
            $this->response->setOutput($this->load->view('simple_support/status_list.tpl', $data));
		}

		public function getForm() {
			$data['heading_title'] = $this->language->get('heading_title');
			
            $data['text_form'] = !isset($this->request->get['simple_support_status_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
            
			$data['text_enabled'] = $this->language->get('text_enabled');
			$data['text_disabled'] = $this->language->get('text_disabled');
			
			$data['entry_name'] = $this->language->get('entry_name');
			$data['entry_status'] = $this->language->get('entry_status');
	
			$data['button_save'] = $this->language->get('button_save');
			$data['button_cancel'] = $this->language->get('button_cancel');
			
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
				'href'      => $this->url->link('simple_support/status', 'token=' . $this->session->data['token'] . $url, 'SSL'),
				'separator' => ' :: '
			);
			
			if (!isset($this->request->get['simple_support_status_id'])) {
				$data['action'] = $this->url->link('simple_support/status/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
			} else {
				$data['action'] = $this->url->link('simple_support/status/update', 'token=' . $this->session->data['token'] . '&simple_support_status_id=' . $this->request->get['simple_support_status_id'] . $url, 'SSL');
			}
			
			$data['cancel'] = $this->url->link('simple_support/status', 'token=' . $this->session->data['token'] . $url, 'SSL');
			
			$this->load->model('localisation/language');
	
			$data['languages'] = $this->model_localisation_language->getLanguages();
			
			if (isset($this->request->post['status_name'])) {
				$data['status_name'] = $this->request->post['status_name'];
			} elseif (isset($this->request->get['simple_support_status_id'])) {
				$data['status_name'] = $this->model_simple_support_status->getSupportStatusDescriptions($this->request->get['simple_support_status_id']);
			} else {
				$data['status_name'] = array();
			}
			
            $data['header'] = $this->load->controller('common/header');
  		    $data['column_left'] = $this->load->controller('common/column_left');
            $data['footer'] = $this->load->controller('common/footer');
    
            $this->response->setOutput($this->load->view('simple_support/status_form.tpl', $data));
		}

		public function validateForm() {
            
			if (!$this->user->hasPermission('modify', 'simple_support/status')) {
    			$this->error['warning'] = $this->language->get('error_permission');
    		}
	
			foreach ($this->request->post['status_name'] as $language_id => $value) {
                if ((utf8_strlen($value['name']) < 3) || (utf8_strlen($value['name']) > 255)) {
    				$this->error['name'][$language_id] = $this->language->get('error_name');
    			}
			}
			
			if ($this->error && !isset($this->error['warning'])) {
				$this->error['warning'] = $this->language->get('error_warning');
			}
			
			return !$this->error;
		}
		
		protected function validateDelete() {
			if (!$this->user->hasPermission('modify', 'simple_support/status')) {
				$this->error['warning'] = $this->language->get('error_permission');
			}
			
			foreach ($this->request->post['selected'] as $simple_support_status_id) {
				if($simple_support_status_id == $this->config->get('simple_support_status_id')) {
					$this->error['warning'] = $this->language->get('error_default_status');
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