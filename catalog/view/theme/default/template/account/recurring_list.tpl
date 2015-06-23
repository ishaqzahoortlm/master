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
                
                <div class="col-md-3"><?php echo $column_right; ?></div>
                <div class="col-md-9">
                    <div class="main-content" >
        <div id="content" class="">
            <h4><?php echo $heading_title; ?></h4>
            <?php if ($recurrings) { ?>
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <td class="text-left"><?php echo $column_recurring_id; ?></td>
                            <td class="text-left"><?php echo $column_date_added; ?></td>
                            <td class="text-left"><?php echo $column_status; ?></td>
                            <td class="text-left"><?php echo $column_product; ?></td>
                            <td class="text-right"><?php echo $column_action; ?></td>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($recurrings as $recurring) { ?>
                        <tr>
                            <td class="text-left">#<?php echo $recurring['id']; ?></td>
                            <td class="text-left"><?php echo $recurring['date_added']; ?></td>
                            <td class="text-left"><?php echo $status_types[$recurring['status']]; ?></td>
                            <td class="text-left"><?php echo $recurring['name']; ?></td>
                            <td class="text-right"><a href="<?php echo $recurring['href']; ?>" class="btn btn-info"><?php echo $button_view; ?></a></td>
                        </tr>
                        <?php } ?>
                    </tbody>
                </table>
            </div>
            <div class="text-right"><?php echo $pagination; ?></div>
            <?php } else { ?>
            <p><?php echo $text_empty; ?></p>
            <?php } ?>
            <div class="buttons clearfix" style="display:none;">
                <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
            </div>
            </div>
    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php echo $footer; ?>