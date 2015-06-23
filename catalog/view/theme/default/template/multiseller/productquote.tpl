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
                                    <h4><?= $all_product_q ?></h4>
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

                    <th ><?=$ms_qt_name?></th>
                    <th ><?=$ms_qt_product?></th>
                    <th style="width:20%;"><?=$ms_qt_date?></th>
                    <th style="width:10%;"><?=$ms_qt_status?></th>
                    <th style="width:16%;"><?=$ms_qt_actions?></th>
                </tr>
            </thead>
            <tbody>
                <?php 
                foreach ($all_quotes as $row) {
                if($row['status']=='New'){
                $status = '<span class="label label-success" >'.$row['status'].'</span>';
                }else if($row['status']=='Pending'){
                $status = '<span class="label label-info" >'.$row['status'].'</span>';
                }else {
                $status = '<span class="label label-warning" >'.$row['status'].'</span>';
                }
                
                ?>
                <tr class="odd gradeX">

                    <td ><?php echo $row['buyer_name']; ?></td>
                    <td ><?php echo $row['product_name']; ?></td>
                    <td ><?php echo date('M d, Y h:i A', strtotime($row['create_date'])); ?></td>
                    <td ><?php echo $status; ?></td>
                    <td>
                        <a  class="btn-sm btn-default" href="javascript:void(0)" onclick="get_quote_detail(<?=$row['id']?>)" ><i class="fa fa-search"></i></a>
                        <a class="btn-sm btn-primary custom_pading_btn " href="<?=$this->url->link('seller/product-quote/update', 'r_id=' . md5($row['id']))?>"><i class="fa fa-pencil"></i></a>
                        <a class="btn-sm btn-danger " onclick="return confirm('Are you sure you want to delete?')" href="<?=$this->url->link('seller/product-quote/delete', 'r_id=' . md5($row['id']))?>"><i class="fa fa-trash-o"></i></a>
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
                <h4 class="modal-title" id="myModalLabel"><?=$ms_qt_detail?></h4>
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

    function get_quote_detail(id) {
        $.post("index.php?route=product/product/getquote",{id:id} ,function(data){
		  var obj = eval(data);
		   if(obj.status=='success') {
                    $('#id_detail_html').html(obj.html);
                    $('#myModal').appendTo("body").modal('show');
                    $("#myModal").css("z-index", "1500");
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
            {"bSortable": false},
        ],
        'bSortable': false,
        "aaSorting": [[2, "desc"]]
    });

    jQuery('#sample_1_wrapper .dataTables_filter input').addClass("form-control input-medium input-inline");
    jQuery('#sample_1_wrapper .dataTables_length select').addClass("form-control input-xsmall");
</script>
<?php echo $footer; ?>