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
                <?php if ($success) { ?>
                    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
                    <?php } ?>
                <!--<div class="col-md-3"><?php //echo $column_right; ?></div> -->
                <div class="col-md-12">
                    <div class="main-content" >
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-6" style="padding-left: 0px;">
                                    <h4><?= $ms_product_return_heading?></h4>
                                </div>
                                <div class="col-md-6" style="padding-right: 0px;">
                                    <div class="pull-right">
                                        <a href="<?php echo $link_to_dashboard; ?>" class=""><button class="btn btn-primary" type="button"><?php echo $ms_backto_dashboard; ?></button></a>
                                    </div>
                                </div>
                            </div>
                        </div>
        <div class="table-responsive">
        <table class="table table-striped table-bordered table-hover" id="sample_1" >
            <thead>
                <tr>

                    <th style="width:13%;"><?=$ms_order_id?></th>
                    <th ><?=$ms_order_customer?></th>
                    <th ><?=$ms_order_product?></th>
                    <th style="width:22%;"><?=$ms_return_date?></th>
                    <th style="width:15%;"><?=$ms_qt_status?></th>
                    <th style="width:4%;"><?=$ms_qt_actions?></th>
                </tr>
            </thead>
            <tbody>
                <?php 
                foreach ($all_returns as $row) {
                if($row['return_status_id']=='3'){
                $status = '<span class="label label-success" >Completed</span>';
                }else if($row['return_status_id']=='2'){
                $status = '<span class="label label-info" >Awaiting Products</span>';
                }else if($row['return_status_id']=='1'){
                $status = '<span class="label label-info" >Pending</span>';
                }
                
                ?>
                <tr class="odd gradeX">

                    <td ><?php echo $row['order_id']; ?></td>
                    <td ><a target="_blank" href="<?=$this->url->link('seller/account-order/viewdetail', 'id=' . md5($row['customer_id']))?>"><?php echo $row['firstname'].' '.$row['lastname']; ?></a></td>
                    <td ><a target="_blank" href="<?=$this->url->link('product/product', 'product_id=' . $row['product_id'], 'SSL')?>"><?php echo $row['product']; ?></a></td>
                    <td ><?php echo date('M d, Y h:i A', strtotime($row['date_added'])); ?></td>
                    <td id="id_status_<?=$row['review_id']?>"><?php echo $status; ?></td>
                    <td>
                        <a  class="btn-sm btn-primary custom_pading_btn" href="<?=$this->url->link('seller/product-return/edit', 'return_id=' . md5($row['return_id']), 'SSL')?>" ><i class="fa fa-pencil"></i></a>
                        
                    </td>
                </tr>
                <?php } ?>
            </tbody>
        </table>
        </div>    
    </div>
                </div>
            </div>
        </div>
    </div>
</div>



<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                </button>
                <h4 class="modal-title" id="myModalLabel"><?=$product_review?></h4>
            </div>
            <div class="modal-body">
                <div class="row" id="id_detail_html">
                    

                </div>
            </div>
        </div>
    </div>
</div>


<link href="catalog/view/javascript/data-tables/DT_bootstrap.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/data-tables/jquery.dataTables.js" type="text/javascript"></script>
<script src="catalog/view/javascript/data-tables/DT_bootstrap.js" type="text/javascript"></script>
<script type="text/javascript">

    function get_review_detail(id) {
        $.post("index.php?route=product/product/getreview",{id:id} ,function(data){
		  var obj = eval(data);
		   if(obj.status=='success') {
                    $('#id_detail_html').html(obj.html);
                    $('#myModal').appendTo("body").modal('show');
                    $("#myModal").css("z-index", "1500");
		   }
	}, "json");
        
        
    }
    
    function set_review_status(id) {
        $.post("index.php?route=seller/product-review/updatestatus",{id:id} ,function(data){
		  var obj = eval(data);
		   if(obj.status=='success') {
                    $('#id_status_'+id).html(obj.html);
                   }
	}, "json");
        
        
    }
    
    

    $('#sample_1').dataTable({
        "bLengthChange": false,
        "aoColumns": [
            null,
            null,
            null,
            null,
            null,
            {"bSortable": false},
        ],
        'bSortable': false,
        "aaSorting": [[3, "desc"]]
    });

    jQuery('#sample_1_wrapper .dataTables_filter input').addClass("form-control input-medium input-inline");
    jQuery('#sample_1_wrapper .dataTables_length select').addClass("form-control input-xsmall");
</script>
<?php echo $footer; ?>