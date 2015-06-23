<?php

class ControllerCronAlert extends Controller {

    public function index() {
        /*
          $subject = "Membership plane";

          $message ='<tr>
          <td style="line-height:22px;">
          <h2 style="color:#000;">Hi Tahir,</h2>
          <p>This is testing email</p>

          </td>
          </tr>';


          $data['message'] = $message;

          if (file_exists(DIR_TEMPLATE .'default/template/mail/template.tpl')) {
          $html = $this->load->view('default/template/mail/template.tpl', $data);
          } else {
          $html = $this->load->view('default/template/mail/template.tpl', $data);
          }

          $mail = new Mail('info@marketplace.com');

          $mail->setTo(array('tahir.dvosolutions@nxvt.com'));
          $mail->setFrom('info@marketplace.com');
          $mail->setSender('info@marketplace.com');
          $mail->setSubject($subject);
          $mail->setHtml($html);
          $mail->send();
          echo "email send now";
          exit;
         * */



        $this->load->model('extension/package');
        $this->load->model('account/supplier');
        $this->load->model('account/customer');
        $rows = $this->model_account_supplier->getAccounts();
        if (!empty($rows)) {
            foreach ($rows as $row) {

                if ($row['package_id'] == 1 || $row['package_id'] == 0) {
                    $package_id = 1;
                } else {
                    $package_id = $row['package_id'];
                }
                $package_info = $this->model_extension_package->getPackage($package_id);

                $package_detail = $this->model_extension_package->getPackageDescription($package_id);
                $customer_detail = $this->model_account_customer->getCustomer($row['seller_id']);

                $customer_email = $customer_detail['email'];
                $package_title = $package_detail[1]['title'];
                $package_days = $this->get_package_days($package_info['duration'], $package_info['duration_type']);

                if ($row['package_date'] == '0000-00-00') {
                    $package_check_date = 'date_created';
                } else {
                    $package_check_date = 'package_date';
                }

                $package_updated_days = $this->model_account_supplier->getPackageUpdateDays($row['seller_id'], $package_check_date);

                $remaining_days = 0;

                $remaining_days = intval($package_days) - intval($package_updated_days);

                if ($remaining_days == 2) {

                    $subject = "Membership is expiring soon";
                    $message = '<tr>
                            <td style="line-height:22px;">
                             <h2 style="color:#000;">Hi ' . $row['company'] . ',</h2>
                             <p>Your membership will expire in <b>2</b> days and your account will disable. </p>  
                             <p>To renew your membership go to <a href="' . $this->url->link('seller/account-profile') . '" target="_blank">your profile</a></p> 
                             <p>To view the details of membership plans <a href="' . $this->url->link('information/membershipplane') . '" target="_blank"> click here </a> </p>  
                            </td>
                        </tr>';

                    $data['message'] = $message;

                    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/template.tpl')) {
                        $html = $this->load->view($this->config->get('config_template') . '/template/mail/template.tpl', $data);
                    } else {
                        $html = $this->load->view('default/template/mail/template.tpl', $data);
                    }

                    $mail = new Mail($this->config->get('config_mail'));

                    $mail->setTo(array($customer_email));
                    $mail->setFrom($this->config->get('config_email'));
                    $mail->setSender($this->config->get('config_name'));
                    $mail->setSubject($subject);
                    $mail->setHtml($html);
                    $mail->send();
                } else if ($remaining_days == 0) {

                    $this->model_account_supplier->updateSellerAccount($row['seller_id'], 2);


                    $subject = "Membership has expired";
                    $message = '<tr>
                            <td style="line-height:22px;">
                             <h2 style="color:#000;">Hi ' . $row['company'] . ',</h2>
                             <p>Your membership has expired . </p>  
                             <p>To renew your membership go to <a href="' . $this->url->link('seller/account-profile') . '" target="_blank">your profile</a></p> 
                             <p>To view the details of membership plans <a href="' . $this->url->link('information/membershipplane') . '" target="_blank"> click here </a> </p>  
                            </td>
                        </tr>';

                    $data['message'] = $message;

                    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/template.tpl')) {
                        $html = $this->load->view($this->config->get('config_template') . '/template/mail/template.tpl', $data);
                    } else {
                        $html = $this->load->view('default/template/mail/template.tpl', $data);
                    }

                    $mail = new Mail($this->config->get('config_mail'));

                    $mail->setTo(array($customer_email));
                    $mail->setFrom($this->config->get('config_email'));
                    $mail->setSender($this->config->get('config_name'));
                    $mail->setSubject($subject);
                    $mail->setHtml($html);
                    $mail->send();
                }
            }
        }
    }

    public function get_package_days($duration, $type) {
        $days = 0;
        if ($type == 'day') {
            $days = $duration;
        } else if ($type == 'month') {
            $days = $duration * 30;
        } else if ($type == 'year') {
            $days = $duration * 365;
        }
        return $days;
    }

}

?>