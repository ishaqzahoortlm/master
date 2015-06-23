<?php echo $header; ?>
<div id="breadcrumb">
    <div class="container">
        <div class="row">
            <a href="<?= $this->url->link('common/home') ?>">Home</a>
            <?php for ($bi = 1; $bi < count($breadcrumbs); $bi++) { ?>
                <i class="fa fa-angle-double-right"></i>
                <?php
                if ($bi < (count($breadcrumbs) - 1)) {
                    ?>
                    <span><a href="<?= $breadcrumbs[$bi]['href'] ?>"><?= $breadcrumbs[$bi]['text'] ?></a></span> 
                <?php } else { ?>
                    <span><?= $breadcrumbs[$bi]['text'] ?></span> 
                <?php } ?>
            <?php } ?>
        </div>
    </div>
</div>

<div id="bodyiner">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-6">
                        <div class="cathead">
                            <h2> <?php echo $ms_account_dashboard_heading; ?></h2>
                        </div>
                    </div>
                    <div class="col-md-6" style="padding-top: 15px;">
                        <div class="pull-right">
                            <a class="link_color"  href="<?php echo $this->url->link('seller/product-message', '', 'SSL'); ?>">
                                <i class="fa fa-envelope"></i>	
                                <span><?php echo $ms_account_messages; ?></span>
                            </a>
                        </div>
                    </div>
                </div>
                <hr style="margin-top: 0px"/>

                <!--<div class="col-md-3">
                <?php //echo $column_right; ?>
                </div> -->
                <div class="col-md-12">
                    <div class="main-content" style="min-height: 400px;">
                        <div id="content" class=" ms-account-dashboard">
                            <div class="row">
                                <div class="col-md-12" style="margin-top: 10px;">

                                    <div class="col-md-4" style="padding: 8px;">
                                        <h4 id="view_activity_head" style="cursor: pointer;"> <i class="fa fa-bars"></i> &nbsp; <?php echo "View Activity"; ?></h4>
                                        <div class="col-md-12" style="padding: 8px; display: none;" id="view_activity_body">
                                            <a class="link_color"  href="<?php echo $this->url->link('seller/account-order', '', 'SSL'); ?>">
                                                <i class="fa fa-shopping-cart"></i>
                                                <span><?php echo $ms_account_dashboard_nav_orders; ?></span>
                                            </a>
                                            <br/>
                                            <a class="link_color"  href="<?php echo $this->url->link('seller/product-return', '', 'SSL'); ?>">
                                                <i class="fa fa-undo"></i>	
                                                <span><?php echo $ms_account_returns; ?></span>
                                            </a>
                                        </div>
                                    </div>  

                                    <div class="col-md-4" style="padding: 8px;">
                                        <h4 id="accounting_head" style="cursor: pointer;"> <i class="fa fa-bars"></i> &nbsp; <?php echo "Accounting"; ?></h4>
                                        <div class="col-md-12" style="padding: 8px; display: none;" id="accounting_body">
                                            <a class="link_color"  href="<?php echo $this->url->link('seller/account-transaction', '', 'SSL'); ?>">
                                                <i class="fa fa-file-o"></i>
                                                <span><?php echo $ms_account_dashboard_nav_balance; ?></span>
                                            </a>
                                            <br/>
                                            <a class="link_color"  href="<?php echo $this->url->link('seller/account-withdrawal', '', 'SSL'); ?>">
                                                <i class="fa fa-usd"></i>	
                                                <span><?php echo $ms_account_request_payout; ?></span>
                                            </a>
                                        </div>   
                                    </div>   

                                    <div class="col-md-4" style="padding: 8px;">
                                        <h4 id="product_head" style="cursor: pointer;"> <i class="fa fa-bars"></i> &nbsp; <?php echo "Product"; ?></h4>
                                        <div class="col-md-12" style="padding: 8px; display: none;" id="product_body">
                                            <a class="link_color"  href="<?php echo $this->url->link('seller/account-product/create', '', 'SSL'); ?>">
                                                <i class="fa fa-plus"></i>
                                                <span><?php echo $ms_account_dashboard_nav_product; ?></span>
                                            </a>
                                            <br/>
                                            <a class="link_color"  href="<?php echo $this->url->link('seller/account-product', '', 'SSL'); ?>">
                                                <i class="fa fa-folder"></i>	
                                                <span><?php echo $ms_account_dashboard_nav_products; ?></span>
                                            </a>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12" style="margin-top: 10px;">

                                    <div class="col-md-4" style="padding: 8px;">
                                        <h4 id="reports_head" style="cursor: pointer;">  <i class="fa fa-bars"></i> &nbsp; <?php echo "Reports"; ?></h4>
                                        <div class="col-md-12" style="padding: 8px; display: none;" id="reports_body">
                                            <a class="link_color"  href="<?php echo $this->url->link('seller/account-stats', '', 'SSL'); ?>">
                                                <i class="fa fa-bar-chart-o"></i>	
                                                <span><?php echo $ms_account_stats; ?></span>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="col-md-4" style="padding: 8px;">
                                        <h4 id="bids_head" style="cursor: pointer;">  <i class="fa fa-bars"></i> &nbsp; <?php echo "Bids"; ?></h4>
                                        <div class="col-md-12" style="padding: 8px; display: none;" id="bids_body">
                                            <a class="link_color"  href="<?php echo $this->url->link('seller/product-quote', '', 'SSL'); ?>">
                                                <i class="fa fa-comment"></i>	
                                                <span><?php echo $ms_account_product_quote; ?></span>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="col-md-4" style="padding: 8px;">
                                        <h4 id="profile_head" style="cursor: pointer;"> <i class="fa fa-bars"></i> &nbsp;  <?php echo "Profile"; ?></h4>
                                        <div class="col-md-12" style="padding: 8px; display: none;" id="profile_body">
                                            <a class="link_color"  href="<?php echo $this->url->link('account/password', '', 'SSL'); ?>">
                                                <i class="fa fa-lock"></i>	
                                                <span><?php echo $ms_account_password; ?></span>
                                            </a> <br/>
                                            <a class="link_color"  href="<?php echo $this->url->link('seller/account-profile', '', 'SSL'); ?>">
                                                <i class='fa fa-pencil'></i>
                                                <span><?php echo 'Edit Profile'; ?></span>
                                            </a>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>

                            <div class="buttons clearfix" style="display: none;">
                                <div class="pull-left"><a href="<?php echo $link_back; ?>" class="btn btn-default"><?php echo $button_back; ?></a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php echo $footer; ?>
