<?php
	class ControllerSimpleSupportAdminTicket extends Controller {
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
       	    $this->language->load('simple_support/admin_ticket');

			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/admin_ticket');
	
			$this->getList();
        }
        
		public function insert() {
			$this->language->load('simple_support/admin_ticket');
	
			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/admin_ticket');
	
			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {				
                //print "<pre>"; print_r($this->request->post); exit;                
				$this->model_simple_support_admin_ticket->addticket($this->request->post);
	
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
	
				$this->response->redirect($this->url->link('simple_support/admin_ticket', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
	
			$this->getForm();
		}
	
		public function update() {
			$this->language->load('simple_support/admin_ticket');
	
			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/admin_ticket');
	
			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
				//print "<pre>"; print_r($this->request->post); exit;
				$this->model_simple_support_admin_ticket->editTicket($this->request->get['simple_support_ticket_id'], $this->request->post);
	
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
	
				$this->response->redirect($this->url->link('simple_support/admin_ticket', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
	
			$this->getForm();
		}
	
		public function delete() {
			$this->language->load('simple_support/admin_ticket');
	
			$this->document->setTitle($this->language->get('heading_title'));
	
			$this->load->model('simple_support/admin_ticket');
	
			if (isset($this->request->post['selected']) && $this->validateDelete()) {
				foreach ($this->request->post['selected'] as $simple_support_ticket_id) {
					$this->model_simple_support_admin_ticket->deleteticket($simple_support_ticket_id);
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
	
				$this->response->redirect($this->url->link('simple_support/admin_ticket', 'token=' . $this->session->data['token'] . $url, 'SSL'));
			}
	
			$this->getList();
		}
		
		public function getList() {
			
			if (isset($this->request->get['view_all'])) {
				$view_all = $this->request->get['view_all'];
			} else {
				$view_all = '';
			}
			
			if (isset($this->request->get['sort'])) {
				$sort = $this->request->get['sort'];
			} else {
				$sort = 'sst.date_modified';
			}
	
			if (isset($this->request->get['order'])) {
				$order = $this->request->get['order'];
			} else {
				$order = 'DESC';
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
			
			if (isset($this->request->get['view_all'])) {
				$url .= '&view_all=' . $this->request->get['view_all'];
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
				'href'      => $this->url->link('simple_support/admin_ticket', 'token=' . $this->session->data['token'] . $url, 'SSL'),
				'separator' => ' :: '
			);
			
			$simple_support_ticket_permission = array();
			
			if($this->config->get('simple_support_ticket_permission')) {
				$simple_support_ticket_permission = $this->config->get('simple_support_ticket_permission');
				
                $this->load->model('user/user');
                
                $user_group_info = $this->model_user_user->getUser($this->user->getId());
                
				if(in_array($user_group_info['user_group_id'], $simple_support_ticket_permission)) {
					$data['found_user_view_all'] = 1;
					$data['view_all_ticket'] = $this->url->link('simple_support/admin_ticket', 'token=' . $this->session->data['token'] . '&view_all=1', 'SSL');
				}	
			}
			
			$data['insert'] = $this->url->link('simple_support/admin_ticket/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
			$data['delete'] = $this->url->link('simple_support/admin_ticket/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	
			
			$this->load->model('simple_support/status');
			
			$data['tickets'] = array();
			
			$filter_data = array(
				'view_all'	=> $view_all,
				'sort'  => $sort,
				'order' => $order,
				'start' => ($page - 1) * $this->config->get('config_admin_limit'),
				'limit' => $this->config->get('config_admin_limit')
			);
			
			$ticket_total = $this->model_simple_support_admin_ticket->getTotalTickets($filter_data);
			
			$results = $this->model_simple_support_admin_ticket->getTickets($filter_data);
			
			foreach ($results as $result) {
					
				$ticket_status_info = $this->model_simple_support_status->getTicketStatus($result['simple_support_ticket_status_id']);
				
				$data['tickets'][] = array(
					'simple_support_ticket_id'		=> $result['simple_support_ticket_id'],
					'username'            			=> $result['user_name'],
					'useremail'            			=> $result['user_email'],
					'ticket_id'						=> $result['ticket_id'],
					'subject'						=> $result['subject'],
					'ticket_status'					=> $ticket_status_info['name'],
					'status'						=> ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
					'date_added'					=> date($this->language->get('date_format_short'), strtotime($result['date_added'])),
					'date_modified'					=> date($this->language->get('date_format_short'), strtotime($result['date_modified'])),
					'selected'        				=> isset($this->request->post['selected']) && in_array($result['simple_support_ticket_id'], $this->request->post['selected']),
					'edit'          				=> $this->url->link('simple_support/admin_ticket/update', 'token=' . $this->session->data['token'] . '&simple_support_ticket_id=' . $result['simple_support_ticket_id'] . $url, 'SSL')
				);
			}	
			
			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_no_results'] = $this->language->get('text_no_results');
	
			$data['column_ticket'] = $this->language->get('column_ticket');
			$data['column_username'] = $this->language->get('column_username');
			$data['column_useremail'] = $this->language->get('column_useremail');
			$data['column_subject'] = $this->language->get('column_subject');
			$data['column_ticket_status'] = $this->language->get('column_ticket_status');
			$data['column_status'] = $this->language->get('column_status');
			$data['column_date_added'] = $this->language->get('column_date_added');
			$data['column_date_modified'] = $this->language->get('column_date_modified');
			$data['column_action'] = $this->language->get('column_action');		
	
			$data['button_insert'] = $this->language->get('button_insert');
			$data['button_delete'] = $this->language->get('button_delete');
			$data['button_view_all'] = $this->language->get('button_view_all');
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
			
			if (isset($this->request->get['view_all'])) {
				$url .= '&view_all=' . $this->request->get['view_all'];
			}
			
			if ($order == 'ASC') {
				$url .= '&order=DESC';
			} else {
				$url .= '&order=ASC';
			}
	
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
	
			$data['sort_ticket'] = $this->url->link('simple_support/admin_ticket', 'token=' . $this->session->data['token'] . '&sort=sst.ticket_id' . $url, 'SSL');
			$data['sort_subject'] = $this->url->link('simple_support/admin_ticket', 'token=' . $this->session->data['token'] . '&sort=sst.subject' . $url, 'SSL');
			$data['sort_ticket_status'] = $this->url->link('simple_support/admin_ticket', 'token=' . $this->session->data['token'] . '&sort=sst.simple_support_ticket_status_id' . $url, 'SSL');
			$data['sort_status'] = $this->url->link('simple_support/admin_ticket', 'token=' . $this->session->data['token'] . '&sort=sst.status' . $url, 'SSL');
			$data['sort_date_added'] = $this->url->link('simple_support/admin_ticket', 'token=' . $this->session->data['token'] . '&sort=sst.date_added' . $url, 'SSL');
			$data['sort_date_modified'] = $this->url->link('simple_support/admin_ticket', 'token=' . $this->session->data['token'] . '&sort=sst.date_modified' . $url, 'SSL');
	
			$url = '';
			
			if (isset($this->request->get['view_all'])) {
				$url .= '&view_all=' . $this->request->get['view_all'];
			}
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}
	
			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
	
			$pagination = new Pagination();
			$pagination->total = $ticket_total;
			$pagination->page = $page;
			$pagination->limit = $this->config->get('config_admin_limit');
			$pagination->text = $this->language->get('text_pagination');
			$pagination->url = $this->url->link('simple_support/admin_ticket', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
	
			$data['pagination'] = $pagination->render();
			
            $data['results'] = sprintf($this->language->get('text_pagination'), ($ticket_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($ticket_total - $this->config->get('config_limit_admin'))) ? $ticket_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $ticket_total, ceil($ticket_total / $this->config->get('config_limit_admin')));
            
			$data['view_all'] = $view_all;
			$data['sort'] = $sort;
			$data['order'] = $order;
            
            $data['header'] = $this->load->controller('common/header');
  		    $data['column_left'] = $this->load->controller('common/column_left');
            $data['footer'] = $this->load->controller('common/footer');
    
            $this->response->setOutput($this->load->view('simple_support/admin_ticket_list.tpl', $data));
		}	

		public function getForm() {
			$data['heading_title'] = $this->language->get('heading_title');
			
            $data['text_form'] = !isset($this->request->get['simple_support_ticket_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
            
			$data['text_enabled'] = $this->language->get('text_enabled');
			$data['text_disabled'] = $this->language->get('text_disabled');
			$data['text_notify_customer'] = $this->language->get('text_notify_customer');
			$data['text_select_department'] = $this->language->get('text_select_department');
			$data['text_select_user'] = $this->language->get('text_select_user');
            $data['text_loading'] = $this->language->get('text_loading');
            $data['text_default_status_text'] = $this->language->get('text_default_status_text');
			
			$data['entry_customer'] = $this->language->get('entry_customer');
			$data['entry_subject'] = $this->language->get('entry_subject');
			$data['entry_ticket_id'] = $this->language->get('entry_ticket_id');
			$data['entry_ticket_status'] = $this->language->get('entry_ticket_status');
			$data['entry_department'] = $this->language->get('entry_department');
			$data['entry_date_added'] = $this->language->get('entry_date_added');
			$data['entry_date_modified'] = $this->language->get('entry_date_modified');
			$data['entry_status'] = $this->language->get('entry_status');
			$data['entry_description'] = $this->language->get('entry_description');
			$data['entry_file'] = $this->language->get('entry_file');
			$data['entry_add_other'] = $this->language->get('entry_add_other');
			$data['entry_assign_ticket'] = $this->language->get('entry_assign_ticket');
			$data['entry_current_status'] = $this->language->get('entry_current_status');
			$data['entry_assign_user'] = $this->language->get('entry_assign_user');
            $data['entry_file'] = $this->language->get('entry_file');
			
			$data['tab_general'] = $this->language->get('tab_general');
			$data['tab_history'] = $this->language->get('tab_history');
			
			$data['button_save'] = $this->language->get('button_save');
			$data['button_cancel'] = $this->language->get('button_cancel');	
			
			$data['token'] = $this->session->data['token'];
			
			if(isset($this->request->get['simple_support_ticket_id'])) {
				$data['simple_support_ticket_id'] = $this->request->get['simple_support_ticket_id'];
			} else {
				$data['simple_support_ticket_id'] = 0;	
			}
			
			if (isset($this->error['warning'])) {
				$data['error_warning'] = $this->error['warning'];
			} else {
				$data['error_warning'] = '';
			}
			
			if (isset($this->error['subject'])) {
				$data['error_subject'] = $this->error['subject'];
			} else {
				$data['error_subject'] = '';
			}
			
			if (isset($this->error['description'])) {
				$data['error_description'] = $this->error['description'];
			} else {
				$data['error_description'] = '';
			}
			
			if (isset($this->error['department_id'])) {
				$data['error_department_id'] = $this->error['department_id'];
			} else {
				$data['error_department_id'] = '';
			}
			
			if (isset($this->error['user_id'])) {
				$data['error_user_id'] = $this->error['user_id'];
			} else {
				$data['error_user_id'] = '';
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
				'href'      => $this->url->link('simple_support/admin_ticket', 'token=' . $this->session->data['token'] . $url, 'SSL'),
				'separator' => ' :: '
			);
			
			$this->load->model('sale/customer');
			
			$this->load->model('simple_support/status');
			$data['ticket_status'] = $this->model_simple_support_status->getStatues();
			
			$data['departments'] = $this->model_simple_support_admin_ticket->getDepartments();
			
			if (!isset($this->request->get['simple_support_ticket_id'])) {
				$data['action'] = $this->url->link('simple_support/admin_ticket/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
			} else {
				$data['action'] = $this->url->link('simple_support/admin_ticket/update', 'token=' . $this->session->data['token'] . '&simple_support_ticket_id=' . $this->request->get['simple_support_ticket_id'] . $url, 'SSL');
			}
			
			$data['cancel'] = $this->url->link('simple_support/admin_ticket', 'token=' . $this->session->data['token'] . $url, 'SSL');
			
			$this->load->model('simple_support/status');
			$this->load->model('simple_support/department');
			$this->load->model('user/user');
			
			if (isset($this->request->get['simple_support_ticket_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
				$ticket_info = $this->model_simple_support_admin_ticket->getTicketInfo($this->request->get['simple_support_ticket_id']);
			}
			
			if(isset($this->request->get['simple_support_ticket_id'])) {
				$ticket_info_found = $this->model_simple_support_admin_ticket->getTicketInfo($this->request->get['simple_support_ticket_id']);
				
				$data['main_description'] = $ticket_info_found['description'];
				
				$data['status_name'] = $this->model_simple_support_status->getTicketStatus($ticket_info_found['simple_support_ticket_status_id']);
				
				$data['user'] = $this->model_user_user->getUser($ticket_info_found['user_id']);
			}
			
			if (isset($this->request->post['ticket_id'])) {
				$data['ticket_id'] = $this->request->post['ticket_id'];
			} elseif (!empty($ticket_info)) {
				$data['ticket_id'] = $ticket_info['ticket_id'];
			} else {
				$data['ticket_id'] = '';
			}
			
			if (isset($this->request->post['subject'])) {
				$data['subject'] = $this->request->post['subject'];
			} elseif (!empty($ticket_info)) {
				$data['subject'] = $ticket_info['subject'];
			} else {
				$data['subject'] = '';
			}
			
			if (isset($this->request->post['description'])) {
				$data['description'] = $this->request->post['description'];
			} else {
				$data['description'] = '';
			}
			
			if (isset($this->request->post['user_id'])) {
				$data['user_id'] = $this->request->post['user_id'];
			} elseif (!empty($ticket_info)) {
				$data['user_id'] = $ticket_info['user_id'];
			} else {
				$data['user_id'] = 0;
			}
			
			if (isset($this->request->post['simple_support_department_id'])) {
				$data['simple_support_department_id'] = $this->request->post['simple_support_department_id'];
			} elseif (!empty($ticket_info)) {
				$data['simple_support_department_id'] = $ticket_info['simple_support_department_id'];
			} else {
				$data['simple_support_department_id'] = '';
			}
			
			if (isset($this->request->post['simple_support_ticket_status_id'])) {
				$data['simple_support_ticket_status_id'] = $this->request->post['simple_support_ticket_status_id'];
			} elseif (!empty($ticket_info)) {
				$data['simple_support_ticket_status_id'] = $ticket_info['simple_support_ticket_status_id'];
			} else {
				$data['simple_support_ticket_status_id'] = '';
			}
			
			if (isset($this->request->post['status'])) {
				$data['status'] = $this->request->post['status'];
			} elseif (!empty($ticket_info)) {
				$data['status'] = $ticket_info['status'];
			} else {
				$data['status'] = 0;
			}
			
			if (isset($this->request->post['date_added'])) {
				$data['date_added'] = $this->request->post['date_added'];
			} elseif (!empty($ticket_info)) {
				$data['date_added'] = date($this->language->get('date_format_long'), strtotime($ticket_info['date_added']));
			} else {
				$data['date_added'] = '';
			}

			if (isset($this->request->post['date_modified'])) {
				$data['date_modified'] = $this->request->post['date_modified'];
			} elseif (!empty($ticket_info)) {
				$data['date_modified'] = date($this->language->get('date_format_long'), strtotime($ticket_info['date_modified']));;
			} else {
				$data['date_modified'] = '';
			}
			
            $data['header'] = $this->load->controller('common/header');
  		    $data['column_left'] = $this->load->controller('common/column_left');
            $data['footer'] = $this->load->controller('common/footer');
    
            $this->response->setOutput($this->load->view('simple_support/admin_ticket_form.tpl', $data));	
		}
		
		public function validateForm() {
			//return true;
			
			if (!$this->user->hasPermission('modify', 'simple_support/admin_ticket')) {
				$this->error['warning'] = $this->language->get('error_permission');
			}
			
            if((utf8_strlen($this->request->post['subject']) < 3) || (utf8_strlen($this->request->post['subject']) > 256)) {
				$this->error['subject'] = $this->language->get('error_subject');
			}
            
			if(utf8_strlen($this->request->post['description']) < 3) {
				$this->error['description'] = $this->language->get('error_description');
				$this->error['warning'] = $this->language->get('error_ticket_description');
			}	
			
			if(!$this->request->post['simple_support_department_id']) {
				$this->error['department_id'] = $this->language->get('error_department_id');
			} else {
				if(!isset($this->request->post['user_id']) || !$this->request->post['user_id']) {
					$this->error['user_id'] = $this->language->get('error_user_id');
				}
			}			
			
			if ($this->error && !isset($this->error['warning'])) {
				$this->error['warning'] = $this->language->get('error_warning');
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
		
		public function validateDelete() {
			if (!$this->user->hasPermission('modify', 'simple_support/admin_ticket')) {
				$this->error['warning'] = $this->language->get('error_permission');
			}
			
			if (!$this->error) {
				return true;
			} else {
				return false;
			}	
		}
		
		public function history() {
			$this->language->load('simple_support/admin_ticket');
		
			$this->load->model('simple_support/admin_ticket');
			$this->load->model('user/user');
			$this->load->model('sale/customer');
					
			$data['text_no_results'] = $this->language->get('text_no_results');
			
			if (isset($this->request->get['page'])) {
				$page = $this->request->get['page'];
			} else {
				$page = 1;
			}  
			
			$data['histories'] = array();
				
			$results = $this->model_simple_support_admin_ticket->getTicketHistories($this->request->get['simple_support_ticket_id'], ($page - 1) * 10, 10);
	      		
			foreach ($results as $result) {
				
				if($result['customer_id']) {
					$info = $this->model_sale_customer->getCustomer($result['customer_id']);
					$customer_name = $info['firstname'] . " " . $info['lastname'];
                    $name = 'Customer(' . $customer_name . ')';		
				} else {
					$info = $this->model_user_user->getUser($result['user_id']);
					$admin_name = $info['firstname'] . " " . $info['lastname'];
                    $name = 'Admin(' . $admin_name . ')';
				}
				
				$images = $this->model_simple_support_admin_ticket->getImages($result['simple_support_ticket_history_id']);
				
				$ticket_images = array();
				
				foreach($images as $image) {
					$ticket_images[] = array(
						'value' => utf8_substr($image['image'], 0, utf8_strrpos($image['image'], '.')),
						'href'  => $this->url->link('simple_support/admin_ticket/download', 'token=' . $this->session->data['token'] . '&simple_support_ticket_images_id=' . $image['simple_support_ticket_images_id'], 'SSL')
					);					
				}
				
	        	$data['histories'][] = array(
					'simple_support_ticket_history_id'   	=> $result['simple_support_ticket_history_id'],
					'name'   								=> $name,
					'ticket_images'							=> $ticket_images,
					'description'							=> $result['description'],
	        		'date_added' 							=> date($this->language->get('date_format_long'), strtotime($result['date_added']))
	        	);
	      	}			
			
			//print "<pre>"; print_r($data['histories']); print "</pre>";
			
			$history_total = $this->model_simple_support_admin_ticket->getTotalTicketHistories($this->request->get['simple_support_ticket_id']);
				
			$pagination = new Pagination();
			$pagination->total = $history_total;
			$pagination->page = $page;
			$pagination->limit = 10; 
			$pagination->url = $this->url->link('simple_support/admin_ticket/history', 'token=' . $this->session->data['token'] . '&simple_support_ticket_id=' . $this->request->get['simple_support_ticket_id'] . '&page={page}', 'SSL');
				
			$data['pagination'] = $pagination->render();
			
            $data['results'] = sprintf($this->language->get('text_pagination'), ($history_total) ? (($page - 1) * 10) + 1 : 0, ((($page - 1) * 10) > ($history_total - 10)) ? $history_total : ((($page - 1) * 10) + 10), $history_total, ceil($history_total / 10));

            $this->response->setOutput($this->load->view('simple_support/ticket_history.tpl', $data));
            
		}
		
        
        public function upload() {
    		$this->load->language('simple_support/admin_ticket');
    
    		$json = array();
    
    		if (!empty($this->request->files['file']['name']) && is_file($this->request->files['file']['tmp_name'])) {
    			// Sanitize the filename
    			$filename = basename(preg_replace('/[^a-zA-Z0-9\.\-\s+]/', '', html_entity_decode($this->request->files['file']['name'], ENT_QUOTES, 'UTF-8')));
    
    			// Validate the filename length
    			if ((utf8_strlen($filename) < 3) || (utf8_strlen($filename) > 64)) {
    				$json['error'] = $this->language->get('error_filename');
    			}
    
    			// Allowed file extension types
    			$allowed = array();
    
    			$extension_allowed = preg_replace('~\r?\n~', "\n", $this->config->get('config_file_ext_allowed'));
    
    			$filetypes = explode("\n", $extension_allowed);
    
    			foreach ($filetypes as $filetype) {
    				$allowed[] = trim($filetype);
    			}
    
    			if (!in_array(strtolower(substr(strrchr($filename, '.'), 1)), $allowed)) {
    				$json['error'] = $this->language->get('error_filetype');
    			}
    
    			// Allowed file mime types
    			$allowed = array();
    
    			$mime_allowed = preg_replace('~\r?\n~', "\n", $this->config->get('config_file_mime_allowed'));
    
    			$filetypes = explode("\n", $mime_allowed);
    
    			foreach ($filetypes as $filetype) {
    				$allowed[] = trim($filetype);
    			}
    
    			if (!in_array($this->request->files['file']['type'], $allowed)) {
    				$json['error'] = $this->language->get('error_filetype');
    			}
    
    			// Check to see if any PHP files are trying to be uploaded
    			$content = file_get_contents($this->request->files['file']['tmp_name']);
    
    			if (preg_match('/\<\?php/i', $content)) {
    				$json['error'] = $this->language->get('error_filetype');
    			}
    
    			// Return any upload error
    			if ($this->request->files['file']['error'] != UPLOAD_ERR_OK) {
    				$json['error'] = $this->language->get('error_upload_' . $this->request->files['file']['error']);
    			}
    		} else {
    			$json['error'] = $this->language->get('error_upload');
    		}
    
    		if (!$json) {
    			$file = $filename . '.' . md5(mt_rand());
    
    			move_uploaded_file($this->request->files['file']['tmp_name'], DIR_UPLOAD . $file);
    
    			// Hide the uploaded file name so people can not link to it directly.
    			$this->load->model('tool/upload');
    
    			$json['code'] = $this->model_tool_upload->addUpload($filename, $file);
    
    			$json['success'] = $this->language->get('text_upload');
                
                $json['filename'] = $filename;
                
                $json['file']= $file;
    		}
    
    		$this->response->addHeader('Content-Type: application/json');
    		$this->response->setOutput(json_encode($json));
    	}
        
		public function download() {
			$this->load->model('simple_support/admin_ticket');
	
			if (isset($this->request->get['simple_support_ticket_images_id'])) {
				$simple_support_ticket_images_id = $this->request->get['simple_support_ticket_images_id'];
			} else {
				$simple_support_ticket_images_id = 0;
			}
	
			$images_info = $this->model_simple_support_admin_ticket->getTicketImage($this->request->get['simple_support_ticket_images_id']);
	
			if ($images_info) {
				$file = DIR_UPLOAD . $images_info['image'];
				$mask = basename(utf8_substr($images_info['image'], 0, utf8_strrpos($images_info['image'], '.')));
	
				if (!headers_sent()) {
					if (file_exists($file)) {
						header('Content-Type: application/octet-stream');
						header('Content-Description: File Transfer');
						header('Content-Disposition: attachment; filename="' . ($mask ? $mask : basename($file)) . '"');
						header('Content-Transfer-Encoding: binary');
						header('Expires: 0');
						header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
						header('Pragma: public');
						header('Content-Length: ' . filesize($file));
	
						readfile($file, 'rb');
						exit;
					} else {
						exit('Error: Could not find file ' . $file . '!');
					}
				} else {
					exit('Error: Headers already sent out!');
				}
			} else {
				$this->language->load('error/not_found');
	
				$this->document->setTitle($this->language->get('heading_title'));
	
				$data['heading_title'] = $this->language->get('heading_title');
	
				$data['text_not_found'] = $this->language->get('text_not_found');
	
				$data['breadcrumbs'] = array();
	
				$data['breadcrumbs'][] = array(
					'text'      => $this->language->get('text_home'),
					'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
					'separator' => false
				);
	
				$data['breadcrumbs'][] = array(
					'text'      => $this->language->get('heading_title'),
					'href'      => $this->url->link('error/not_found', 'token=' . $this->session->data['token'], 'SSL'),
					'separator' => ' :: '
				);
                
                $data['header'] = $this->load->controller('common/header');
      		    $data['column_left'] = $this->load->controller('common/column_left');
                $data['footer'] = $this->load->controller('common/footer');
    
                $this->response->setOutput($this->load->view('error/not_found.tpl', $data));
			}
		}
		
		public function departmentUser() {
			$json = array();
			
			$this->load->model('simple_support/admin_ticket');
			
			if(isset($this->request->get['department_id'])) {
				$department_id = $this->request->get['department_id'];
			} else {
				$department_id = '';
			}
			
			$results = $this->model_simple_support_admin_ticket->getDepartmentWiseUser($department_id);
			
			$json = array(
				'users'	=> $results
			);			
			
			$this->response->setOutput(json_encode($json));
		}	
	}
?>