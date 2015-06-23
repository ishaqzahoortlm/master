<?php
class ControllerInformationPromote extends Controller {
	public function index() {
		$this->load->language('information/information');

		$this->load->model('catalog/information');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);
                $this->request->get['information_id'] = 13;    
		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}

		$information_info = $this->model_catalog_information->getInformationCustom(13);
                
                $data['config_promote_title'] = $this->config->get('config_promote_title');
                $data['config_promote_how_works'] = $this->config->get('config_promote_how_works');
                
                $data['config_promote_step_1_title'] = $this->config->get('config_promote_step_1_title');
                $data['config_promote_step_1_detail'] = html_entity_decode($this->config->get('config_promote_step_1_detail'), ENT_QUOTES, 'UTF-8');
                $data['config_promote_step_1_icon'] = $this->config->get('config_promote_step_1_icon');
                
                $data['config_promote_step_2_title'] = $this->config->get('config_promote_step_2_title');
                $data['config_promote_step_2_detail'] = html_entity_decode($this->config->get('config_promote_step_2_detail'), ENT_QUOTES, 'UTF-8');
                $data['config_promote_step_2_icon'] = $this->config->get('config_promote_step_2_icon');
                
                $data['config_promote_step_3_title'] = $this->config->get('config_promote_step_3_title');
                $data['config_promote_step_3_detail'] = html_entity_decode($this->config->get('config_promote_step_3_detail'), ENT_QUOTES, 'UTF-8');
                $data['config_promote_step_3_icon'] = $this->config->get('config_promote_step_3_icon');
                
                $data['config_promote_step_4_title'] = $this->config->get('config_promote_step_4_title');
                $data['config_promote_step_4_detail'] = html_entity_decode($this->config->get('config_promote_step_4_detail'), ENT_QUOTES, 'UTF-8');
                $data['config_promote_step_4_icon'] = $this->config->get('config_promote_step_4_icon');
                
                
                $data['config_promote_membership'] = $this->config->get('config_promote_membership');
                $data['config_promote_membership_detail'] = html_entity_decode($this->config->get('config_promote_membership_detail'), ENT_QUOTES, 'UTF-8');
               
                $data['txt_btn_membership'] = $this->language->get('txt_btn_membership');
                $data['link_btn_membership'] = $this->url->link('information/information', 'information_id=' .  14);
                
                $data['config_promote_get_started'] = $this->config->get('config_promote_get_started');
                $data['link_get_started'] = $this->url->link('account/register-seller');
                
                $data['config_promote_contact'] = html_entity_decode($this->config->get('config_promote_contact'), ENT_QUOTES, 'UTF-8');
               
                
                 $this->load->model('tool/image');

                if ($this->config->get('config_image_promote')) {
                    $data['thumb_promote'] = $this->model_tool_image->resize($this->config->get('config_image_promote'), 200, 150);
                } else {
                    $data['thumb_promote'] = '';
                }
                

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

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/information/promote.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/information/promote.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/information/promote.tpl', $data));
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