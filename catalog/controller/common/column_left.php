<?php

class ControllerCommonColumnLeft extends Controller {

    public function index() {
        $this->load->model('design/layout');

        if (isset($this->request->get['route'])) {
            $route = (string) $this->request->get['route'];
        } else {
            $route = 'common/home';
        }

        /* -----------------customize---------------------------------- */
        $this->load->language('module/category');
        
        if (isset($this->request->get['path'])) {
	$parts = explode('_', (string)$this->request->get['path']);
        } else {
                $parts = array();
        }

        if (isset($parts[0])) {
                $data['category_id'] = $parts[0];
        } else {
                $data['category_id'] = 0;
        }
        
        
        $data['category_heading_title'] = $this->language->get('heading_title');
        $this->load->model('catalog/product');
        $this->load->model('catalog/category');
        $this->load->model('catalog/information');
        $categories = $this->model_catalog_category->getCategories(0);
        foreach ($categories as $category) {
            $data['categories'][] = array(
                'category_id' => $category['category_id'],
                'name' => $category['name'],
                'children' => '',
                'href' => $this->url->link('product/category', 'path=' . $category['category_id'])
            );
        }
        
          /*---------------------------------------------------------------*/
        
        $data['cms_supplier_promote'] = '';
        $data['cms_supplier_promote_link'] = '';
        $rs_page_info = $this->model_catalog_information->getInfoPage(13);
        if($rs_page_info['status']==1){
        $rs_cms = $this->model_catalog_information->getInformationCustom(13);
        
        $data['cms_supplier_promote'] = $rs_cms['title'];
        $data['cms_supplier_promote_link'] = $this->url->link('information/promote');
        }
        
        $rs_cms = $this->model_catalog_information->getInformation(14);
        
        $data['cms_supplier_membership'] = (!empty($rs_cms))?$rs_cms['title']:'';
        $data['cms_supplier_membership_link'] = $this->url->link('information/membershipplane');
        
        $layout_id = 0;

        if ($route == 'product/category' && isset($this->request->get['path'])) {
            $this->load->model('catalog/category');

            $path = explode('_', (string) $this->request->get['path']);

            $layout_id = $this->model_catalog_category->getCategoryLayoutId(end($path));
        }

        if ($route == 'product/product' && isset($this->request->get['product_id'])) {
            $this->load->model('catalog/product');

            $layout_id = $this->model_catalog_product->getProductLayoutId($this->request->get['product_id']);
        }

        if ($route == 'information/information' && isset($this->request->get['information_id'])) {
            $this->load->model('catalog/information');

            $layout_id = $this->model_catalog_information->getInformationLayoutId($this->request->get['information_id']);
        }

        if (!$layout_id) {
            $layout_id = $this->model_design_layout->getLayout($route);
        }

        if (!$layout_id) {
            $layout_id = $this->config->get('config_layout_id');
        }

        $this->load->model('extension/module');

        $data['modules'] = array();

        $modules = $this->model_design_layout->getLayoutModules($layout_id, 'column_left');

        foreach ($modules as $module) {
            $part = explode('.', $module['code']);

            if (isset($part[0]) && $this->config->get($part[0] . '_status')) {
                $data['modules'][] = $this->load->controller('module/' . $part[0]);
            }

            if (isset($part[1])) {
                $setting_info = $this->model_extension_module->getModule($part[1]);

                if ($setting_info && $setting_info['status']) {
                    $data['modules'][] = $this->load->controller('module/' . $part[0], $setting_info);
                }
            }
        }

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/column_left.tpl')) {
            return $this->load->view($this->config->get('config_template') . '/template/common/column_left.tpl', $data);
        } else {
            return $this->load->view('default/template/common/column_left.tpl', $data);
        }
    }

}
