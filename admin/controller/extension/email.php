<?php

class ControllerExtensionEmail extends Controller {

    private $error = array();

    public function index() {
        
    
        $this->language->load('extension/emails');

        $this->load->model('extension/emails');
        
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
            'href' => $this->url->link('extension/email', 'token=' . $this->session->data['token'] . $url, 'SSL')
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

        $total = $this->model_extension_emails->getTotal();

        $pagination = new Pagination();
        $pagination->total = $total;
        $pagination->page = $page;
        $pagination->limit = $this->config->get('config_limit_admin');
        $pagination->url = $this->url->link('extension/email', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($total - $this->config->get('config_limit_admin'))) ? $total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $total, ceil($total / $this->config->get('config_limit_admin')));

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_type'] = $this->language->get('text_type');
        $data['text_subject'] = $this->language->get('text_subject');
        $data['text_action'] = $this->language->get('text_action');
        $data['text_list'] = $this->language->get('text_list');
        $data['text_no_results'] = $this->language->get('text_no_results');
        

        $url = '';

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        $data['add'] = $this->url->link('extension/email/insert', '&token=' . $this->session->data['token'] . $url, 'SSL');
        
        $data['all_records'] = array();

        $all_data = $this->model_extension_emails->getAll($filter_data);
        foreach ($all_data as $row) {
            $data['all_records'][] = array(
                'id' => $row['id'],
                'subject' => $row['subject'],
                'email_type' => $row['email_type'],
                'edit' => $this->url->link('extension/email/edit', 'id=' . $row['id'] . '&token=' . $this->session->data['token'] . $url, 'SSL')
            );
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('extension/emails_list.tpl', $data));
    }

    public function edit() {
        $this->language->load('extension/emails');

        $this->load->model('extension/emails');

        $this->document->setTitle($this->language->get('heading_title'));

        if (($this->request->server['REQUEST_METHOD'] == 'POST') ) {
            $this->model_extension_emails->edit($this->request->get['id'], $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('extension/email', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->form();
    }

    public function insert() {
        $this->language->load('extension/emails');

        $this->load->model('extension/emails');

        $this->document->setTitle($this->language->get('heading_title'));

        if (($this->request->server['REQUEST_METHOD'] == 'POST') ) {
            $this->model_extension_emails->add($this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('extension/email', 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->form();
    }

    protected function form() {
        $this->language->load('extension/emails');

        $this->load->model('extension/emails');

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('extension/email', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        if (isset($this->request->get['id'])) {
            $data['type_action'] = 'readonly';
            $data['action'] = $this->url->link('extension/email/edit', '&id=' . $this->request->get['id'] . '&token=' . $this->session->data['token'], 'SSL');
        } else {
            $data['type_action'] = '';
            $data['action'] = $this->url->link('extension/email/insert', '&token=' . $this->session->data['token'], 'SSL');
        }

        $data['cancel'] = $this->url->link('extension/email', '&token=' . $this->session->data['token'], 'SSL');

        $data['heading_title'] = $this->language->get('heading_title');

        
        $data['text_type'] = $this->language->get('text_type');
        $data['text_subject'] = $this->language->get('text_subject');
        $data['text_description'] = $this->language->get('text_description');
        $data['text_status'] = $this->language->get('text_status');
       
        $data['token'] = $this->session->data['token'];

        

        if (isset($this->error['warning'])) {
            $data['error'] = $this->error['warning'];
        } else {
            $data['error'] = '';
        }

        if (isset($this->request->get['id'])) {
            $email = $this->model_extension_emails->get($this->request->get['id']);
        } else {
            $email = array();
        }
        
        if (isset($this->request->post['email_type'])) {
            $data['email_type'] = $this->request->post['email_type'];
        } elseif (!empty($email)) {
            $data['email_type'] = $email['email_type'];
        } else {
            $data['email_type'] = '';
        }
        
        if (isset($this->request->post['subject'])) {
            $data['subject'] = $this->request->post['subject'];
        } elseif (!empty($email)) {
            $data['subject'] = $email['subject'];
        } else {
            $data['subject'] = '';
        }
        
        if (isset($this->request->post['contents'])) {
            $data['contents'] = $this->request->post['contents'];
        } elseif (!empty($email)) {
            $data['contents'] = $email['contents'];
        } else {
            $data['contents'] = '';
        }
         
        if (isset($this->request->post['status'])) {
            $data['status'] = $this->request->post['status'];
        } elseif (!empty($email)) {
            $data['status'] = $email['status'];
        } else {
            $data['status'] = '';
        }

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('extension/email_form.tpl', $data));
    }

    
    protected function validateDelete() {
        if (!$this->user->hasPermission('modify', 'extension/email')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    protected function validate() {
        if (!$this->user->hasPermission('modify', 'extension/email')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

}
