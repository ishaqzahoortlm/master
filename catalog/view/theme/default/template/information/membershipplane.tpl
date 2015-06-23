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
                <div class="container">
        <?php if($this->config->get('config_mem_package_offer')!="") { ?>
        <div class="row"><div class="col-md-12" style="text-align: center; font-weight: bold; " ><p><?=$this->config->get('config_mem_package_offer')?></p></div></div>
        <?php } ?>
        <div class="row">
            <div class="col-md-12"><?php echo strip_tags($description);  ?></div>
        </div>
    </div>
    
    <div class="container">
    <div class="row">
    <?php if(!empty($packages)) { ?>
        <?php if($this->config->get('config_mem_package_title')!="") { ?>
        <h4 style="padding-left: 15px;"> <?=$this->config->get('config_mem_package_title')?></h4>
        <hr/>
        <?php } ?>
            <?php $cnt = 1;  foreach ($packages as $package) { 
            $price = ($package['trial']=='1')?0.00:$package['price'];
            $price_per = ($package['duration']>1)?$package['duration'].' '.ucfirst($package['duration_type']).'s':''.ucfirst($package['duration_type']);
            $modules_array = explode(',',$package['modules'])
            ?>
            <div class="col-md-4">
                <div class="panel panel-default <?=($cnt==1)?'panel_active':''?>" id="id_package_<?=$package['package_id']?>">
                        <div class="text-center pricing_header" ><h2><?=$package['title']?></h2></div>
                        <div class="panel-body text-center">
                            <span class="pkg_price">$<?=number_format($price,2)?></span> / <?=$price_per?>
                        </div>
                        <div style="min-height: 80px;">
                            <p class="text-center"><?=strip_tags(html_entity_decode($package['description'], ENT_QUOTES, 'UTF-8'))?></p>
                        </div>
                        
                        <div class="panel-footer">
                            <a class="no_decoration" href="javascript:void(0)"><button onclick="select_pkg(<?=$package['package_id']?>)" class="btn btn-primary btn-lg btn-block " type="button"><i class="fa fa-check pkg_button" style="<?=($cnt==1)?'':'display: none;'?>" id="id_pkg_check_<?=$package['package_id']?>" ></i> <?=$this->config->get('config_mem_package_btn')?></button></a>
                        </div>
                    </div>
            </div>
            <?php $cnt++; } ?>
        <?php } ?>
        
        <div class="col-md-12 "  >
            <div class="col-md-2">
                <img src="catalog/view/theme/default/image/paypal.jpg" height="35" width="117">
            </div>
            <div class="col-md-3">
                <input type='hidden' name="selected_package" id="selected_package" value="<?=$packages[0]['package_id']?>">
                <?php
                if ($this->customer->isLogged()) { ?>
                <a class="" href="javascript:void(0)"><button id="id_proceed_continue" class="btn btn-lg btn-block btn-primary " type="button">Continue</button></a>
                
                <?php }else { ?>
                <a class="" href="javascript:void(0)"><button id="id_proceed_signup" class="btn btn-lg btn-block btn-primary" type="button"><?=$this->config->get('config_mem_signup_btn')?></button></a>
               <?php } ?>
            </div>
            <div class="col-md-7" style="padding-top: 8px;" >
                <label><input type="checkbox" name="agree" id="agree" value="1" checked="checked" /></label> <span id=""><?=$seller_terms?></span>
                <span id="id_terms_text" style="display: none;"><?=$seller_terms_warning?></span>
            </div>
            
        </div>
        
        
        
        
       
    </div>
    </div>
            </div>
        </div>
    </div>
</div>



<script>
    $('body').removeClass('sidebar-enabled');
    function select_pkg(pid){
        $('.pkg_button').removeClass('fa-check');
        $('#id_pkg_check_'+pid).addClass('fa-check').show();
        $('.panel').removeClass('panel_active');
        $('#id_package_'+pid).addClass('panel_active');
        $('#selected_package').val(pid);
        
    }
    
    <?php
    if ($this->customer->isLogged()) { ?>
        
        $('#id_proceed_continue').click(function (e) {
            var flg = 0;
            var package_id = $('#selected_package').val();
            var terms_alert = $('#id_terms_text').html();
            
            if (package_id=="") {
                alert('Please select a package');
                flg = flg + 1;
            }
            
            if($("#agree").is(':checked')){
                
            } else {
                alert(terms_alert);  // unchecked
                flg = flg + 1;
            }    
            if (flg==0) {
                $.post("index.php?route=module/newslettersubscribe/setpackage", { package_id: package_id,package_plane_page:'update' }, function (data) {
                    var obj = eval(data);
                    if (obj.status == 'success') {
                        window.location = obj.link;
                    }
                }, "json");
            }
     });        
                
    <?php }else { ?>
    $('#id_proceed_signup').click(function (e) {
            var flg = 0;
            var package_id = $('#selected_package').val();
            var terms_alert = $('#id_terms_text').html();
            
            if (package_id=="") {
                alert('Please select a package');
                flg = flg + 1;
            }
            
            if($("#agree").is(':checked')){
                
            } else {
                alert(terms_alert);  // unchecked
                flg = flg + 1;
            }    
            if (flg==0) {
                $.post("index.php?route=module/newslettersubscribe/setpackage", { package_id: package_id,package_plane_page:'yes' }, function (data) {
                    var obj = eval(data);
                    if (obj.status == 'success') {
                        window.location = obj.link;
                    }
                }, "json");
            }
            
        
    });
    <?php } ?>
    
</script>
<?php echo $footer; ?>

