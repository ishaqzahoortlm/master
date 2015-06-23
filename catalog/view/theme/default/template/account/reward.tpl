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
            <p><?php echo $text_total; ?> <b><?php echo $total; ?></b>.</p>
            <div class="table-responsive">
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <td class="text-left"><?php echo $column_date_added; ?></td>
                            <td class="text-left"><?php echo $column_description; ?></td>
                            <td class="text-right"><?php echo $column_points; ?></td>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if ($rewards) { ?>
                        <?php foreach ($rewards  as $reward) { ?>
                        <tr>
                            <td class="text-left"><?php echo $reward['date_added']; ?></td>
                            <td class="text-left"><?php if ($reward['order_id']) { ?>
                                <a href="<?php echo $reward['href']; ?>"><?php echo $reward['description']; ?></a>
                                <?php } else { ?>
                                <?php echo $reward['description']; ?>
                                <?php } ?></td>
                            <td class="text-right"><?php echo $reward['points']; ?></td>
                        </tr>
                        <?php } ?>
                        <?php } else { ?>
                        <tr>
                            <td class="text-center" colspan="3"><?php echo $text_empty; ?></td>
                        </tr>
                        <?php } ?>
                    </tbody>
                </table>
            </div>
            <div class="row">
                <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
                <div class="col-sm-6 text-right"><?php echo $results; ?></div>
            </div>
            <div class="buttons clearfix" style="display: none;">
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