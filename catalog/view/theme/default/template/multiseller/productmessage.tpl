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

                <div class="cathead"><h2> <?php echo $heading_title; ?></h2></div>
                <hr>
                <?php if ($success) { ?>
                    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
                <?php } ?>
            <!--<div class="col-md-3"><?php //echo $column_right;  ?></div> -->
                <div class="col-md-12">
                    <div class="main-content" >
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-6" style="padding-left: 0px;">
                                    <h4><?= $ms_product_message ?></h4>
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

                                        <th ><?= $ms_product_message_by ?></th>
                                        <th ><?= $ms_message_product ?></th>
                                        <th style="width:22%;"><?= $ms_qt_date ?></th>
                                        <th style="width:8%;"><?= $ms_qt_status ?></th>
                                        <th style="width:5%;"><?= $ms_qt_actions ?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php
                                    foreach ($all_message as $row) {
                                        if ($row['status'] == '1') {
                                            $status = '<span class="label label-success" >Read</span>';
                                        } else if ($row['status'] == '0') {
                                            $status = '<span class="label label-info" >New</span>';
                                        }
                                        ?>
                                        <tr class="odd gradeX">

                                            <td ><?php echo $row['customer_name']; ?></td>
                                            <td ><?php echo $row['product_name']; ?></td>
                                            <td ><?php echo date('M d, Y h:i A', strtotime($row['created_at'])); ?></td>
                                            <td id="id_status_<?= $row['id'] ?>"><?php echo $status; ?></td>
                                            <td>
                                                <a class="btn-sm btn-primary custom_pading_btn"  href="<?= $this->url->link('seller/product-message/view', 'r_id=' . md5($row['id'])) ?>"><i class="fa fa-envelope"></i></a>
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






<link href="catalog/view/javascript/data-tables/DT_bootstrap.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/data-tables/jquery.dataTables.js" type="text/javascript"></script>
<script src="catalog/view/javascript/data-tables/DT_bootstrap.js" type="text/javascript"></script>
<script type="text/javascript">





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