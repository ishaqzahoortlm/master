<?php echo $header; ?>
<link href="catalog/view/javascript/bsmselect-master/css/jquery.bsmselect.css" rel="stylesheet" media="screen" />
<link href="catalog/view/javascript/bsmselect-master/css/example.css" rel="stylesheet" media="screen" />
 
<script src="catalog/view/javascript/bsmselect-master/js/jquery.bsmselect.js" type="text/javascript"></script>
<script src="catalog/view/javascript/bsmselect-master/js/jquery.bsmselect.sortable.js" type="text/javascript"></script>
<script src="catalog/view/javascript/bsmselect-master/js/jquery.bsmselect.compatibility.js" type="text/javascript"></script>

<script src="catalog/view/javascript/jquery.mask.min.js" type="text/javascript"></script>


<script type="text/javascript">//<![CDATA[
     $(document).ready(function () {
                $(".phone_us").mask('(000) 000-0000');
            });
    jQuery(function($) {
        
     $("select[multiple]").bsmSelect({
        
        highlight: 'highlight',
        addItemTarget: 'original',
        removeLabel: '<strong>X</strong>',
        containerClass: 'bsmContainer',                // Class for container that wraps this widget
        listClass: 'bsmList-custom',                   // Class for the list ($ol)
        listItemClass: 'bsmListItem-custom',           // Class for the <li> list items
        listItemLabelClass: 'bsmListItemLabel-custom', // Class for the label text that appears in list items
        removeClass: 'bsmListItemRemove-custom'
      });

    });

  //]]>
  
  
  </script> 
  
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
                
                <div class="row">
                    <div class="col-md-6">
                        <div class="cathead"><h2> <?php echo 'Supplier\'s Account'; ?></h2></div>
                    </div>
                    <div class="col-md-6">
                        <div class="pull-right">
                            <a href="<?php echo $link_to_dashboard; ?>" class=""><button class="btn btn-primary" type="button"><?php echo $ms_backto_dashboard; ?></button></a>
                        </div>
                    </div>
                </div>
                
                <hr style="margin-top: 0px;">
                
                <?php if (isset($success) && ($success)) { ?>
                <div class="alert alert-success"><?php echo $success; ?></div>
                <?php } ?>
                <div class="alert alert-danger" id="profile_error" style="display: none;"></div>
                <?php if (isset($statustext) && ($statustext)) { ?>
                <div class="alert alert-<?php echo $statusclass; ?>" style="display: none;"><?php echo $statustext; ?></div>
                <?php } ?>
                
                <div class="main-content" style="float:none;" >

        <h4><?php echo $ms_account_sellerinfo_heading; ?></h4>
        <form id="ms-sellerinfo" class="ms-form form-horizontal">
            <input type="hidden" name="action" id="ms_action" />
            <div class="col-sm-6">


                <!-- todo status check update -->
                <?php if ($seller['ms.seller_status'] == MsSeller::STATUS_DISABLED || $seller['ms.seller_status'] == MsSeller::STATUS_DELETED) { ?>
                <div class="ms-overlay"></div>
                <?php } ?>
                <div class="form-group required">
                    <?php if (!$this->config->get('msconf_change_seller_nickname') && !empty($seller['ms.nickname'])) { ?>
                    <label class="col-sm-2 control-label" style="display: none;"><?php echo $ms_account_sellerinfo_nickname; ?></label>
                    <div class="col-sm-10">
                        <b><?php echo $seller['ms.nickname']; ?></b>
                    </div>
                    <?php } else { ?>
                    <label class="col-sm-2 control-label" style="display: none;"><?php echo $ms_account_sellerinfo_nickname; ?></label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" placeholder="<?php echo $ms_account_sellerinfo_nickname; ?>"  name="seller[nickname]" value="<?php echo $seller['ms.nickname']; ?>" />
                        <p class="ms-note"><?php echo $ms_account_sellerinfo_nickname_note; ?></p>
                    </div>
                    <?php } ?>
                </div>
                <div class="form-group required">
                    <label class="col-sm-2 control-label" style="display: none;"><?php echo $ms_account_sellerinfo_company; ?></label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control"  placeholder="<?php echo $ms_account_sellerinfo_company; ?>" name="seller[company]" value="<?php echo $seller['ms.company']; ?>" />

                    </div>
                </div>
                <div class="form-group">

                    <label class="col-sm-2 control-label" style="display:none;"><?php echo $entry_email; ?></label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" disabled readonly placeholder="<?php echo $entry_email; ?>" value="<?php echo $seller['c.email']; ?>" />
                        <p class="ms-note" style="display: none;"><input name='seller[newsletter]' value="1" type="checkbox"  > <?=$ms_entry_newletter?></p>
                    </div>

                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label" style="display: none;"><?php echo $ms_account_sellerinfo_paypal; ?></label>
			<div class="col-sm-10">
                            <input type="text" class="form-control"  name="seller[paypal]" placeholder="<?php echo $ms_account_sellerinfo_paypal; ?>" value="<?php echo $seller['ms.paypal']; ?>" />
			</div>
		</div>
                <div class="form-group required" >

                    <label class="col-sm-2 control-label" style="display:none;"></label>
                    <div class="col-sm-10">
                        <textarea name="seller[billing_address]" class="form-control" placeholder="<?=$ms_billing_address?>"><?php echo $seller['ms.billing_address']; ?></textarea>
                    </div>

                </div>
                
                <div class="form-group" style="display: none;">
			<label class="col-sm-2 control-label"><?php echo $ms_account_sellerinfo_description; ?></label>
			<div class="col-sm-10">
				<!-- todo strip tags if rte disabled -->
				<textarea name="seller[description]" id="seller_textarea" class="form-control <?php echo $this->config->get('msconf_enable_rte') ? 'ckeditor' : ''; ?>"><?php echo $this->config->get('msconf_enable_rte') ? htmlspecialchars_decode($seller['ms.description']) : strip_tags(htmlspecialchars_decode($seller['ms.description'])); ?></textarea>
				<p class="ms-note"><?php echo $ms_account_sellerinfo_description_note; ?></p>
			</div>
		</div>
                
                
                <h4><?=$ms_my_products?></h4>
                <div class="row">
                    <?php if ($seller_all['products']) { ?>  
                    <div class="col-sm-12">
                        <?php foreach ($seller_all['products'] as $product){ ?>
                        <div class="col-sm-3" style='padding: 1px;'><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>"  /></a></div>
                        <?php } ?>
                    </div>
                    <?php }else { ?>
                    <div class="col-sm-12">
                        <p><?php echo $ms_catalog_seller_products_empty; ?></p>
                        <a href="<?php echo $link_create_product; ?>" class=""> <button class="btn btn-primary" type="button"> <?php echo $ms_create_product; ?> </button> </a>
                    </div>
                    <?php } ?>
                </div>
                <?php
                $check_featured = 0;
                if($seller_all['products']){
                foreach ($seller_all['products'] as $product){
                if(in_array($product['product_id'],$featured_products)){
                $check_featured ++;
                }
                }
                }
                ?>
                <h4><?=$ms_featured_products?></h4>
                <div class="row">
                    <?php if ($check_featured>0) { ?>  
                    <div class="col-sm-12">
                        <?php foreach ($seller_all['products'] as $product){
                        if(in_array($product['product_id'],$featured_products)){
                        ?>
                        <div class="col-sm-3" style='padding: 1px;'><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>"  /></a></div>
                        <?php } } ?>
                    </div>
                    <?php }else { ?>
                    <div class="col-sm-12">
                        <p><?php echo $ms_no_record; ?></p>
                    </div>
                    <?php } ?>
                </div> 
                <?php
                $check_review = 0;
                if($seller_all['products']){
                foreach ($seller_all['products'] as $product){
                if($product['rating']>0){
                $check_review ++;
                }
                }
                }
                ?>
                <h4><?=$ms_review_products?></h4>

                <div class="row">
                    <?php if ($check_review>0) { ?>  
                    <div class="col-sm-12">
                        <?php foreach ($seller_all['products'] as $product){
                        if($product['rating']>0){
                        ?>
                        <div class="col-sm-3" style='padding: 1px;'><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>"  /></a></div>
                        <?php } } ?>
                    </div>
                    <?php }else { ?>
                    <div class="col-sm-12">
                        <p><?php echo $ms_no_record; ?></p>
                    </div>
                    <?php } ?>
                </div> 




            </div>
            <div class="col-sm-6 col-md-6">
            	<h2><?=$ms_membership_options?></h2>
                <?php 
                $array_assign_module = array();
                if($seller_package_modules['modules']!=""){
                    $array_assign_module = explode(',',$seller_package_modules['modules']);
                }
                
                ?>
                <div>
                    <?php foreach ($package_modules as $pkg_mod) { ?>
                    <label class="radio-inline" style="margin-left: 0px;">
                        <input type="radio" <?=(in_array($pkg_mod['module_id'],$array_assign_module))?'checked':''?> disabled> <?=$pkg_mod['name']?>
                    </label>
                    <?php } ?>
                </div>
                <?php 
                /*
                <div>
                    <label class="radio-inline">
                      <input type="radio"> <i>One Employee</i>
                    </label>      
                    <label class="radio-inline">
                      <input type="radio"> Small business
                    </label>      
                    <label class="radio-inline">
                      <input type="radio"> <i>Mid-Sized</i>
                    </label>      
                    <label class="radio-inline">
                      <input type="radio"> <i>Corporate</i>
                    </label>      
                </div>
               */
               
               ?>
                <div class="">
                    <?php 
                    if(!empty($packages)) {
                        foreach ($packages as $pkg) {
                    ?>
                    <label class="radio-inline">
                        <input type="radio" <?=($seller_package==$pkg['package_id'])?'checked':''?> disabled> <i><?=$pkg['title']?></i>
                    </label>
                        <?php } ?>
                    <?php } ?>
                                   
                </div>
                <br/>
                <div class="text-center sfields">
                	<a href="<?php echo $this->url->link('information/membershipplane','','SSL'); ?>"><input type="button" class="btn btn-primary btn-xs" value="<?=$btn_member_ship_plane?>"></a><br>
                        <br/>
                        <a href="<?php echo $link_create_product; ?>"><input type="button" class="btn btn-primary" value="<?=$btn_new_product?>"></a>
                </div>
            </div>
            <div class="col-sm-12">
                <h4 class="bb_zero"><?=$ms_edit_info?></h4>
                <div class="table-responsive">
                    <span id="total_mission_char" style="display: none;" >200</span> 
                    <table class="table">

                        <tbody>

                            <tr >
                                <td><?=$ms_title_mission?></td>
                                <td class='form-group'>
                                    <textarea name="seller[mission]"  id="ms_mission" class="form-control"><?=htmlspecialchars_decode($seller['ms.description'])?></textarea>
                                    <span style="color:#999;"><i><span id="charLeft"><?=($seller['ms.description']=="")?'200':(200 - (strlen($seller['ms.description'])))?></span>  <?=$ms_mission_char?></i></span>
                                </td>
                            </tr>
                            <tr>
                                <td><?=$ms_h_address?></td>
                                <td class="">
                                    <div class="pull-left">
                                        <select name="seller[country]" class="form-control" style="width: 140px;">
                                            <option value="" selected="selected"><?php echo $ms_account_sellerinfo_country_dont_display; ?></option>
                                            <?php foreach ($countries as $country) { ?>
                                            <option value="<?php echo $country['country_id']; ?>" <?php if ($seller['ms.country_id'] == $country['country_id'] || $country_id == $country['country_id']) { ?>selected="selected"<?php } ?>><?php echo $country['name']; ?></option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                    <div class="pull-left custom_padding_left_3" >
                                        <select name="seller[zone]" class="form-control" style="width: 140px; "></select>
                                    </div>
                                    <div class="form-group">
                                    <div class="pull-left  custom_padding_left_3 " ><input class="form-control" name="seller[city]" placeholder="<?=$ms_city?>" value="<?=$seller['ms.city']?>" type="text"></div>
                                    <div class="pull-left custom_padding_left_3 " ><input class="form-control" name="seller[street]" placeholder="<?=$ms_street?>" value="<?=$seller['ms.street']?>" type="text"></div>
                                    </div>
                                    </td>
                            </tr>
                            <tr>
                                <td><?=$ms_website?></td>
                                <td class="form-group"><input class="form-control" name="seller[website]" value="<?=$seller['ms.website']?>" type="text"></td>
                            </tr>
                            <?php
                            $array_leardes = array();
                            if($seller['ms.leader_ship']!=""){
                            $array_leardes = json_decode($seller['ms.leader_ship'],true);
                            }
                            ?>
                            <tr id="id_leader_ships">
                                <td><?=$ms_leadership?></td>
                                <td>
                                    <div class="pull-left custom_padding_left_3 col-md-4" ><input name="leader_first_name[]" class="form-control" value="<?=(isset($array_leardes[0]['first_name'])?$array_leardes[0]['first_name']:'')?>" placeholder="<?=$ms_lp_name?>" type="text"></div>
                                    <div class="pull-left custom_padding_left_3 col-md-4" ><input name="leader_last_name[]" class="form-control" value="<?=(isset($array_leardes[0]['last_name'])?$array_leardes[0]['last_name']:'')?>" placeholder="<?=$ms_lp_address?>" type="text"></div>
                                    <div class="pull-left custom_padding_left_3 col-md-3" ><input name="leader_title[]" class="form-control" value="<?=(isset($array_leardes[0]['title'])?$array_leardes[0]['title']:'')?>" placeholder="<?=$ms_lp_nature?>" type="text"></div>
                                    <div class="pull-right custom_padding_left_3" ><button id="id_btn_add_more" type="button" class=" btn btn-xs btn-success" >  <i class="fa fa-plus"></i></button>
                                </td>
                            </tr>
                            <?php
                             if(!empty($array_leardes)) {
                            for($ind = 1; $ind<=count($array_leardes)-1; $ind++) {
                            ?>
                            <tr  >
                                <td></td>
                                <td>
                                    <div class="pull-left custom_padding_left_3 col-md-4" ><input name="leader_first_name[]" class="form-control" value="<?=(isset($array_leardes[$ind]['first_name'])?$array_leardes[$ind]['first_name']:'')?>" placeholder="<?=$ms_lp_name?>" type="text"></div>
                                    <div class="pull-left custom_padding_left_3 col-md-4" ><input name="leader_last_name[]" class="form-control" value="<?=(isset($array_leardes[$ind]['last_name'])?$array_leardes[$ind]['last_name']:'')?>" placeholder="<?=$ms_lp_address?>" type="text"></div>
                                    <div class="pull-left custom_padding_left_3 col-md-3" ><input name="leader_title[]" class="form-control" value="<?=(isset($array_leardes[$ind]['title'])?$array_leardes[$ind]['title']:'')?>" placeholder="<?=$ms_lp_nature?>" type="text"></div>
                                    <div class="pull-right custom_padding_left_3" ><button   type="button" class="btn btn-xs btn-danger custome_remove " > <i class="fa fa-trash-o"></i></button>
                                </td>
                            </tr>
                            <?php } } ?>
                            <tr id="id_leader_ships_clone" style="display: none;">
                                <td></td>
                                <td>
                                    <div class="pull-left custom_padding_left_3 col-md-4" ><input name="leader_first_name[]" class="form-control" placeholder="<?=$ms_lp_name?>" type="text"></div>
                                    <div class="pull-left custom_padding_left_3 col-md-4" ><input name="leader_last_name[]" class="form-control" placeholder="<?=$ms_lp_address?>" type="text"></div>
                                    <div class="pull-left custom_padding_left_3 col-md-3" ><input name="leader_title[]" class="form-control" placeholder="<?=$ms_lp_nature?>" type="text"></div>
                                    <div class="pull-right custom_padding_left_3" ><button   type="button" class="btn btn-xs btn-danger custome_remove " > <i class="fa fa-trash-o"></i></button>
                                </td>
                            </tr>
                            
                            <?php
                            $array_contacts = array();
                            if($seller['ms.authorized_contact']!=""){
                            $array_contacts = json_decode($seller['ms.authorized_contact'],true);
                            }
                            
                            ?>
                            
                            <tr id="id_contact">
                                <td><?=$ms_contact_title?></td>
                                <td class="form-group">
                                    <div class="pull-left custom_padding_left_3 width_23 col-sm-2" ><input class="form-control "  name="p_contact_f_name[]" value="<?=(isset($array_contacts[0]['name'])?$array_contacts[0]['name']:'')?>" placeholder="<?=$ms_lp_name?>"  type="text"></div>
                                    <div class="pull-left custom_padding_left_3 width_23 col-sm-2" ><input class="form-control" name="p_contact_l_name[]" value="<?=(isset($array_contacts[0]['position'])?$array_contacts[0]['position']:'')?>" placeholder="<?=$ms_contact_position?>"  type="text"></div>
                                    <div class="pull-left custom_padding_left_3 width_23 col-sm-2" ><input class="form-control phone_us" name="p_contact_phone[]" value="<?=(isset($array_contacts[0]['phone'])?$array_contacts[0]['phone']:'')?>" placeholder="<?=$ms_lp_phone?>"  type="text"></div>
                                    <div class="pull-left custom_padding_left_3 width_23 col-sm-2" ><input class="form-control" name="p_contact_email[]" value="<?=(isset($array_contacts[0]['email'])?$array_contacts[0]['email']:'')?>" placeholder="<?=$ms_entry_email?>"  type="text"></div>
                                    <div class="pull-right custom_padding_left_3" ><button id="id_contact_btn_add_more" type="button" class=" btn btn-xs btn-success" >  <i class="fa fa-plus"></i></button>
                                </td>
                            </tr>
                            
                            <?php
                             if(!empty($array_contacts)) {
                            for($ind = 1; $ind<=count($array_contacts)-1; $ind++) {
                            ?>
                            <tr >
                                <td></td>
                                <td class="form-group">
                                    <div class="pull-left custom_padding_left_3 width_23 col-sm-2" ><input class="form-control "  name="p_contact_f_name[]" value="<?=(isset($array_contacts[$ind]['name'])?$array_contacts[$ind]['name']:'')?>" placeholder="<?=$ms_lp_name?>"  type="text"></div>
                                    <div class="pull-left custom_padding_left_3 width_23 col-sm-2" ><input class="form-control" name="p_contact_l_name[]" value="<?=(isset($array_contacts[$ind]['position'])?$array_contacts[$ind]['position']:'')?>" placeholder="<?=$ms_contact_position?>"  type="text"></div>
                                    <div class="pull-left custom_padding_left_3 width_23 col-sm-2" ><input class="form-control phone_us" name="p_contact_phone[]" value="<?=(isset($array_contacts[$ind]['phone'])?$array_contacts[$ind]['phone']:'')?>" placeholder="<?=$ms_lp_phone?>"  type="text"></div>
                                    <div class="pull-left custom_padding_left_3 width_23 col-sm-2" ><input class="form-control" name="p_contact_email[]" value="<?=(isset($array_contacts[$ind]['email'])?$array_contacts[$ind]['email']:'')?>" placeholder="<?=$ms_entry_email?>"  type="text"></div>
                                    <div class="pull-right custom_padding_left_3" ><button   type="button" class="btn btn-xs btn-danger custome_remove " > <i class="fa fa-trash-o"></i></button>
                                </td>
                            </tr>
                             <?php } } ?>
                            
                            <tr id="id_contact_clone" style="display: none;">
                                <td></td>
                                <td class="form-group">
                                    <div class="pull-left custom_padding_left_3 width_23 col-sm-2" ><input class="form-control "  name="p_contact_f_name[]" value="" placeholder="<?=$ms_lp_name?>"  type="text"></div>
                                    <div class="pull-left custom_padding_left_3 width_23 col-sm-2" ><input class="form-control" name="p_contact_l_name[]" value="" placeholder="<?=$ms_contact_position?>"  type="text"></div>
                                    <div class="pull-left custom_padding_left_3 width_23 col-sm-2" ><input class="form-control phone_us" name="p_contact_phone[]" value="" placeholder="<?=$ms_lp_phone?>"  type="text"></div>
                                    <div class="pull-left custom_padding_left_3 width_23 col-sm-2" ><input class="form-control" name="p_contact_email[]" value="" placeholder="<?=$ms_entry_email?>"  type="text"></div>
                                    <div class="pull-right custom_padding_left_3" ><button   type="button" class="btn btn-xs btn-danger custome_remove " > <i class="fa fa-trash-o"></i></button>
                                </td>
                            </tr>
                            
                            <?php
                            $all_category =  explode(',',$seller['ms.category_id']);
                            ?>
                            <tr>
                                <td><?=$ms_category_title?></td>
                                <td class="form-group multiple_countries">
                                    <select class="form-control" name="seller[category_id][]"  multiple>
                                        <?php foreach ($categories as $category) { ?>
                                        <option value="<?=$category['category_id']?>" <?=(in_array($category['category_id'],$all_category))?'selected':''?>  <?php if ($seller['ms.category_id'] == $category['category_id']) { ?>selected="selected"<?php } ?> ><?=$category['name']?></option>
                                        <?php } ?>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td><?=$ms_org_title?></td>
                                <td>
                                    <select class="form-control" name="seller[organization_type]">
                                        <option value="<?=$ms_org_no_profit?>" <?php if ($seller['ms.organization_type'] == $ms_org_no_profit) { ?>selected="selected"<?php } ?>><?=$ms_org_no_profit?></option> 
                                        <option value="<?=$ms_org_profit?>" <?php if ($seller['ms.organization_type'] == $ms_org_profit) { ?>selected="selected"<?php } ?>><?=$ms_org_profit?></option> 
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <td><?=$ms_revenue?></td>
                                <td>
                                    <select class="form-control" name="seller[revenue]">
                                        <option value="$0 - $99,000" <?php if ($seller['ms.revenue'] == '$0 - $99,000') { ?>selected="selected"<?php } ?> >$0 - $99,000</option>
                                        <option value="$100,000 - $499,999" <?php if ($seller['ms.revenue'] == '$100,000 - $499,999') { ?>selected="selected"<?php } ?> >$100,000 - $499,999</option>
                                        <option value="$500,000 - $1,999,999" <?php if ($seller['ms.revenue'] == '$500,000 - $1,999,999') { ?>selected="selected"<?php } ?> >$500,000 - $1,999,999</option>
                                        <option value="$2,000,000 - $9,999,999" <?php if ($seller['ms.revenue'] == '$2,000,000 - $9,999,999') { ?>selected="selected"<?php } ?> >$2,000,000 - $9,999,999</option>
                                        <option value="$10,000,000 +" <?php if ($seller['ms.revenue'] == '$10,000,000 +') { ?>selected="selected"<?php } ?> >$10,000,000 +</option>
                                    </select>
                                </td>
                            </tr>
                            <?php
                            $all_countries =  explode(',',$seller['ms.countries']);
                            ?>
                            <tr>
                                <td><?=$ms_countries?></td>
                                <td class="form-group multiple_countries">
                                    <select name="seller[countries][]" multiple class="form-control" >
                                        <?php foreach ($countries as $country) { ?>
                                        <option <?=(in_array($country['name'],$all_countries))?'selected':''?> value="<?php echo $country['name']; ?>" ><?php echo $country['name']; ?></option>
                                        <?php } ?>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <td><?=$ms_ship_title?></td>
                                <td>
                                    <select class="form-control" name="seller[shipping_type]">
                                        <option value="<?=$ms_ship_drop?>" <?php if ($seller['ms.shipping_type'] == $ms_ship_drop) { ?>selected="selected"<?php } ?>><?=$ms_ship_drop?></option> 
                                        <option value="<?=$ms_ship_cont?>" <?php if ($seller['ms.shipping_type'] == $ms_ship_cont) { ?>selected="selected"<?php } ?>><?=$ms_ship_cont?></option> 
                                        <option value="<?=$ms_ship_no?>" <?php if ($seller['ms.shipping_type'] == $ms_ship_no) { ?>selected="selected"<?php } ?>><?=$ms_ship_no?></option>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <td><?=$ms_membership_title?></td>
                                <td class="form-group"><input class="form-control" name="seller[membership_type]" value="<?=$seller['ms.membership_type']?>" type="text"></td>
                            </tr>
                            
                            <tr>
                                <td><?=$ms_refrences_title?></td>
                                <td class="form-group">
                                    <div class="pull-left custom_padding_left_3 col-sm-6" ><input class="form-control" name="seller[dunn_number]" value="<?=$seller['ms.dunn_number']?>" placeholder="<?=$ms_refrences_dunn?>"  type="text"></div>
                                    <div class="pull-left custom_padding_left_3 col-sm-6" ><input class="form-control" name="seller[eid]" value="<?=$seller['ms.eid']?>" placeholder="<?=$ms_refrences_employee?>"  type="text"></div>
                                     </td>
                            </tr>
                            
                            <tr>
                                <td><span  data-toggle="tooltip"  data-original-title="<?=$ms_moq_title?>" title=""><?=$ms_moq?></span></td>
                                <td class="form-group">
                                    <select class="form-control" name="seller[moq]" >
                                        <option value="">N/A</option>
                                        <?php for($i=1;$i<=1000;$i++) { ?>
                                        <option <?=($seller['ms.moq']==$i)?'selected':''?> value="<?=$i?>"><?=$i?></option>
                                        <?php } ?>
                                    </select>
                                </td>
                            </tr>
                            
                            <tr>
                                <td><?=$ms_factory_time?></td>
                                <td class="form-group">
                                    <select class="form-control" name="seller[factory_lead_time]" >
                                        <option value="">N/A</option>
                                        <?php for($i=1;$i<=365;$i++) { ?>
                                        <option <?=($seller['ms.factory_lead_time']==$i)?'selected':''?> value="<?=$i?>"><?=$i?> Day<?=($i>9)?'s':''?></option>
                                        <?php } ?>
                                    </select>
                                </td>
                            </tr>
                            
                            <tr>
                                <td><?=$ms_warranty?></td>
                                <td class="form-group">
                                    <?php
                                    $seller['ms.warranty_option'] = ($seller['ms.warranty_option']=="")?'Yes':$seller['ms.warranty_option'];
                                    ?>
                                    <input type="radio" name="seller[warranty_option]" id="warranty_option" class='warranty_option' <?=($seller['ms.warranty_option']=='Yes')?'checked':''?> value="Yes">Yes
                                    <input type="radio" name="seller[warranty_option]" id="warranty_option" class='warranty_option' <?=($seller['ms.warranty_option']=='No')?'checked':''?> value="No">No
                                    <br>
                                    <br>
                                    <textarea style="<?=($seller['ms.warranty_option']=='No')?'display:none;':''?>"  class="form-control" name="seller[warranty_des]" id="warranty_des" placeholder="<?=$ms_w_description?>" ><?=$seller['ms.warranty_des']?></textarea></td>
                            </tr>

                        </tbody>
                    </table>
                </div>
            </div>
            <div class="col-sm-12">
                <div class="form-group ">
                    <label class="col-sm-4 control-label" style="width:28%; " for="input-confirm"></label>
                    <div class="col-sm-8"><input type="button" id="ms-submit-button" value="<?php echo $button_continue; ?>" class="btn btn-primary" /></div>
                </div>
            </div> 
                
                </div>
            </div>
        </div>
    </div>
</div>



<?php $timestamp = time(); ?>
<script>



    $(function(){
        
        
        
        $(".warranty_option").click(function () {
 
	var option_val = $('input:radio[id=warranty_option]:checked').val();
        if(option_val=='No'){
            $('#warranty_des').val('').hide();
        }else {
            $('#warranty_des').val('<?=$seller["ms.warranty_des"]?>').show();
        }
 
    });
        
    $('.custome_remove').click(function (){
    $(this).parent('div').parent('td').parent('tr').remove();
    });
     $('#id_btn_add_more').click(function (){
    $("[id^='id_leader_ships']:last").after($('#id_leader_ships_clone').clone(true).show());
    });
    
    $('#id_contact_btn_add_more').click(function (){
        
        $("[id^='id_contact']:last").after($('#id_contact_clone').clone(true).show());
         $(".phone_us").mask('(000) 000-0000');
    });
    
    $('#ms_mission').keyup(function() {
    var total_sms_char = $("#total_mission_char").html();
            var len = this.value.length;
            if (len >= total_sms_char) {
    this.value = this.value.substring(0, total_sms_char);
    }
    total_remaining = total_sms_char - len;
            if (total_remaining < 0)
            total_remaining = 0;
            $('#charLeft').text(total_remaining);
    });
    });
            /* function countWords(){
             s = document.getElementById("ms_mission").value;
             s = s.replace(/(^\s*)|(\s*$)/gi,"");
             s = s.replace(/[ ]{2,}/gi," ");
             s = s.replace(/\n /,"\n");
             //document.getElementById("wordcount").value = s.split(' ').length;
             var total_sms_char = $("#total_mission_char").html();
             total_remaining = total_sms_char - (s.split(' ').length);
             if (total_remaining < 0)
             total_remaining = 0;
             $('#charLeft').text(total_remaining);
             } */


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