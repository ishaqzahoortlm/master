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

<div id="bodyiner" class="innerbody">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
    <div class="cathead"><h2> <?php echo $config_promote_title; ?></h2></div>
    <hr>
    
    <div class="container">
        
        <div class="row">
            <div class="col-md-<?=($thumb_promote)?10:12?>"><?php echo strip_tags($description);  ?></div>
            <?php if($thumb_promote) { ?>
            <div class="col-md-2">
            <img src="<?=$thumb_promote?>" >
            </div>
            <?php } ?>
            
        </div>
        <div class="row" style="margin-top: 20px;">
        
            <h3 itemprop="name" class="page-title"><?php echo $config_promote_how_works; ?></h3>
        
            <div class="col-md-3 icontext">
                <span class="arrowicon"></span>
                <i class="fa <?=$config_promote_step_1_icon?>"></i>
                <b><?=$config_promote_step_1_title?></b>
                <p class="info_text_align"><?=$config_promote_step_1_detail?></p>
            </div>
            
            <div class="col-md-3 icontext">
                <span class="arrowicon"></span>
                <i class="fa <?=$config_promote_step_2_icon?>"></i>
                <b><?=$config_promote_step_2_title?></b>
                <p class="info_text_align"><?=$config_promote_step_2_detail?></p>
            </div>
            <div class="col-md-3 icontext">
                <span class="arrowicon"></span>
                <i class="fa <?=$config_promote_step_3_icon?>"></i>
                <b><?=$config_promote_step_3_title?></b>
                <p class="info_text_align"><?=$config_promote_step_3_detail?></p>
            </div>
            <div class="col-md-3 icontext">
                <i class="fa <?=$config_promote_step_4_icon?>"></i>
                <b><?=$config_promote_step_4_title?></b>
                <p class="info_text_align"><?=$config_promote_step_4_detail?></p>
            </div>
        </div>
        <div class="row">
         <?php if($config_promote_membership!="") { ?>   
        <h3 itemprop="name" class="page-title" style="margin:50px 0 10px;"><?php echo $config_promote_membership; ?></h3>
        <?php } ?>
        <?php if($config_promote_membership_detail!="") { ?>
        <p><?=$config_promote_membership_detail?></p>
        <?php } ?>
        <?php if($txt_btn_membership!=""){ ?>
        <div class="pull-right"><a href="<?=$link_btn_membership?>"><button class="btn btn-primary" type="button"><?=$txt_btn_membership?></button></a></div>
        <?php } ?>
        </div>               
        <div class="row" style="margin-top: 130px"><a class="col-md-5 col-md-offset-5" href="<?=$link_get_started?>"><button type="button" class="btn btn-primary btn-lg "> <?=$config_promote_get_started?></button></a></div>
        <?php if($config_promote_contact!=""){ ?>
        <p><?=$config_promote_contact?></p>
        <?php } ?>
    </div>  
            </div>
            </div>
        </div>
    </div>


<?php echo $footer; ?>

<script>
    $('body').removeClass('sidebar-enabled');
</script>