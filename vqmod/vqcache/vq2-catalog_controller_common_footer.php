<?php

class ControllerCommonFooter extends Controller {

    public function index() {

				$data = array_merge($this->load->language('multiseller/multiseller'), isset($data) ? $data : array());
			
        $this->load->language('common/footer');

        if ($this->request->server['HTTPS']) {
            $server = $this->config->get('config_ssl');
        } else {
            $server = $this->config->get('config_url');
        }
        $data['base'] = $server;

        $data['text_information'] = $this->language->get('text_information');
        $data['text_service'] = $this->language->get('text_service');
        $data['text_extra'] = $this->language->get('text_extra');
        $data['text_contact'] = $this->language->get('text_contact');
        $data['text_return'] = $this->language->get('text_return');
        $data['text_sitemap'] = $this->language->get('text_sitemap');
        $data['text_manufacturer'] = $this->language->get('text_manufacturer');
        $data['text_voucher'] = $this->language->get('text_voucher');
        $data['text_affiliate'] = $this->language->get('text_affiliate');
        $data['text_special'] = $this->language->get('text_special');
        $data['text_account'] = $this->language->get('text_account');
        $data['text_order'] = $this->language->get('text_order');
        $data['text_wishlist'] = $this->language->get('text_wishlist');
        $data['text_newsletter'] = $this->language->get('text_newsletter');
        $data['text_connect_us'] = $this->language->get('text_connect_us');
        $data['text_newsletter_signup'] = $this->language->get('text_newsletter_signup');
        $data['text_newsletter_email'] = $this->language->get('text_newsletter_email');
        $data['btn_newsletter_email'] = $this->language->get('btn_newsletter_email');

        $data['config_footer_tag'] = $this->config->get('config_footer_tag');

        $this->load->model('catalog/information');

        $data['informations'] = array();
        $rs_footer = $this->model_catalog_information->getInformation(9);
        $data['footer_text'] = (isset($rs_footer) && !empty($rs_footer['description'])) ? html_entity_decode($rs_footer['description'], ENT_QUOTES, 'UTF-8') : '';
        foreach ($this->model_catalog_information->getInformations() as $result) {
            if ($result['bottom']) {
                $data['informations'][] = array(
                    'title' => $result['title'],
                    'href' => $this->url->link('information/information', 'information_id=' . $result['information_id'])
                );
            }
        }

        $data['contact'] = $this->url->link('information/contact');
        $data['return'] = $this->url->link('account/return/add', '', 'SSL');
        $data['sitemap'] = $this->url->link('information/sitemap');
        $data['manufacturer'] = $this->url->link('product/manufacturer');
        $data['voucher'] = $this->url->link('account/voucher', '', 'SSL');
        $data['affiliate'] = $this->url->link('affiliate/account', '', 'SSL');
        $data['special'] = $this->url->link('product/special');
        $data['account'] = $this->url->link('account/account', '', 'SSL');
        $data['order'] = $this->url->link('account/order', '', 'SSL');
        $data['wishlist'] = $this->url->link('account/wishlist', '', 'SSL');
        $data['newsletter'] = $this->url->link('account/newsletter', '', 'SSL');

        $data['config_social_email'] = $this->config->get('config_email');
        $data['config_social_facebook'] = $this->config->get('config_social_facebook');
        $data['config_social_twitter'] = $this->config->get('config_social_twitter');
        $data['config_social_linkedin'] = $this->config->get('config_social_linkedin');
        $data['config_social_wordpress'] = $this->config->get('config_social_wordpress');
        $data['powered'] = $this->language->get('text_copyright') . ' &copy ' . date('Y', time()) . ' ' . $this->config->get('config_name'); //sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));
        // Whos Online
        if ($this->config->get('config_customer_online')) {
            $this->load->model('tool/online');

            if (isset($this->request->server['REMOTE_ADDR'])) {
                $ip = $this->request->server['REMOTE_ADDR'];
            } else {
                $ip = '';
            }

            if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
                $url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
            } else {
                $url = '';
            }

            if (isset($this->request->server['HTTP_REFERER'])) {
                $referer = $this->request->server['HTTP_REFERER'];
            } else {
                $referer = '';
            }

            $this->model_tool_online->whosonline($ip, $this->customer->getId(), $url, $referer);
        }

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/footer.tpl')) {
            return $this->load->view($this->config->get('config_template') . '/template/common/footer.tpl', $data);
        } else {
            return $this->load->view('default/template/common/footer.tpl', $data);
        }
    }

}
