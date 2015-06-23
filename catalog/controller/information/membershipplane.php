<?php
class ControllerInformationMembershipPlane extends Controller {
	public function index() {
		$this->load->language('information/information');

		$this->load->model('catalog/information');
                
                
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);
                $this->request->get['information_id'] = 14;    
		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}

		
                
                
                $data['txt_btn_membership'] = $this->language->get('txt_btn_membership');
                $data['link_btn_membership'] = $this->url->link('information/information', 'information_id=' .  14);
                
                $data['config_promote_get_started'] = $this->config->get('config_promote_get_started');
                $data['link_get_started'] = $this->url->link('account/login');
                
                $data['config_promote_contact'] = html_entity_decode($this->config->get('config_promote_contact'), ENT_QUOTES, 'UTF-8');
               
                $this->load->model('extension/package');
                $trial = 0;
                if ($this->customer->isLogged()) {
                    $trial = 1;
                }
                $data['packages'] = $this->model_extension_package->getAllPackagePlan($trial);
                $data['package_modules'] = $this->model_extension_package->getAllModules();    
                
                if ($this->config->get('msconf_seller_terms_page')) {
                    $this->load->model('catalog/information');
                    $information_info = $this->model_catalog_information->getInformation($this->config->get('msconf_seller_terms_page'));
                    $information_info_terms = $this->model_catalog_information->getInformation($this->config->get('msconf_seller_terms_use_page'));

                    if ($information_info) {
                        $data['seller_terms'] = str_replace('%s','',$this->language->get('ms_account_sellerinfo_terms_note')).' <a href="'.$this->url->link('information/information/agree', 'information_id=' . $this->config->get('msconf_seller_terms_use_page'), 'SSL').'" class="agree">'.$information_info_terms['title'].'</a> and <a href="'.$this->url->link('information/information/agree', 'information_id=' . $this->config->get('msconf_seller_terms_page'), 'SSL').'" class="agree">'.$information_info['title'].'</a>'; 
                        $data['seller_terms_warning'] = 'You must agree to the '.$information_info_terms['title'].' and '.$information_info['title'];
                        
                    }
                }
               
                $information_info = $this->model_catalog_information->getInformation(14);
                
		if ($information_info) {
			$this->document->setTitle($information_info['meta_title']);
			$this->document->setDescription($information_info['meta_description']);
			$this->document->setKeywords($information_info['meta_keyword']);

			$data['breadcrumbs'][] = array(
				'text' => $information_info['title'],
				'href' => $this->url->link('information/information', 'information_id=' .  $information_id)
			);

			$data['heading_title'] = $information_info['title'];

			$data['button_continue'] = $this->language->get('button_continue');

			$data['description'] = html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8');

			$data['continue'] = $this->url->link('common/home');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/membershipplane.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/information/membershipplane.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/information/membershipplane.tpl', $data));
			}
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('information/information', 'information_id=' . $information_id)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $data));
			}
		}
	}
 
	
}