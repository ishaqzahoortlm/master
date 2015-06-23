<?php

class ControllerExtensionPackage extends Controller {

    private $error = array();

    public function index() {
        $this->language->load('extension/package');

        $this->load->model('extension/package');

        $this->document->setTitle($this->language->get('heading_title'));

        $url = '';

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('extension/package', 'token=' . $this->session->data['token'] . $url, 'SSL')
        );

        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];

            unset($this->session->data['success']);
        } else {
            $data['success'] = '';
        }

        if (isset($this->error['warning'])) {
            $data['error'] = $this->error['warning'];

            unset($this->error['warning']);
        } else {
            $data['error'] = '';
        }

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        $url = '';

        $filter_data = array(
            'page' => $page,
            'limit' => $this->config->get('config_limit_admin'),
            'start' => $this->config->get('config_limit_admin') * ($page - 1),
        );

        $total = $this->model_extension_package->getTotalPackage();

        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = $this->config->get('config_limit_admin');
        $pagination->url = $this->url->link('catalog/product', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($total - $this->config->get('config_limit_admin'))) ? $total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $total, ceil($total / $this->config->get('config_limit_admin')));

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_title'] = $this->language->get('text_title');
        $data['text_price'] = $this->language->get('text_price');
        $data['text_trial'] = $this->language->get('text_trial');
        $data['text_date'] = $this->language->get('text_date');
        $data['text_action'] = $this->language->get('text_action');
        $data['text_edit'] = $this->language->get('text_edit');
        $data['text_list'] = $this->language->get('text_list');
        $data['text_no_results'] = $this->language->get('text_no_results');
        $data['text_confirm'] = $this->language->get('text_confirm');

        $data['button_add'] = $this->language->get('button_add');
        $data['button_delete'] = $this->language->get('button_delete');
        

        $url = '';

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        $data['add'] = $this->url->link('extension/package/insert', '&token=' . $this->session->data['token'] . $url, 'SSL');
        $data['delete'] = $this->url->link('extension/package/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

        $data['all_package'] = array();

        $all_package = $this->model_extension_package->getAllPackage($filter_data);
        
        foreach ($all_package as $package) {
            $data['all_package'][] = array(
                'package_id' => $package['package_id'],
                'title' => $package['title'],
                'price' => $package['price'],
                'trial' => $package['trial'],
                'date_added' => date($this->language->get('date_format_short'), strtotime($package['date_added'])),
                'edit' => $this->url->link('extension/package/edit', 'package_id=' . $package['package_id'] . '&token=' . $this->session->data['token'] . $url, 'SSL')
            );
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('extension/package_list.tpl', $data));
    }

    public function edit() {
        $this->language->load('extension/package');

        $this->load->model('extension/package');

        $this->document->setTitle($this->language->get('heading_title'));

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_extension_package->editPackage($this->request->get['package_id'], $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('extension/package', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->form();
    }

    public function insert() {
        $this->language->load('extension/package');

        $this->load->model('extension/package');

        $this->document->setTitle($this->language->get('heading_title'));

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_extension_package->addPackage($this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('extension/package', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->form();
    }

    protected function form() {
        $this->language->load('extension/package');

        $this->load->model('extension/package');

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('extension/package', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        if (isset($this->request->get['package_id'])) {
            $data['action'] = $this->url->link('extension/package/edit', '&package_id=' . $this->request->get['package_id'] . '&token=' . $this->session->data['token'], 'SSL');
        } else {
            $data['action'] = $this->url->link('extension/package/insert', '&token=' . $this->session->data['token'], 'SSL');
        }

        $data['cancel'] = $this->url->link('extension/package', '&token=' . $this->session->data['token'], 'SSL');

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_image'] = $this->language->get('text_image');
        $data['text_title'] = $this->language->get('text_title');
        $data['text_description'] = $this->language->get('text_description');
        $data['text_short_description'] = $this->language->get('text_short_description');
        $data['text_status'] = $this->language->get('text_status');
        $data['text_keyword'] = $this->language->get('text_keyword');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_browse'] = $this->language->get('text_browse');
        $data['text_clear'] = $this->language->get('text_clear');
        $data['text_price'] = $this->language->get('text_price');
        $data['text_trial'] = $this->language->get('text_trial');
        $data['text_sort'] = $this->language->get('text_sort');
        $data['text_duration'] = $this->language->get('text_duration');

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        
        $data['modules_list'] = $this->model_extension_package->getAllModules();
        $data['text_modules'] = $this->language->get('text_modules');

        $data['token'] = $this->session->data['token'];

        $this->load->model('localisation/language');

        $data['languages'] = $this->model_localisation_language->getLanguages();

        if (isset($this->error['warning'])) {
            $data['error'] = $this->error['warning'];
        } else {
            $data['error'] = '';
        }

        if (isset($this->request->get['package_id'])) {
            $package = $this->model_extension_package->getPackage($this->request->get['package_id']);
        } else {
            $package = array();
        }
         if (isset($this->request->post['package'])) {
            $data['package'] = $this->request->post['package'];
        } elseif (!empty($package)) {
            $data['package'] = $this->model_extension_package->getPackageDescription($this->request->get['package_id']);
        } else {
            $data['package'] = '';
        }

        if (isset($this->request->post['price'])) {
            $data['price'] = $this->request->post['price'];
        } elseif (!empty($package)) {
            $data['price'] = $package['price'];
        } else {
            $data['price'] = '';
        }
        
        if (isset($this->request->post['modules'])) {
            $data['modules'] = $this->request->post['modules'];
        } elseif (!empty($package)) {
            $data['modules'] = $package['modules'];
        } else {
            $data['modules'] = '';
        }
        
        if (isset($this->request->post['duration'])) {
            $data['duration'] = $this->request->post['duration'];
        } elseif (!empty($package)) {
            $data['duration'] = $package['duration'];
        } else {
            $data['duration'] = '';
        }
        
        if (isset($this->request->post['duration_type'])) {
            $data['duration_type'] = $this->request->post['duration_type'];
        } elseif (!empty($package)) {
            $data['duration_type'] = $package['duration_type'];
        } else {
            $data['duration_type'] = '';
        }

        if (isset($this->request->post['trial'])) {
            $data['trial'] = $this->request->post['trial'];
        } elseif (!empty($package)) {
            $data['trial'] = $package['trial'];
        } else {
            $data['trial'] = '';
        }

        if (isset($this->request->post['sort_order'])) {
            $data['sort_order'] = $this->request->post['sort_order'];
        } elseif (!empty($package)) {
            $data['sort_order'] = $package['sort_order'];
        } else {
            $data['sort_order'] = 0;
        }


        if (isset($this->request->post['status'])) {
            $data['status'] = $this->request->post['status'];
        } elseif (!empty($package)) {
            $data['status'] = $package['status'];
        } else {
            $data['status'] = '';
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('extension/package_form.tpl', $data));
    }

    public function delete() {
        $this->language->load('extension/package');

        $this->load->model('extension/package');

        $this->document->setTitle($this->language->get('heading_title'));

        if (isset($this->request->post['selected']) && $this->validateDelete()) {
            foreach ($this->request->post['selected'] as $package_id) {
                $this->model_extension_package->deletePackage($package_id);
            }

            $this->session->data['success'] = $this->language->get('text_success');
        }

        $this->response->redirect($this->url->link('extension/package', 'token=' . $this->session->data['token'], 'SSL'));
    }

    protected function validateDelete() {
        if (!$this->user->hasPermission('modify', 'extension/package')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    protected function validate() {
        if (!$this->user->hasPermission('modify', 'extension/package')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

}
