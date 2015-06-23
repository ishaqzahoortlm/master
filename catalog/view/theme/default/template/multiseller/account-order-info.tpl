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
                
                <?php if (isset($error_warning) && $error_warning) { ?>
        <div class="alert alert-danger warning main"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
        <?php } ?>

        <?php if (isset($success) && ($success)) { ?>
        <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?></div>
        <?php } ?>

        <?php if (isset($statustext) && ($statustext)) { ?>
        <div class="alert alert-<?php echo $statusclass; ?>"><?php echo $statustext; ?></div>
        <?php } ?>
                
<!--                <div class="col-md-3"><?php //echo $column_right; ?></div>-->
                <div class="col-md-12">
                    <div class="main-content" >
        

        <div id="content" class="ms-product  ms-account-profile"><?php echo $content_top; ?>
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-6" style="padding-left: 0px;">
                        <h4><?php echo $ms_account_order_information; ?></h4>
                    </div>
                    <div class="col-md-6" style="padding-right: 0px;">
                        <div class="pull-right">
                            <a href="<?php echo $link_to_dashboard; ?>" class=""><button class="btn btn-primary" type="button"><?php echo $ms_backto_dashboard; ?></button></a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- order information -->
            <table class="table table-responsive table-bordered table-hover">
                <thead>
                    <tr>
                        <td colspan="2"><?php echo $text_order_detail; ?></td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="width: 50%;"><?php if ($invoice_no) { ?>
                            <b><?php echo $text_invoice_no; ?></b> <?php echo $invoice_no; ?><br />
                            <?php } ?>
                            <b><?php echo $text_order_id; ?></b> #<?php echo $order_id; ?><br />
                            <b><?php echo $text_date_added; ?></b> <?php echo $date_added; ?></td>
                        <td style="width: 50%;"><?php if ($payment_method) { ?>
                            <b><?php echo $text_payment_method; ?></b> <?php echo $payment_method; ?><br />
                            <?php } ?>
                            <?php if ($shipping_method) { ?>
                            <b><?php echo $text_shipping_method; ?></b> <?php echo $shipping_method; ?>
                            <?php } ?></td>
                    </tr>
                </tbody>
            </table>

            <!-- addresses -->
            <table class="table table-responsive table-bordered">
                <thead>
                    <tr>
                        <td class="left"><?php echo $text_payment_address; ?></td>
                        <?php if ($shipping_address) { ?>
                        <td class="left"><?php echo $text_shipping_address; ?></td>
                        <?php } ?>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="left"><?php echo $payment_address; ?></td>
                        <?php if ($shipping_address) { ?>
                        <td class="left"><?php echo $shipping_address; ?></td>
                        <?php } ?>
                    </tr>
                </tbody>
            </table>

            <!-- products -->
            <table class="list table table-responsive table-bordered">
                <thead>
                    <tr>
                        <td class="left"><?php echo $column_name; ?></td>
                        <td class="left"><?php echo $column_model; ?></td>
                        <td class="right"><?php echo $column_quantity; ?></td>
                        <td class="right"><?php echo $column_price; ?></td>
                        <td class="right"><?php echo $column_total; ?></td>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($products as $product) { ?>
                    <tr>
                        <td class="left"><?php echo $product['name']; ?>
                        <td class="left"><?php echo $product['model']; ?></td>
                        <td class="right"><?php echo $product['quantity']; ?></td>
                        <td class="right"><?php echo $product['price']; ?></td>
                        <td class="right"><?php echo $product['total']; ?></td>
                    </tr>
                    <?php } ?>
                </tbody>
                <tfoot style="text-align: center;">
                    <?php foreach ($totals as $total) { ?>
                    <tr>
                        <td colspan="3"></td>
                        <td><b><?php echo $total['title']; ?>:</b></td>
                        <td><?php echo $total['text']; ?></td>
                    </tr>
                    <?php } ?>
                </tfoot>
            </table>

            <!-- sub-order history -->
            <!-- change -->
            <table class="list table table-responsive table-bordered">
                <tr>
                    <td>
                        <form method="POST" action="<?= $redirect ?>">
                            <?php echo $ms_account_orders_change_status ?>:
                            <select name="order_status_edit" style="width: 200px;">
                                <?php foreach ($order_statuses as $order_statuses) { ?>
                                <?php if ($order_statuses['order_status_id'] == $order_status_id) { ?>
                                <option value="<?php echo $order_statuses['order_status_id']; ?>" selected="selected"><?php echo $order_statuses['name']; ?></option>
                                <?php } else { ?>
                                <option value="<?php echo $order_statuses['order_status_id']; ?>"><?php echo $order_statuses['name']; ?></option>
                                <?php } ?>
                                <?php } ?>
                            </select>
                            <button  class="btn btn-primary" type="submit" style="padding: 4px;"><?php echo $ms_button_submit; ?></button>
                        </form>
                    </td>
                </tr>
            </table>

            <div class="buttons">
                <div class="pull-left"><a href="<?php echo $link_back; ?>" class="btn btn-primary"><span><?php echo $button_back; ?></span></a></div>
            </div>
            </div>

    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php echo $footer; ?>
