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
                <?php if ($error_warning) { ?>
                    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?></div>
                    <?php } ?>
                <div class="col-md-2"></div>
                <div class="col-md-8">
                <div class="main-content"  >
                    
                    <div id="content" class=""><?php echo $content_top; ?>

                        <p><?php echo $text_email; ?></p>
                        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
                                <div class="col-sm-10">
                                    <input type="email" name="email" value="" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group ">
                                <label class="col-sm-2 control-label" for="input-confirm"></label>
                                <div class="col-sm-10"><input type="submit" value="<?php echo $button_continue; ?>" class="btn btn-primary" /></div>
                            </div>
                        </form>
                        <?php echo $content_bottom; ?></div>
                </div>
                    </div>
            </div>
        </div>
    </div>
</div>

<?php echo $footer; ?>