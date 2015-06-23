<?php echo $header; ?>
<style type="">
    table { float:left!important; }
</style>

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
                <?php if ($success) { ?>
                    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
                    <?php } ?>
                <!--<div class="col-md-3"><?php //echo $column_right; ?></div> -->
                <div class="col-md-12">
                    <div class="main-content" >
        <div id="content" class="">
            <div class="row">
            <div class="col-md-12">
                <div class="col-md-6" style="padding-left: 0px;">
                    <h4><?php echo $ms_account_stats_heading; ?></h4>
                </div>
                <div class="col-md-6" style="padding-right: 0px;">
                    <div class="pull-right">
                        <a href="<?php echo $link_to_dashboard; ?>" class=""><button class="btn btn-primary" type="button"><?php echo $ms_backto_dashboard; ?></button></a>
                    </div>
                </div>
            </div>
        </div>

            <ul class="nav nav-tabs">
                <li class="active"><a href="#tab-summary" data-toggle="tab"><?php echo $ms_account_stats_tab_summary; ?></a></li>
                <li><a href="#tab-by-product" data-toggle="tab"><?php echo $ms_account_stats_tab_by_product; ?></a></li>
                <li style="display:none;"><a href="#tab-by-year" data-toggle="tab"><?php echo $ms_account_stats_tab_by_year; ?></a></li>
            </ul>
            <div class="tab-content">
                <div id="tab-summary" class="tab-pane active">
                    <p><?php echo $ms_account_stats_summary_comment; ?></p>
                    <div class="table-responsive">
                    <table class="list table table-bordered table-hover" id="table-summary-1">
                        <thead>
                            <tr>
                                <td class="large"><?php echo $ms_account_stats_sales_data ?></td>
                                <td class="medium"><?php echo $ms_account_stats_number_of_orders; ?></td>
                                <td class="medium"><?php echo $ms_account_stats_total_revenue; ?></td>
                                <td class="medium"><?php echo $ms_account_stats_average_order; ?></td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><?php echo $ms_account_stats_today . date($date_format_short, strtotime($today)); ?></td>
                                <td><?php echo (int)$summary_today['order_num']; ?></td>
                                <td><?php echo $this->currency->format($summary_today['total_revenue'], $this->config->get('config_currency')); ?></td>
                                <td><?php echo $this->currency->format($summary_today['average_revenue'], $this->config->get('config_currency')); ?></td>
                            </tr>
                            <tr>
                                <td><?php echo $ms_account_stats_yesterday . date($date_format_short, strtotime($yesterday)); ?></td>
                                <td><?php echo (int)$summary_yesterday['order_num']; ?></td>
                                <td><?php echo $this->currency->format($summary_yesterday['total_revenue'], $this->config->get('config_currency')); ?></td>
                                <td><?php echo $this->currency->format($summary_yesterday['average_revenue'], $this->config->get('config_currency')); ?></td>
                            </tr>
                            <tr>
                                <td><?php echo $ms_account_stats_daily_average . date($ms_account_stats_date_month_format, strtotime($today)); ?></td>
                                <td><?php echo $summary_month_daily['order_num']; ?></td>
                                <td><?php echo $this->currency->format($summary_month_daily['total_revenue'], $this->config->get('config_currency')); ?></td>
                                <td><?php echo $this->currency->format($summary_month_daily['average_revenue'], $this->config->get('config_currency')); ?></td>
                            </tr>
                            <tr>
                                <td><?php echo $ms_account_stats_projected_totals . date($ms_account_stats_date_month_format, strtotime($today)); ?></td>
                                <td><?php echo $summary_month_projected['order_num']; ?></td>
                                <td><?php echo $this->currency->format($summary_month_projected['total_revenue'], $this->config->get('config_currency')); ?></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>

                    <table class="list table table-bordered table-hover" id="table-summary-2">
                        <thead>
                            <tr>
                                <td class="left" colspan="2"><?php echo $ms_account_stats_statistics; ?></td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="left"><?php echo $ms_account_stats_grand_total_sales; ?></td>
                                <td class="tiny right"><?php echo $this->currency->format($grand_total, $this->config->get('config_currency')); ?></td>
                            </tr>
                        </tbody>
                    </table>
                    </div>    
                </div>

                <div id="tab-by-product" class="tab-pane">
                    <div class="table-responsive">
                    <table class="list table table-bordered table-hover" id="table-by-products">
                        <thead>
                            <tr>
                                <td class="tiny"><?php echo $ms_id; ?></td>
                                <td class="large"><?php echo $ms_account_stats_product; ?></td>
                                <td class="tiny"><?php echo $ms_account_stats_sold; ?></td>
                                <td class="medium"><?php echo $ms_account_stats_total; ?></td>
                            </tr>
                            <tr class="filter">
                                <td><input type="text"/></td>
                                <td><input type="text"/></td>
                                <td><input type="text"/></td>
                                <td><input type="text"/></td>
                            </tr>
                        </thead>

                        <tbody></tbody>
                    </table>
                    </div>    
                </div>

                <div id="tab-by-year" class="tab-pane">
                    <div>
                        <div style="float: right; margin: 5px;">
                            <?php echo $ms_account_stats_show_orders; ?>
                            <select id="year_select">
                                <?php foreach($years as $key=>$year){ ?>
                                <option value="<?php echo $key; ?>"><?php echo $year; ?></option>
                                <?php } ?>
                            </select>
                        </div>
                        <div style="float: left; margin: 5px;">
                            <?php echo sprintf($ms_account_stats_year_comment, $sales); ?>
                        </div>
                    </div>
                    <div class="table-responsive">
                    <table class="list table table-bordered table-hover" id="table-by-year" style="float: left !important;" >
                        <thead>
                            <tr>
                                <td class="medium"><?php echo $ms_account_stats_month; ?></td>
                                <td class="tiny"><?php echo $ms_account_stats_num_of_orders; ?></td>
                                <td class="medium"><?php echo $ms_account_stats_total_r; ?></td>
                                <td class="medium"><?php echo $ms_account_stats_average_order; ?></td>
                            </tr>
                        </thead>

                        <tbody></tbody>
                    </table>

                    <table class="list table table-bordered table-hover" id="table-by-year-total" >
                        <thead>
                            <tr>
                                <td class="medium"></td>
                                <td class="tiny"><?php echo $ms_account_stats_num_of_orders; ?></td>
                                <td class="medium"><?php echo $ms_account_stats_total_r; ?></td>
                                <td class="medium"><?php echo $ms_account_stats_average_order; ?></td>
                            </tr>
                        </thead>

                        <tbody></tbody>
                    </table>
                    </div>
                </div>
            </div>

            <div class="buttons clearfix" style="display:none;">
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