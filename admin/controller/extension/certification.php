<?php

class ControllerExtensionCertification extends Controller {

    private $error = array();

    public function index() {
        $this->language->load('extension/certification');

        $this->load->model('extension/certification');

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
            'href' => $this->url->link('extension/certification', 'token=' . $this->session->data['token'] . $url, 'SSL')
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

        $total = $this->model_extension_certification->getTotalCertification();

        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = $this->config->get('config_limit_admin');
        $pagination->url = $this->url->link('extension/certification', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

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

        $data['add'] = $this->url->link('extension/certification/insert', '&token=' . $this->session->data['token'] . $url, 'SSL');
        $data['delete'] = $this->url->link('extension/certification/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

        $data['all_certification'] = array();

        $all_certification = $this->model_extension_certification->getAllCertification($filter_data);
        foreach ($all_certification as $certification) {
            $data['all_certification'][] = array(
                'certification_id' => $certification['certification_id'],
                'title' => $certification['title'],
                'edit' => $this->url->link('extension/certification/edit', 'certification_id=' . $certification['certification_id'] . '&token=' . $this->session->data['token'] . $url, 'SSL')
            );
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('extension/certification_list.tpl', $data));
    }

    public function edit() {
        $this->language->load('extension/certification');

        $this->load->model('extension/certification');

        $this->document->setTitle($this->language->get('heading_title'));

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_extension_certification->editCertification($this->request->get['certification_id'], $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('extension/certification', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->form();
    }

    public function insert() {
        $this->language->load('extension/certification');

        $this->load->model('extension/certification');

        $this->document->setTitle($this->language->get('heading_title'));

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_extension_certification->addCertification($this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('extension/certification', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->form();
    }

    protected function form() {
        $this->language->load('extension/certification');

        $this->load->model('extension/certification');

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('extension/certification', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        if (isset($this->request->get['certification_id'])) {
            $data['action'] = $this->url->link('extension/certification/edit', '&certification_id=' . $this->request->get['certification_id'] . '&token=' . $this->session->data['token'], 'SSL');
        } else {
            $data['action'] = $this->url->link('extension/certification/insert', '&token=' . $this->session->data['token'], 'SSL');
        }

        $data['cancel'] = $this->url->link('extension/certification', '&token=' . $this->session->data['token'], 'SSL');

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
        

        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');

        $data['token'] = $this->session->data['token'];

        $this->load->model('localisation/language');

        $data['languages'] = $this->model_localisation_language->getLanguages();

        if (isset($this->error['warning'])) {
            $data['error'] = $this->error['warning'];
        } else {
            $data['error'] = '';
        }

        if (isset($this->request->get['certification_id'])) {
            $certification = $this->model_extension_certification->getCertification($this->request->get['certification_id']);
        } else {
            $certification = array();
        }
         if (isset($this->request->post['certification'])) {
            $data['certification'] = $this->request->post['certification'];
        } elseif (!empty($certification)) {
            $data['certification'] = $this->model_extension_certification->getCertificationDescription($this->request->get['certification_id']);
        } else {
            $data['certification'] = '';
        }

        

        if (isset($this->request->post['status'])) {
            $data['status'] = $this->request->post['status'];
        } elseif (!empty($certification)) {
            $data['status'] = $certification['status'];
        } else {
            $data['status'] = '';
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('extension/certification_form.tpl', $data));
    }

    public function delete() {
        $this->language->load('extension/certification');

        $this->load->model('extension/certification');

        $this->document->setTitle($this->language->get('heading_title'));

        if (isset($this->request->post['selected']) && $this->validateDelete()) {
            foreach ($this->request->post['selected'] as $certification_id) {
                $this->model_extension_certification->deleteCertification($certification_id);
            }

            $this->session->data['success'] = $this->language->get('text_success');
        }

        $this->response->redirect($this->url->link('extension/certification', 'token=' . $this->session->data['token'], 'SSL'));
    }

    protected function validateDelete() {
        if (!$this->user->hasPermission('modify', 'extension/certification')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    protected function validate() {
        if (!$this->user->hasPermission('modify', 'extension/certification')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

}
