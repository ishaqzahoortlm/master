<?php
class ControllerCommonHome extends Controller {
	public function index() {
            
                if ($this->request->server['HTTPS']) {
                    $server = $this->config->get('config_ssl');
                } else {
                    $server = $this->config->get('config_url');
                }            

		$this->document->setTitle($this->config->get('config_meta_title'));
		$this->document->setDescription($this->config->get('config_meta_description'));
		$this->document->setKeywords($this->config->get('config_meta_keyword'));
                
                if (isset($this->request->get['route'])) {
			$this->document->addLink(HTTP_SERVER, 'canonical');
		}
                
                /* -----------------customize---------------------------------- */
                $this->load->language('module/category');
                $this->load->model('tool/image');
                $data['category_heading_title'] = $this->language->get('heading_title');
                $this->load->model('catalog/product');
                $this->load->model('catalog/category');
                $this->load->model('catalog/information');
                $categories = $this->model_catalog_category->getCategories(0);
                foreach ($categories as $category) {
                    
                    if ($category['image']) {
                        $thumb = $this->model_tool_image->resize($category['image'], $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
                        $img = HTTP_SERVER.'image/'.$category['image'];
                        
                    } else {
                        $thumb = '';
                        $img = '';
                    }
                    if($category['image']!="") {
                    $data['categories'][] = array(
                        'category_id' => $category['category_id'],
                        'name' => $category['name'],
                        'children' => '',
                        'thumb'=>$thumb,
                        'image'=>$img,
                        'href' => $this->url->link('product/category', 'path=' . $category['category_id'])
                    );
                    }
                }
                
                $this->load->model('catalog/information');
                $rs_cms = $this->model_catalog_information->getInformation(7);
                $data['description'] = (!empty($rs_cms))?html_entity_decode($rs_cms['description'], ENT_QUOTES, 'UTF-8'):'';

                $rs_cms = $this->model_catalog_information->getInformation(18);
                $data['search_title'] = (!empty($rs_cms))?$rs_cms['title']:'';
                $data['search_description'] = (!empty($rs_cms))?html_entity_decode($rs_cms['description'], ENT_QUOTES, 'UTF-8'):'';
                
                $rs_cms = $this->model_catalog_information->getInformation(19);
                $data['order_title'] = (!empty($rs_cms))?$rs_cms['title']:'';
                $data['order_description'] = (!empty($rs_cms))?html_entity_decode($rs_cms['description'], ENT_QUOTES, 'UTF-8'):'';
                
                $rs_cms = $this->model_catalog_information->getInformation(20);
                $data['thrive_title'] = (!empty($rs_cms))?$rs_cms['title']:'';
                $data['thrive_description'] = (!empty($rs_cms))?html_entity_decode($rs_cms['description'], ENT_QUOTES, 'UTF-8'):'';
    
                
          /*---------------------------------------------------------------*/
                
                $data['shopping_cart'] = $this->url->link('checkout/cart');
                $data['server'] = $server;
                
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/home.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/common/home.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/common/home.tpl', $data));
		}
	}
}