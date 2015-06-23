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
                
                <!-- <div class="col-md-3"><?php //echo $column_right; ?></div>-->
                <div class="col-md-12">
                <div class="main-content" >
        <div id="content" class=" ms-account-order">
            
        <div class="row">
            <div class="col-md-12">
                <div class="col-md-6" style="padding-left: 0px;">
                    <h4><?php echo $ms_account_orders_heading; ?></h4>
                </div>
                <div class="col-md-6" style="padding-right: 0px;">
                    <div class="pull-right">
                        <a href="<?php echo $link_to_dashboard; ?>" class=""><button class="btn btn-primary" type="button"><?php echo $ms_backto_dashboard; ?></button></a>
                    </div>
                </div>
            </div>
        </div>
            <div class="table-responsive">
                <table class="list table table-bordered table-hover" id="list-orders">
                    <thead>
                        <tr>
                            <td class="small"><?php echo $ms_account_orders_id; ?></td>
                            <td class="medium" style="width:13%;"><?php echo $ms_account_orders_customer; ?></td>
                            
                            <td><?php echo $ms_account_orders_products; ?></td>
                            <td class="medium" style="width:13%;"><?php echo $ms_date_created; ?></td>
                            <td class="medium" style="width:13%;"><?php echo $ms_account_orders_total; ?></td>
                            <td><?php echo $ms_status; ?></td>
                            <td class="small" style="width:11%;"><?php echo $ms_action; ?></td>
                        </tr>
                        <tr class="filter" style="display: none;">
                            <td><input type="text"/></td>
                            <td><input type="text"/></td>
                            
                            <td><input type="text"/></td>
                            <td><input type="text"/></td>
                            <td><input type="text"/></td>
                            <td></td>
                            <td></td>
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
        $('#list-orders').dataTable({
            "sAjaxSource": $('base').attr('href') + "index.php?route=seller/account-order/getTableData",
            "aoColumns": [
                {"mData": "order_id"},
                {"mData": "customer_name"},
                
                {"mData": "products", "bSortable": false, "sClass": "products"},
                {"mData": "date_created"},
                {"mData": "total_amount"},
                {"mData": "suborder_status", "bSortable": false},
                {"mData": "view_order", "bSortable": false}
            ],
            "aaSorting": [[3, 'desc']]
        });
    });
</script>

<?php echo $footer; ?>