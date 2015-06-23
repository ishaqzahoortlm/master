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
                <!-- <div class="col-md-3"><?php //echo $column_right; ?></div> -->
                <div class="col-md-12">
                    <div class="main-content" >
        
        <div id="content" class="ms-account-transaction ">
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-6" style="padding-left: 0px;">
                        <h4><?php echo $ms_account_products_heading; ?></h4>
                    </div>
                    <div class="col-md-6" style="padding-right: 0px;">
                        <div class="pull-right">
                            <a href="<?php echo $link_create_product; ?>" class=""><button class="btn btn-primary" type="button"><?php echo $ms_create_product; ?></button></a>
                            <a href="<?php echo $link_to_dashboard; ?>" class=""><button class="btn btn-primary" type="button"><?php echo $ms_backto_dashboard; ?></button></a>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="table-responsive">
                <table class="list table table-bordered table-hover" id="list-products">
                    <thead>
                        <tr>
                            <td><?php echo $ms_account_products_image; ?></td>
                            <td><?php echo $ms_account_products_product; ?></td>
                            <td><?php echo $ms_account_product_price; ?></td>
                            <td><?php echo $ms_account_products_sales; ?></td>
                            <td><?php echo $ms_account_products_earnings; ?></td>
                            <td><?php echo $ms_account_products_status; ?></td>
                            <td><?php echo $ms_account_products_date; ?></td>
                            <td class="large"><?php echo $ms_account_products_action; ?></td>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
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
        $('#list-products').dataTable({
            "sAjaxSource": $('base').attr('href') + "index.php?route=seller/account-product/getTableData",
            "aoColumns": [
    {"mData": "image"},
    {"mData": "product_name"},
    {"mData": "product_price"},
    {"mData": "number_sold"},
    {"mData": "product_earnings"},
    {"mData": "product_status"},
    {"mData": "date_created"},
    
    {"mData": "actions", "bSortable": false, "sClass": "text-right"}
            ]
        });

        $(document).on('click', '.button-delete', function () {
            if (!confirm('<?php echo $ms_account_products_confirmdelete; ?>'))
                return false;
        });
    });
</script>
<?php echo $footer; ?>