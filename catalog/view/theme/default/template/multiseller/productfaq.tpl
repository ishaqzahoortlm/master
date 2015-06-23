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
                    <div class="col-md-6">
                            <h4><?=$ms_product_faq?></h4>
                    </div>
                    <div class="col-md-6">
                        <div class="pull-right"><a class="" href="<?=$this->url->link('seller/product-faq/create')?>"><button class="btn btn-primary" type="button"><?=$ms_faq_create?></button></a></div>
                    </div>
                 </div>
         </div>
        <br/>
        <table class="table table-striped table-bordered table-hover" id="sample_1" >
            <thead>
                <tr>

                    <th ><?=$ms_faq_q?></th>
                    <th style="width:15%;"><?=$ms_qt_status?></th>
                    <th style="width:18%;"><?=$ms_qt_actions?></th>
                </tr>
            </thead>
            <tbody>
                <?php 
                foreach ($all_faqs as $row) {
                if($row['status']=='1'){
                $status = '<a href="javascript:void(0)" onclick="set_review_status('.$row['id'].')"><span class="label label-success" >Enable</span></a>';
                }else if($row['status']=='0'){
                $status = '<a href="javascript:void(0)" onclick="set_review_status('.$row['id'].')"><span class="label label-default" >Disable</span></a>';
                }
                
                ?>
                <tr class="odd gradeX">

                    <td ><?php echo $row['question']; ?></td>
                    <td id="id_status_<?=$row['id']?>"><?php echo $status; ?></td>
                    <td>
                        <a  class="btn-sm btn-default" href="javascript:void(0)" onclick="get_faq_detail(<?=$row['id']?>)" ><i class="fa fa-search"></i></a>
                        <a class="btn-sm btn-primary custom_pading_btn "  href="<?=$this->url->link('seller/product-faq/edit', 'r_id=' . md5($row['id']))?>"><i class="fa fa-pencil"></i></a>
                        <a class="btn-sm btn-danger " onclick="return confirm('Are you sure you want to delete?')" href="<?=$this->url->link('seller/product-faq/delete', 'r_id=' . md5($row['id']))?>"><i class="fa fa-trash-o"></i></a>
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


<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                </button>
                <h4 class="modal-title" id="myModalLabel"><?=$ms_product_faq?></h4>
            </div>
            <div class="modal-body">
                <div class="row" id="id_detail_html">
                        <div style="width: 100%; padding: 1%; float: left;">
                        <h4 style="padding: 8px; margin-top: 0px; background: #000; color:#fff"><?=$ms_product_faq?></h4>

                        <div style="width: 100%; background-color:#eeeeef; padding: 2px 0px 2px 2px;  float: left; ">
                            <div style="width: 30%; float: left; ">
                                <?=$ms_faq_q?> : 
                            </div>
                            <div style="width: 70%; float: left; " id="id_question">
                                
                            </div>
                        </div>
                        <div style="width: 100%; background-color:#FFF; padding: 2px 0px 2px 2px;  float: left; ">
                            <div style="width: 30%; float: left; ">
                                <?=$ms_faq_a?> :
                            </div>
                            <div style="width: 70%; float: left;" id="id_answer">
                                
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>
</div>


<link href="catalog/view/javascript/data-tables/DT_bootstrap.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/data-tables/jquery.dataTables.js" type="text/javascript"></script>
<script src="catalog/view/javascript/data-tables/DT_bootstrap.js" type="text/javascript"></script>
<script type="text/javascript">

    function get_faq_detail(id) {
        $.post("index.php?route=seller/product-faq/getdetail",{id:id} ,function(data){
		  var obj = eval(data);
		   if(obj.status=='success') {
                    $('#id_question').html(obj.faq_question);
                    $('#id_answer').html(obj.faq_answer);
                    $('#myModal').appendTo("body").modal('show');
                    $("#myModal").css("z-index", "1500");
		   }
	}, "json");
        
        
    }
    
    function set_review_status(id) {
        $.post("index.php?route=seller/product-faq/updatestatus",{id:id} ,function(data){
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
            {"bSortable": false},
        ],
        'bSortable': false,
        "aaSorting": [[3, "desc"]]
    });

    jQuery('#sample_1_wrapper .dataTables_filter input').addClass("form-control input-medium input-inline");
    jQuery('#sample_1_wrapper .dataTables_length select').addClass("form-control input-xsmall");
</script>
<?php echo $footer; ?>