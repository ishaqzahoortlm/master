<?php
	class ControllerSimpleSupportFaq extends Controller {
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
            $this->language->load('simple_support/faq');

			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/faq');
	
			$this->getList();
        }
        
		public function insert() {
			$this->language->load('simple_support/faq');
	
			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/faq');
	
			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
				//print "<pre>"; print_r($this->request->post); exit;
				$this->model_simple_support_faq->addFaq($this->request->post);
	
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
	
				$this->response->redirect($this->url->link('simple_support/faq', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
	
			$this->getForm();
		}
	
		public function update() {
			$this->language->load('simple_support/faq');
	
			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/faq');
	
			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
				//print "<pre>"; print_r($this->request->post); exit;
				$this->model_simple_support_faq->editFaq($this->request->get['simple_support_faq_id'], $this->request->post);
	
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
	
				$this->response->redirect($this->url->link('simple_support/faq', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
	
			$this->getForm();
		}
	
		public function delete() {
			$this->language->load('simple_support/faq');
	
			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/faq');
	
			if (isset($this->request->post['selected']) && $this->validateDelete()) {
				foreach ($this->request->post['selected'] as $simple_support_faq_id) {
					$this->model_simple_support_faq->deleteFaq($simple_support_faq_id);
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
	
				$this->response->redirect($this->url->link('simple_support/faq', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
	
			$this->getList();
		}
		
		public function getList() {
			
			if (isset($this->request->get['filter_question'])) {
				$filter_question = $this->request->get['filter_question'];
			} else {
				$filter_question = '';
			}
			
			if (isset($this->request->get['filter_group_id'])) {
				$filter_group_id = $this->request->get['filter_group_id'];
			} else {
				$filter_group_id = '';
			}
			
			if (isset($this->request->get['filter_status'])) {
				$filter_status = $this->request->get['filter_status'];
			} else {
				$filter_status = '';
			}
			
			if (isset($this->request->get['sort'])) {
				$sort = $this->request->get['sort'];
			} else {
				$sort = 'ssfd.question';
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
			
			if (isset($this->request->get['filter_question'])) {
				$url .= '&filter_question=' . $this->request->get['filter_question'];
			}
			
			if (isset($this->request->get['filter_group_id'])) {
				$url .= '&filter_group_id=' . $this->request->get['filter_group_id'];
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
				'href'      => $this->url->link('simple_support/faq', 'token=' . $this->session->data['token'], 'SSL'),
	      		'separator' => ' :: '
	   		);
			
			$data['insert'] = $this->url->link('simple_support/faq/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
			$data['delete'] = $this->url->link('simple_support/faq/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	
			
			$this->load->model('simple_support/faq_group');
			
			$data['faq_groups'] = $this->model_simple_support_faq_group->getFaqGroups();
			
			$data['faqs'] = array();
			
			$filter_data = array(
				'filter_question' => $filter_question,
				'filter_group_id' => $filter_group_id,
				'filter_status' => $filter_status,
				'sort'  => $sort,
				'order' => $order,
				'start' => ($page - 1) * $this->config->get('config_admin_limit'),
				'limit' => $this->config->get('config_admin_limit')
			);
			
			$faq_total = $this->model_simple_support_faq->getTotalFaqs($filter_data);
			
			$results = $this->model_simple_support_faq->getFaqs($filter_data);
			
			foreach ($results as $result) {
							
				$data['faqs'][] = array(
					'simple_support_faq_id' => $result['simple_support_faq_id'],
					'question'              => $result['question'],
					'group_name'            => $result['group_name'],
					'sort_order'        	=> $result['sort_order'],
					'status'     			=> ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
					'selected'          	=> isset($this->request->post['selected']) && in_array($result['simple_support_faq_id'], $this->request->post['selected']),
					'edit'                  => $this->url->link('simple_support/faq/update', 'token=' . $this->session->data['token'] . '&simple_support_faq_id=' . $result['simple_support_faq_id'] . $url, 'SSL')
				);
			}	
			
			$data['heading_title'] = $this->language->get('heading_title');
			
			$data['text_enabled'] = $this->language->get('text_enabled');
			$data['text_disabled'] = $this->language->get('text_disabled');
			$data['text_no_results'] = $this->language->get('text_no_results');
            $data['text_confirm'] = $this->language->get('text_confirm');
	
			$data['column_faq_question'] = $this->language->get('column_faq_question');
			$data['column_faq_group_name'] = $this->language->get('column_faq_group_name');
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
			
			if (isset($this->request->get['filter_question'])) {
				$url .= '&filter_question=' . $this->request->get['filter_question'];
			}
			
			if (isset($this->request->get['filter_group_id'])) {
				$url .= '&filter_group_id=' . $this->request->get['filter_group_id'];
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
	
			$data['sort_question'] = $this->url->link('simple_support/faq', 'token=' . $this->session->data['token'] . '&sort=ssfd.question' . $url, 'SSL');
			$data['sort_group'] = $this->url->link('simple_support/faq', 'token=' . $this->session->data['token'] . '&sort=ssfgd.name' . $url, 'SSL');
			$data['sort_sortorder'] = $this->url->link('simple_support/faq', 'token=' . $this->session->data['token'] . '&sort=ssf.sort_order' . $url, 'SSL');
			$data['sort_status'] = $this->url->link('simple_support/faq', 'token=' . $this->session->data['token'] . '&sort=ssf.status' . $url, 'SSL');
	
			$url = '';
			
			if (isset($this->request->get['filter_question'])) {
				$url .= '&filter_question=' . $this->request->get['filter_question'];
			}
			
			if (isset($this->request->get['filter_group_id'])) {
				$url .= '&filter_group_id=' . $this->request->get['filter_group_id'];
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
			$pagination->total = $faq_total;
			$pagination->page = $page;
			$pagination->limit = $this->config->get('config_admin_limit');
			$pagination->text = $this->language->get('text_pagination');
			$pagination->url = $this->url->link('simple_support/faq', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
	
			$data['pagination'] = $pagination->render();
			
            $data['results'] = sprintf($this->language->get('text_pagination'), ($faq_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($faq_total - $this->config->get('config_limit_admin'))) ? $faq_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $faq_total, ceil($faq_total / $this->config->get('config_limit_admin')));
            
			$data['filter_question'] = $filter_question;
			$data['filter_group_id'] = $filter_group_id;
			$data['filter_status'] = $filter_status;
			$data['sort'] = $sort;
			$data['order'] = $order;
	        
            $data['header'] = $this->load->controller('common/header');
  		    $data['column_left'] = $this->load->controller('common/column_left');
            $data['footer'] = $this->load->controller('common/footer');
    
            $this->response->setOutput($this->load->view('simple_support/faq_list.tpl', $data));  
            
		}		

		public function getForm() {
			$data['heading_title'] = $this->language->get('heading_title');
			
            $data['text_form'] = !isset($this->request->get['simple_support_faq_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
            
			$data['text_enabled'] = $this->language->get('text_enabled');
			$data['text_disabled'] = $this->language->get('text_disabled');
			$data['text_none'] = $this->language->get('text_none');
			$data['text_select'] = $this->language->get('text_select');
			$data['text_default'] = $this->language->get('text_default');
			$data['text_select_all'] = $this->language->get('text_select_all');
			$data['text_unselect_all'] = $this->language->get('text_unselect_all');
			
			$data['entry_question'] = $this->language->get('entry_question');
			$data['entry_answer'] = $this->language->get('entry_answer');
			$data['entry_meta_description'] = $this->language->get('entry_meta_description');
			$data['entry_meta_keyword'] = $this->language->get('entry_meta_keyword');
			$data['entry_status'] = $this->language->get('entry_status');
			$data['entry_faq_group'] = $this->language->get('entry_faq_group');
			$data['entry_sort_order'] = $this->language->get('entry_sort_order');			
			$data['entry_store'] = $this->language->get('entry_store');
			
			$data['tab_general'] = $this->language->get('tab_general');
			$data['tab_data'] = $this->language->get('tab_data');
			
			$data['button_save'] = $this->language->get('button_save');
			$data['button_cancel'] = $this->language->get('button_cancel');	
			
			$data['token'] = $this->session->data['token'];
			
            if(isset($this->request->get['simple_support_faq_id'])) {
                $data['simple_support_faq_id'] = $this->request->get['simple_support_faq_id'];
            } else {
                $data['simple_support_faq_id'] = 0;
            }
            
			if (isset($this->error['warning'])) {
				$data['error_warning'] = $this->error['warning'];
			} else {
				$data['error_warning'] = '';
			}
	
			if (isset($this->error['question'])) {
				$data['error_question'] = $this->error['question'];
			} else {
				$data['error_question'] = array();
			}
			
			if (isset($this->error['answer'])) {
				$data['error_answer'] = $this->error['answer'];
			} else {
				$data['error_answer'] = array();
			}

			if (isset($this->error['store'])) {
				$data['error_store'] = $this->error['store'];
			} else {
				$data['error_store'] = '';
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
				'href'      => $this->url->link('simple_support/faq', 'token=' . $this->session->data['token'] . $url, 'SSL'),
				'separator' => ' :: '
			);
			
			if (!isset($this->request->get['simple_support_faq_id'])) {
				$data['action'] = $this->url->link('simple_support/faq/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
			} else {
				$data['action'] = $this->url->link('simple_support/faq/update', 'token=' . $this->session->data['token'] . '&simple_support_faq_id=' . $this->request->get['simple_support_faq_id'] . $url, 'SSL');
			}
			
			$data['cancel'] = $this->url->link('simple_support/faq', 'token=' . $this->session->data['token'] . $url, 'SSL');
			
			if (isset($this->request->get['simple_support_faq_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
				$faq_info = $this->model_simple_support_faq->getFaqInfo($this->request->get['simple_support_faq_id']);
			}
			
			$this->load->model('localisation/language');
	
			$data['languages'] = $this->model_localisation_language->getLanguages();
			
			if (isset($this->request->post['faq_description'])) {
				$data['faq_description'] = $this->request->post['faq_description'];
			} elseif (isset($this->request->get['simple_support_faq_id'])) {
				$data['faq_description'] = $this->model_simple_support_faq->getFaqDescriptions($this->request->get['simple_support_faq_id']);
			} else {
				$data['faq_description'] = array();
			}
			
			$this->load->model('simple_support/faq_group');
					
			$data['faq_groups'] = $this->model_simple_support_faq_group->getFaqGroups();	
			
			if (isset($this->request->post['simple_support_faq_group_id'])) {
				$data['simple_support_faq_group_id'] = $this->request->post['simple_support_faq_group_id'];
			} elseif (!empty($faq_info)) {
				$data['simple_support_faq_group_id'] = $faq_info['simple_support_faq_group_id'];
			} else {
				$data['simple_support_faq_group_id'] = '';
			}
			
			if (isset($this->request->post['sort_order'])) {
				$data['sort_order'] = $this->request->post['sort_order'];
			} elseif (!empty($faq_info)) {
				$data['sort_order'] = $faq_info['sort_order'];
			} else {
				$data['sort_order'] = '';
			}
			
			if (isset($this->request->post['status'])) {
				$data['status'] = $this->request->post['status'];
			} elseif (!empty($faq_info)) {
				$data['status'] = $faq_info['status'];
			} else {
				$data['status'] = 0;
			}
			
			$this->load->model('setting/store');

			$data['stores'] = $this->model_setting_store->getStores();
			
			if (isset($this->request->post['faq_to_store'])) {
				$data['faq_to_store'] = $this->request->post['faq_to_store'];
			} elseif (isset($this->request->get['simple_support_faq_id'])) {
				$data['faq_to_store'] = $this->model_simple_support_faq->getFaqStore($this->request->get['simple_support_faq_id']);
			} else {
				$data['faq_to_store'] = array(0);
			}	
					
            $data['header'] = $this->load->controller('common/header');
  		    $data['column_left'] = $this->load->controller('common/column_left');
            $data['footer'] = $this->load->controller('common/footer');
    
            $this->response->setOutput($this->load->view('simple_support/faq_form.tpl', $data));  
		}
		
		public function autocomplete() {
			$json = array();
			
			$this->load->model('simple_support/faq');
			
			if(isset($this->request->get['filter_question'])) {
				$filter_question = $this->request->get['filter_question'];
			} else {
				$filter_question = '';
			}
			
            if($filter_question) {
                $data = array('filter_question' => $filter_question);
			
    			$results = $this->model_simple_support_faq->getFaqs($data);
    			
    			foreach ($results as $result) {
    				$json[] = array(
    					'simple_support_faq_id' => $result['simple_support_faq_id'],
    					'question'       => strip_tags(html_entity_decode($result['question'], ENT_QUOTES, 'UTF-8'))
    				);
    			}    
            }
			
            $this->response->addHeader('Content-Type: application/json');
            $this->response->setOutput(json_encode($json));
		}
		
		protected function validateForm() {
            
            //print "<pre>"; print_r($this->request->post); die;
            
			if (!$this->user->hasPermission('modify', 'simple_support/faq')) {
				$this->error['warning'] = $this->language->get('error_permission');
			}
			
			foreach ($this->request->post['faq_description'] as $language_id => $value) {
				if ((utf8_strlen($value['question']) < 3) || (utf8_strlen($value['question']) > 255)) {
					$this->error['question'][$language_id] = $this->language->get('error_question');
				}
				
				if (strip_tags((utf8_strlen($value['answer']) < 3))) {
					$this->error['answer'][$language_id] = $this->language->get('error_answer');
				}				
			}

			if(!isset($this->request->post['faq_to_store'])) {
				$this->error['store'] = $this->language->get('error_store');
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
			if (!$this->user->hasPermission('modify', 'simple_support/faq')) {
				$this->error['warning'] = $this->language->get('error_permission');
			}
	
			if (!$this->error) {
				return true;
			} else {
				return false;
			}
		}			
	}
?>