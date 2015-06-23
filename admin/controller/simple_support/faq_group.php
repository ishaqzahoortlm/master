<?php
    class ControllerSimpleSupportFaqGroup extends Controller {
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
            $this->language->load('simple_support/faq_group');

			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/faq_group');
	
			$this->getList();
        }
        
		public function insert() {
			$this->language->load('simple_support/faq_group');
	
			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/faq_group');
	
			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
				//print "<pre>"; print_r($this->request->post); exit;
				$this->model_simple_support_faq_group->addFaqGroup($this->request->post);
	
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
	
				$this->response->redirect($this->url->link('simple_support/faq_group', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
	
			$this->getForm();
		}
	
		public function update() {
			$this->language->load('simple_support/faq_group');
	
			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/faq_group');
	
			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
				//print "<pre>"; print_r($this->request->post); exit;
				$this->model_simple_support_faq_group->editFaqGroup($this->request->get['simple_support_faq_group_id'], $this->request->post);
	
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
	
				$this->response->redirect($this->url->link('simple_support/faq_group', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
	
			$this->getForm();
		}
	
		public function delete() {
			$this->language->load('simple_support/faq_group');
	
			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/faq_group');
	
			if (isset($this->request->post['selected']) && $this->validateDelete()) {
				foreach ($this->request->post['selected'] as $simple_support_faq_group_id) {
					$this->model_simple_support_faq_group->deleteFaqGroup($simple_support_faq_group_id);
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
	
				$this->response->redirect($this->url->link('simple_support/faq_group', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
	
			$this->getList();
		}
		
		public function getList() {
			
			if (isset($this->request->get['filter_group_name'])) {
				$filter_group_name = $this->request->get['filter_group_name'];
			} else {
				$filter_group_name = '';
			}
			
			if (isset($this->request->get['filter_status'])) {
				$filter_status = $this->request->get['filter_status'];
			} else {
				$filter_status = '';
			}
			
			if (isset($this->request->get['sort'])) {
				$sort = $this->request->get['sort'];
			} else {
				$sort = 'ssfgd.name';
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
			
			if (isset($this->request->get['filter_group_name'])) {
				$url .= '&filter_group_name=' . $this->request->get['filter_group_name'];
			}
	
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];	
			}
			
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
				'href'      => $this->url->link('simple_support/faq_group', 'token=' . $this->session->data['token'], 'SSL'),
	      		'separator' => ' :: '
	   		);
			
			$data['insert'] = $this->url->link('simple_support/faq_group/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
			$data['delete'] = $this->url->link('simple_support/faq_group/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	
	
			$data['faq_groups'] = array();
			
			$filter_data = array(
				'filter_group_name' => $filter_group_name,
				'filter_status' => $filter_status,
				'sort'  => $sort,
				'order' => $order,
				'start' => ($page - 1) * $this->config->get('config_admin_limit'),
				'limit' => $this->config->get('config_admin_limit')
			);
			
			$faq_group_total = $this->model_simple_support_faq_group->getTotalFaqGroups($filter_data);
			
			$results = $this->model_simple_support_faq_group->getFaqGroups($filter_data);
			
			foreach ($results as $result) {
					
				$data['faq_groups'][] = array(
					'simple_support_faq_group_id' => $result['simple_support_faq_group_id'],
					'name'              => $result['name'],
					'sort_order'        => $result['sort_order'],
					'status'     		=> ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
					'selected'          => isset($this->request->post['selected']) && in_array($result['simple_support_faq_group_id'], $this->request->post['selected']),
					'edit'             => $this->url->link('simple_support/faq_group/update', 'token=' . $this->session->data['token'] . '&simple_support_faq_group_id=' . $result['simple_support_faq_group_id'] . $url, 'SSL')
				);
			}	
			
			$data['heading_title'] = $this->language->get('heading_title');
			
			$data['text_enabled'] = $this->language->get('text_enabled');
			$data['text_disabled'] = $this->language->get('text_disabled');
			$data['text_no_results'] = $this->language->get('text_no_results');
            $data['text_confirm'] = $this->language->get('text_confirm');
	
			$data['column_name'] = $this->language->get('column_name');
			$data['column_sort_order'] = $this->language->get('column_sort_order');
			$data['column_status'] = $this->language->get('column_status');
			$data['column_action'] = $this->language->get('column_action');		
	
			$data['button_insert'] = $this->language->get('button_insert');
			$data['button_delete'] = $this->language->get('button_delete');
			$data['button_filter'] = $this->language->get('button_filter');
            $data['button_edit'] = $this->language->get('button_edit');
			
			$data['token'] = $this->session->data['token'];
			
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
			
			if (isset($this->request->get['filter_group_name'])) {
				$url .= '&filter_group_name=' . $this->request->get['filter_group_name'];
			}
	
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];	
			}
			
			if ($order == 'ASC') {
				$url .= '&order=DESC';
			} else {
				$url .= '&order=ASC';
			}
	
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
	
			$data['sort_name'] = $this->url->link('simple_support/faq_group', 'token=' . $this->session->data['token'] . '&sort=ssfgd.name' . $url, 'SSL');
			$data['sort_sortorder'] = $this->url->link('simple_support/faq_group', 'token=' . $this->session->data['token'] . '&sort=ssfg.sort_order' . $url, 'SSL');
			$data['sort_status'] = $this->url->link('simple_support/faq_group', 'token=' . $this->session->data['token'] . '&sort=ssfg.status' . $url, 'SSL');
	
			$url = '';
			
			if (isset($this->request->get['filter_group_name'])) {
				$url .= '&filter_group_name=' . $this->request->get['filter_group_name'];
			}
	
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];	
			}
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}
	
			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
	
			$pagination = new Pagination();
			$pagination->total = $faq_group_total;
			$pagination->page = $page;
			$pagination->limit = $this->config->get('config_admin_limit');
			$pagination->text = $this->language->get('text_pagination');
			$pagination->url = $this->url->link('simple_support/faq_group', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
	
			$data['pagination'] = $pagination->render();
			
            $data['results'] = sprintf($this->language->get('text_pagination'), ($faq_group_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($faq_group_total - $this->config->get('config_limit_admin'))) ? $faq_group_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $faq_group_total, ceil($faq_group_total / $this->config->get('config_limit_admin')));
            
			$data['filter_group_name'] = $filter_group_name;
			$data['filter_status'] = $filter_status;
			$data['sort'] = $sort;
			$data['order'] = $order;
	
            $data['header'] = $this->load->controller('common/header');
  		    $data['column_left'] = $this->load->controller('common/column_left');
            $data['footer'] = $this->load->controller('common/footer');
    
            $this->response->setOutput($this->load->view('simple_support/faq_group_list.tpl', $data));  
		}		

		public function getForm() {
			$data['heading_title'] = $this->language->get('heading_title');
            
            $data['text_form'] = !isset($this->request->get['simple_support_faq_group_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
			
			$data['text_enabled'] = $this->language->get('text_enabled');
			$data['text_disabled'] = $this->language->get('text_disabled');
			
			$data['entry_name'] = $this->language->get('entry_name');
			$data['entry_sort_order'] = $this->language->get('entry_sort_order');
			$data['entry_status'] = $this->language->get('entry_status');
            
            $data['help_name'] = $this->language->get('help_name');
	
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
				'href'      => $this->url->link('simple_support/faq_group', 'token=' . $this->session->data['token'] . $url, 'SSL'),
				'separator' => ' :: '
			);
			
			if (!isset($this->request->get['simple_support_faq_group_id'])) {
				$data['action'] = $this->url->link('simple_support/faq_group/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
			} else {
				$data['action'] = $this->url->link('simple_support/faq_group/update', 'token=' . $this->session->data['token'] . '&simple_support_faq_group_id=' . $this->request->get['simple_support_faq_group_id'] . $url, 'SSL');
			}
			
			$data['cancel'] = $this->url->link('simple_support/faq_group', 'token=' . $this->session->data['token'] . $url, 'SSL');
			
			if (isset($this->request->get['simple_support_faq_group_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
				$faq_group_info = $this->model_simple_support_faq_group->getFaqGroupInfo($this->request->get['simple_support_faq_group_id']);
			}
			
			$this->load->model('localisation/language');
	
			$data['languages'] = $this->model_localisation_language->getLanguages();
			
			if (isset($this->request->post['faq_group_name'])) {
				$data['faq_group_name'] = $this->request->post['faq_group_name'];
			} elseif (isset($this->request->get['simple_support_faq_group_id'])) {
				$data['faq_group_name'] = $this->model_simple_support_faq_group->getFaqGroupDescriptions($this->request->get['simple_support_faq_group_id']);
			} else {
				$data['faq_group_name'] = array();
			}
			
			if (isset($this->request->post['sort_order'])) {
				$data['sort_order'] = $this->request->post['sort_order'];
			} elseif (!empty($faq_group_info)) {
				$data['sort_order'] = $faq_group_info['sort_order'];
			} else {
				$data['sort_order'] = 0;
			}
			
			if (isset($this->request->post['status'])) {
				$data['status'] = $this->request->post['status'];
			} elseif (!empty($faq_group_info)) {
				$data['status'] = $faq_group_info['status'];
			} else {
				$data['status'] = 0;
			}
            
            $data['header'] = $this->load->controller('common/header');
  		    $data['column_left'] = $this->load->controller('common/column_left');
            $data['footer'] = $this->load->controller('common/footer');
    
            $this->response->setOutput($this->load->view('simple_support/faq_group_form.tpl', $data)); 			
		}
		
		public function autocomplete() {
			$json = array();
			
			$this->load->model('simple_support/faq_group');
			
			if(isset($this->request->get['filter_group_name'])) {
				$filter_group_name = $this->request->get['filter_group_name'];
			} else {
				$filter_group_name = '';
			}
			
            if($filter_group_name) {
                $filter_data = array(
                    'filter_group_name' => $filter_group_name
                );
    			
    			$results = $this->model_simple_support_faq_group->getFaqGroups($filter_data);
    			
    			foreach ($results as $result) {
    				$json[] = array(
    					'simple_support_faq_group_id' => $result['simple_support_faq_group_id'],
    					'name'       => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
    				);
    			}    
            }
            
            $this->response->addHeader('Content-Type: application/json');
            $this->response->setOutput(json_encode($json));
		}
		
		public function validateForm() {
			if (!$this->user->hasPermission('modify', 'simple_support/faq_group')) {
				$this->error['warning'] = $this->language->get('error_permission');
			}
	
			foreach ($this->request->post['faq_group_name'] as $language_id => $value) {
				if ((utf8_strlen($value['name']) < 3) || (utf8_strlen($value['name']) > 32)) {
					$this->error['name'][$language_id] = $this->language->get('error_name');
				} else {
					if(!isset($this->request->get['simple_support_faq_group_id'])) {
						$found = $this->model_simple_support_faq_group->checkFaqGroupName($value['name'], $language_id, 0);
						
						if($found) {
							$this->error['name'][$language_id] = $this->language->get('error_duplicate_name');
							$this->error['warning'] = sprintf($this->language->get('error_duplicate_name_warning'), $value['name']);
						}						
					} else {
						$found = $this->model_simple_support_faq_group->checkFaqGroupName($value['name'], $language_id, $this->request->get['simple_support_faq_group_id']);
						
						if($found) {
							$this->error['name'][$language_id] = $this->language->get('error_duplicate_name');
							$this->error['warning'] = sprintf($this->language->get('error_duplicate_name_warning'), $value['name']);
						}	
					}
				}
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
			if (!$this->user->hasPermission('modify', 'simple_support/faq_group')) {
				$this->error['warning'] = $this->language->get('error_permission');
			}
			
			foreach ($this->request->post['selected'] as $simple_support_faq_group_id) {
				$found = $this->model_simple_support_faq_group->checkFaqGroup($simple_support_faq_group_id);
				
				if($found->num_rows) {
					$this->error['warning'] = sprintf($this->language->get('error_delete'), $found->row['name'], $found->num_rows);
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