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
    <div class="main-content"  >
        <form id="ms-sellerinfo" class="ms-form form-horizontal">
            <div class="col-sm-12 col-md-12">
            	<div class="text-center sfields">
                    <a href="<?php echo $this->url->link('information/membershipplane','','SSL'); ?>"><input type="button" class="btn btn-default btn-xs" value="<?=$btn_member_ship_plane?>"></a><br>
                </div>
            </div>
        </form> 
    </div>
    </div>
    </div>
    </div>
    </div>




<?php $timestamp = time(); ?>
<script>


var msGlobals = {
            timestamp: '<?php echo $timestamp; ?>',
                    token : '<?php echo md5($salt . $timestamp); ?>',
                    session_id: '<?php echo session_id(); ?>',
                    zone_id: '<?php echo $seller['ms.zone_id'] ?>',
                    uploadError: '<?php echo htmlspecialchars($ms_error_file_upload_error, ENT_QUOTES, "UTF-8"); ?>',
                    formError: '<?php echo htmlspecialchars($ms_error_form_submit_error, ENT_QUOTES, "UTF-8"); ?>',
                    config_enable_rte: '<?php echo $this->config->get('msconf_enable_rte'); ?>',
                    zoneSelectError: '<?php echo htmlspecialchars($ms_account_sellerinfo_zone_select, ENT_QUOTES, "UTF-8"); ?>',
                    zoneNotSelectedError: '<?php echo htmlspecialchars($ms_account_sellerinfo_zone_not_selected, ENT_QUOTES, "UTF-8"); ?>'
            };

</script>

<?php echo $footer; ?>