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
                
                <div class="cathead"><h2> <?php echo $page_heading; ?></h2></div>
                <hr>
                
<!--                <div class="col-md-3"><?php //echo $column_left; ?></div>-->
                <div class="col-md-12">
                    <div class="main-content" >
        <p><?php echo $page_detail; ?></p>
        <div class="pull-right" style="margin-bottom: 8px;" >
            <a href="<?=$this->url->link('account/register-seller', '', 'SSL')?>"><button type="button" class="btn btn-primary"  ><?=$this->config->get('config_btn_supplier_signup')?></button></a></div>
        <table class="table table-striped table-bordered table-hover" id="sample_1" >
                                <thead>
                                    <tr>
                                           
                                        <th ><?=$ms_list_name?></th>
                                        <th ><?=$ms_list_location?></th>
                                        <th ><?=$ms_list_category?></th>
                                        <th style="width:12%;"><?=$ms_list_certifications?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($sellers as $seller) { ?>
                                        <?php if($seller['company']!="") { ?>
                                        <tr class="odd gradeX">
                                           
                                            <td ><a href='<?=$seller['href']?>'><?php echo $seller['company']; ?></a></td>
                                            <td ><?php echo $seller['country']; ?></td>
                                            <td ><?php echo $seller['category']; ?></td>
                                            <td><?php echo $seller['membership_type']; ?></td>
                                        </tr>
                                        <?php } ?>
                                    <?php } ?>
                                </tbody>
                            </table>
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
    $('#sample_1').dataTable({
        "bLengthChange": false,
        "bFilter": false,
        "aoColumns": [
            
            null,
            null,
            null,
            null,
        ],
        "aaSorting": [[ 0, "desc" ]]
    });

    jQuery('#sample_1_wrapper .dataTables_filter input').addClass("form-control input-medium input-inline");
    jQuery('#sample_1_wrapper .dataTables_length select').addClass("form-control input-xsmall");
</script>
<?php echo $footer; ?>