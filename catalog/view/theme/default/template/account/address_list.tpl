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
                <?php if ($error_warning) { ?>
                <div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
                <?php } ?>
                <div class="col-md-3"><?php echo $column_right; ?></div>
                <div class="col-md-9">
                    <div class="main-content" >

                        <div id="content" class=""><?php echo $content_top; ?>
                            <h4><?php echo $text_address_book; ?></h4>
                            <?php if ($addresses) { ?>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <?php foreach ($addresses as $result) { ?>
                                    <tr>
                                        <td class="text-left"><?php echo $result['address']; ?></td>
                                        <td class="text-right">
                                            <a href="<?php echo $result['update']; ?>" class=" btn-primary btn-sm custom_pading_btn"><i class="fa fa-pencil"></i></a>
                                            &nbsp; <a href="<?php echo $result['delete']; ?>" class=" btn-danger btn-sm"><i class="fa fa-trash-o"></i></a>
                                        </td>
                                    </tr>
                                    <?php } ?>
                                </table>
                            </div>
                            <?php } else { ?>
                            <p><?php echo $text_empty; ?></p>
                            <?php } ?>
                            <div class="buttons clearfix">
                                <div class="pull-left" style="display: none;"><a href="<?php echo $back; ?>" class="btn btn-primary"><?php echo $button_back; ?></a></div>
                                <div class="pull-right"><a href="<?php echo $add; ?>"><button class="btn btn-primary"></i> <?php echo $button_new_address; ?></button></a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<?php echo $footer; ?>