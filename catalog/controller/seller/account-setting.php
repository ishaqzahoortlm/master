<?php

class ControllerSellerAccountSetting extends ControllerSellerAccount {

    public function index() {
        
        $this->data['ms_membership_options'] = $this->language->get('ms_membership_options');
        
        $this->data['link_create_product'] = $this->url->link('seller/account-product/create', '', 'SSL');

        
        $this->data['link_back'] = $this->url->link('account/account', '', 'SSL');
        $this->document->setTitle($this->language->get('ms_account_settings'));

        $this->data['breadcrumbs'] = $this->MsLoader->MsHelper->setBreadcrumbs(array(
            array(
                'text' => $this->language->get('text_account'),
                'href' => $this->url->link('account/account', '', 'SSL'),
            ),
            array(
                'text' => $this->language->get('ms_account_dashboard_breadcrumbs'),
                'href' => $this->url->link('seller/account-dashboard', '', 'SSL'),
            ),
            array(
                'text' => $this->language->get('ms_account_settings'),
                'href' => $this->url->link('seller/account-setting', '', 'SSL'),
            )
        ));

        list($template, $children) = $this->MsLoader->MsHelper->loadTemplate('accountsetting');
        $this->response->setOutput($this->load->view($template, array_merge($this->data, $children)));
    }

}

?>
