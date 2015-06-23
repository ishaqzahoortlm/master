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
                <!--<div class="col-md-3"><?php //echo $column_right; ?></div> -->
                <div class="col-md-12">
                    <div class="main-content" >
        

        <div id="content" class="ms-account-transaction "><?php echo $content_top; ?>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-6" style="padding-left: 0px;">
                        <h4><?php echo $ms_account_transactions_heading; ?></h4>
                    </div>
                    <div class="col-md-6" style="padding-right: 0px;">
                        <div class="pull-right">
                            <a href="<?php echo $link_to_dashboard; ?>" class=""><button class="btn btn-primary" type="button"><?php echo $ms_backto_dashboard; ?></button></a>
                        </div>
                    </div>
                </div>
            </div>
            <?php echo $ms_account_transactions_balance; ?> <b><?php echo $ms_balance_formatted; ?></b> <span style="color: gray"><?php echo $ms_reserved_formatted; ?></span><br />
            <?php echo $ms_account_transactions_earnings; ?> <b><?php echo $earnings; ?></b><br />

            <!-- BALANCE RECORDS -->
            <h4><?php echo $ms_account_transactions_records; ?></h4>
            <div class="table-responsive">
                <table class="list table table-bordered table-hover" style="text-align: center" id="list-transactions">
                    <thead>
                        <tr>
                            <td class="medium"><?php echo $ms_id; ?></td>
                            <td class="medium"><?php echo $ms_account_transactions_amount; ?></td>
                            <td><?php echo $ms_account_transactions_description; ?></td>
                            <td class="medium"><?php echo $ms_date_created; ?></td>
                        </tr>

                        <tr class="filter" style="display: none;">
                            <td><input type="text"/></td>
                            <td><input type="text"/></td>
                            <td><input type="text"/></td>
                            <td><input type="text"/></td>
                        </tr>
                    </thead>

                    <tbody>
                    </tbody>
                </table>
            </div>
            <br />

            <!-- PAYMENTS -->
            <h4><?php echo $ms_payment_payments; ?></h4>
            <div class="table-responsive">
                <table class="list table table-bordered table-hover" style="text-align: center" id="list-payments">
                    <thead>
                        <tr>
                            <td class="medium"><?php echo $ms_id; ?></td>
                            <td class="medium"><?php echo $ms_type; ?></td>
                            <td class="medium"><?php echo $ms_amount; ?></td>
                            <td><?php echo $ms_description; ?></td>
                            <td class="medium"><?php echo $ms_status; ?></td>
                            <td class="medium"><?php echo $ms_date_paid; ?></td>
                        </tr>

                        <tr class="filter" style="display: none;">
                            <td><input type="text"/></td>
                            <td></td>
                            <td><input type="text"/></td>
                            <td><input type="text"/></td>
                            <td></td>
                            <td><input type="text"/></td>
                        </tr>
                    </thead>

                    <tbody></tbody>
                </table>
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

<script>
    $(function () {
        $('#list-transactions').dataTable({
            "sAjaxSource": $('base').attr('href') + "index.php?route=seller/account-transaction/getTransactionData",
            "aoColumns": [
    {"mData": "transaction_id"},
    {"mData": "amount"},
    {"mData": "description", "bSortable": false},
    {"mData": "date_created"}
            ],
            "aaSorting": [[3, 'desc']]
        });

        $('#list-payments').dataTable({
            "sAjaxSource": $('base').attr('href') + "index.php?route=seller/account-transaction/getPaymentData",
            "aoColumns": [
    {"mData": "payment_id"},
    {"mData": "payment_type"},
    {"mData": "amount"},
    {"mData": "description", "bSortable": false},
    {"mData": "payment_status"},
    {"mData": "date_created"},
            ],
            "aaSorting": [[5, 'desc']]
        });
    });
</script>

<?php echo $footer; ?>