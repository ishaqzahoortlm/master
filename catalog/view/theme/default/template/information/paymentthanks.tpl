<?php echo $header; ?>
<div id="breadcrumb">
    <div class="container">
        <div class="row">
            <a href="<?=$this->url->link('common/home')?>">Home</a><i class="fa fa-angle-double-right"></i>
            <span><?=$breadcrumbs[1]['text']?></span>
        </div>
    </div>
</div>

<div id="bodyiner" class="innerbody">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="cathead"><h2> <?php echo $heading_title; ?></h2></div>
                <hr>
                
                <div class="col-md-12"><?php echo strip_tags($description);  ?></div>
            
            <div class=" pull-right">
                <br/>
                <a href="<?=$this->url->link('seller/account-profile')?>"><button type="button" class="btn" ><?=$button_continue?></button></a></div>
     
            </div>
            </div>
        </div>
    </div>
<?php echo $footer; ?>

