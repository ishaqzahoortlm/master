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
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">

                <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $entry_newsletter; ?></label>
                    <div class="col-sm-10">
                        <?php if ($newsletter) { ?>
                        <label class="radio-inline">
                            <input type="radio" name="newsletter" value="1" checked="checked" />
                            <?php echo $text_yes; ?> </label>
                        <label class="radio-inline">
                            <input type="radio" name="newsletter" value="0" />
                            <?php echo $text_no; ?></label>
                        <?php } else { ?>
                        <label class="radio-inline">
                            <input type="radio" name="newsletter" value="1" />
                            <?php echo $text_yes; ?> </label>
                        <label class="radio-inline">
                            <input type="radio" name="newsletter" value="0" checked="checked" />
                            <?php echo $text_no; ?></label>
                        <?php } ?>
                    </div>
                </div>

                <div class="form-group ">
                    <label class="col-sm-2 control-label" for="input-confirm"></label>
                    <div class="col-sm-10"><input type="submit" value="<?php echo $button_continue; ?>" class="btn btn-primary" /></div>
                </div>
            </form>
            </div>
    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php echo $footer; ?>