<?php echo $header; ?>
<div id="breadcrumb">
    <div class="container">
        <div class="row">
            <a href="<?=$this->url->link('common/home')?>">Home</a>
            <?php for($bi=1;$bi<count($breadcrumbs);$bi++){ ?>
            <i class="fa fa-angle-double-right"></i>
            <?php
            if($bi<(count($breadcrumbs)-1)){
            ?>
            <span><a href="<?=$breadcrumbs[$bi]['href']?>"><?=$breadcrumbs[$bi]['text']?></a></span> 
            <?php }else { ?>
            <span><?=$breadcrumbs[$bi]['text']?></span> 
            <?php } ?>
            <?php } ?>
        </div>
    </div>
</div>

<div id="bodyiner">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                
                <div class="cathead"><h2> <?php echo $heading_title; ?></h2></div>
                <hr>
                <?php if (isset($success) && ($success)) { ?>
                <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?></div>
                <?php } ?>

                <?php if (isset($error_warning) && $error_warning) { ?>
                <div class="alert alert-danger warning main"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
                <?php } ?>
<!--                <div class="col-md-3"><?php //echo $column_right; ?></div>-->
                <div class="col-md-12">
                    <div class="main-content" >
        

        <div id="content" class="ms-account-transaction ">
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-6" style="padding-left: 0px;">
                        <h4><?php echo $ms_account_withdraw_heading; ?></h4>
                    </div>
                    <div class="col-md-6" style="padding-right: 0px;">
                        <div class="pull-right">
                            <a href="<?php echo $link_to_dashboard; ?>" class=""><button class="btn btn-primary" type="button"><?php echo $ms_backto_dashboard; ?></button></a>
                        </div>
                    </div>
                </div>
            </div>

            <p><?php echo $ms_account_withdraw_balance; ?> <b><?php echo $ms_account_balance_formatted; ?></b> <span style="color: gray"><?php echo $ms_account_reserved_formatted; ?></span></p>
            <p><?php echo $ms_account_withdraw_balance_available; ?> <b><?php echo $balance_available_formatted; ?></b></p>
            <p><?php echo $ms_account_withdraw_minimum; ?> <b><?php echo $this->currency->format($this->config->get('msconf_minimum_withdrawal_amount'),$this->config->get('config_currency')); ?></b></p>

            <?php if ($balance_available <= 0) { ?>
            <div class="alert alert-warning"><?php echo $ms_account_withdraw_no_funds; ?></div>
            <?php } else if (!isset($paypal) || empty($paypal)) { ?>
            <div class="alert alert-warning"><?php echo $ms_account_withdraw_no_paypal; ?></div>
            <?php } else if (!$withdrawal_minimum_reached) { ?>
            <div class="alert alert-warning"><?php echo $ms_account_withdraw_minimum_not_reached; ?></div>
            <?php } ?>

            <form id="ms-withdrawal" class="ms-form">
                <div class="content">
                    <?php if (!$withdrawal_minimum_reached || !isset($paypal) || empty($paypal) || $balance_available <= 0) { ?>
                    <div class="ms-overlay"></div>
                    <?php } ?>

                    <div class="form-group">
                        <label class="col-sm-2 control-label"><?php echo $ms_account_withdraw_amount; ?></label>
                        <div class="col-sm-10">
                            <?php if ($msconf_allow_partial_withdrawal) { ?>
                            <p>
                                <input type="radio" class="form-inline" name="withdraw_all" value="0" checked="checked" />
                                <input type="text" class="form-control" style="width: 100px; display: inline" name="withdraw_amount" value="<?php echo $this->currency->format($this->config->get('msconf_minimum_withdrawal_amount'),$this->config->get('config_currency'), '', FALSE); ?>" />
                                <?php echo $currency_code; ?>
                            </p>
                            <?php } ?>

                            <p>
                                <input type="radio" name="withdraw_all" value="1" <?php if (!$msconf_allow_partial_withdrawal) { ?>checked="checked"<?php } ?> />
                                       <span><?php echo $ms_account_withdraw_all; ?> (<?php echo $balance_available_formatted; ?>)</span>
                            </p>
                            <p class="ms-note"><?php echo $ms_account_withdraw_amount_note; ?></p>
                            <p class="error" id="error_withdraw_amount"></p>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label"><?php echo $ms_account_withdraw_method; ?></label>
                        <div class="col-sm-10">
                            <p>
                                <input type="radio" name="withdraw_method" value="paypal" checked="checked" />
                                <span><?php echo $ms_account_withdraw_method_paypal; ?></span>
                            </p>
                            <p class="ms-note"><?php echo $ms_account_withdraw_method_note; ?></p>
                            <p class="error" id="error_withdraw_method"></p>
                        </div>
                    </div>
                    </table>
                </div>

                
                <div class="form-group ">
                    <label class="col-sm-2 control-label" for="input-confirm"></label>
                    <div class="col-sm-10">
                        <?php if ($withdrawal_minimum_reached && isset($paypal) && !empty($paypal)) { ?>
                        <input type="button" id="ms-submit-request" value="<?php echo $ms_button_submit_request; ?>" class="btn btn-primary" />
                        <?php } ?>
                    </div>
                </div>

            </form>
            </div>

    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php echo $footer; ?>