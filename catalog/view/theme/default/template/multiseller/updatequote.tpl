<?php echo $header; ?>
<link href="catalog/view/javascript/bsmselect-master/css/jquery.bsmselect.css" rel="stylesheet" media="screen" />
<link href="catalog/view/javascript/bsmselect-master/css/example.css" rel="stylesheet" media="screen" />
 
<script src="catalog/view/javascript/bsmselect-master/js/jquery.bsmselect.js" type="text/javascript"></script>
<script src="catalog/view/javascript/bsmselect-master/js/jquery.bsmselect.sortable.js" type="text/javascript"></script>
<script src="catalog/view/javascript/bsmselect-master/js/jquery.bsmselect.compatibility.js" type="text/javascript"></script>
<script type="text/javascript">//<![CDATA[
     
    jQuery(function($) {
        
     $(".select_multiple").bsmSelect({
        
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
<link href="catalog/view/javascript/multiselect/dist/css/bootstrap-multiselect.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/multiselect/dist/js/bootstrap-multiselect.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $('#all_units').multiselect({
            buttonClass: 'form-control',
            buttonWidth: '100%',
            buttonText: function(options, select) {
                return 'Select';
            },
            onChange: function(option, checked, select) {
                if(checked){
                    $('#id_'+$(option).val()).show();
                }else {
                    $('#id_'+$(option).val()).hide();
                }
            }
        });
    });
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
                
                <div class="cathead"><h2> <?php echo $heading_title; ?></h2></div>
                <hr>
                <div class="alert alert-success" style="display: none;" id="id_success"></div>
                <div class="alert alert-danger" style="display: none;" id="id_errors"></div>
                <div class="col-md-3"><?php echo $column_right; ?></div>
                <div class="col-md-9">
                    <div class="main-content" >
        <div class="">
            
            <div class="col-sm-8">
                <form class="form-horizontal" action='' method="post" name="form_q" id="form_q">
                    <input type="hidden" name="seller_id" id="seller_id" value="<?=$quote_detail['seller_id']?>">
                    <input type="hidden" name="buyer_id" id="buyer_id" value="<?=$quote_detail['buyer_id']?>">
                    <input type="hidden" name="req_id" id="req_id" value="<?=$quote_detail['id']?>">
                    <input type="hidden" name="req_shipping" id="req_shipping" value="<?=$quote_detail['need_seller_shipping']?>" >
                <h4><?=$heading_buyer?></h4>
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_company?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$quote_detail['buyer_company']?>" name="buyer_company" id="buyer_company" class="form-control">
                    </div>
                </div>
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_name?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$quote_detail['buyer_name']?>" name="buyer_name" id="buyer_name" class="form-control">
                    </div>
                </div>
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_email?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$quote_detail['buyer_email']?>" name="buyer_email" id="buyer_email" class="form-control">
                    </div>
                </div>
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_phone?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$quote_detail['buyer_phone']?>" name="buyer_phone" id="buyer_phone" class="form-control phone_us">
                    </div>
                </div>
               
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_country?></label>
                    <div class="col-sm-9">
                        <select name="buyer_country" id="buyer_country"  class="form-control">
                            <option value=""><?=$entry_select?></option>
                            <?php foreach($countries as $country){ ?>
                            <option <?=($quote_detail['buyer_country']==$country['country_id'])?'selected':''?> value="<?=$country['country_id']?>"><?=$country['name']?></option>
                            <?php } ?>
                        </select>
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_state?></label>
                    <div class="col-sm-9">
                        <select name="zone_id" id="input-zone" class="form-control" >
                            <option value=""><?=$entry_select?></option>
                        </select>
                        
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_city?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$quote_detail['buyer_city']?>" name="buyer_city" id="buyer_city" class="form-control ">
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_address?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$quote_detail['buyer_address']?>" name="buyer_address" id="buyer_address" class="form-control ">
                    </div>
                </div>
                <h4><?=$heading_product?></h4>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_name?></label>
                    <div class="col-sm-9">
                        <input type="hidden" value="<?=$quote_detail['product_id']?>" name="product_id" id="product_id">
                        <input type="text" value="<?=$quote_detail['product_name']?>" readonly name="product_name" id="product_name" class="form-control">
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_product_detail?></label>
                    <div class="col-sm-9">
                        <textarea name="product_detail" id="product_detail" class="form-control "><?=$quote_detail['product_detail']?></textarea>
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_qty?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$quote_detail['quantity']?>" onKeyPress="return numbersonly(event)" name="quantity" id="quantity" class="form-control ">
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_price?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$quote_detail['price']?>"  name="price" id="price" class="form-control ">
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_currency?> <?=$quote_detail['currency']?></label>
                    <div class="col-sm-9 ">
                        <select name="currency" id="currency" class="form-control ">
                            <?php foreach ($currency as $key =>$val) { ?>
                            <option value="<?=$key?>" <?=($quote_detail['currency']==$key)?'selected':''?>><?=$key?></option>
                            <?php } ?>
                        </select> 
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_unit?></label>
                    <div class="col-sm-9 unit">
                       <select name="unit" id="unit" class="form-control">
                            <?php foreach ($weight_classes as $weight_class) { ?>
                             <option value="<?php echo $weight_class['title']; ?>" <?=($quote_detail['unit']==$weight_class['title'])?'selected':''?>><?php echo $weight_class['title']; ?></option>
                            <?php } ?>
                       </select>
                    </div>
                </div>
                
                <div class="form-group ">
                    <label class="col-sm-3 control-label"><?=$entry_billing?></label>
                    <div class="col-sm-9">
                        <textarea name="billing_address" id="billing_address" class="form-control "><?=$quote_detail['billing_address']?></textarea>
                    </div>
                </div>
                
                 <h4><?=$heading_shipping?> <span style="font-size: 12px; font-weight: normal; "><?=$heading_shipping_sub?></span></h4>
                
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$text_destination?></label>
                    <div class="col-sm-9">
                        <select name="buyer_destination" id="buyer_destination"  class="form-control">
                            <option value=""><?=$entry_select?></option>
                            <?php foreach($countries as $country){ ?>
                            <option <?=($quote_detail['buyer_destination']==$country['country_id'])?'selected':''?> value="<?=$country['country_id']?>"><?=$country['name']?></option>
                            <?php } ?>
                        </select>
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$text_payment_terms?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$quote_detail['buyer_payment_terms']?>"  name="buyer_payment_terms" id="buyer_payment_terms" class="form-control ">
                    </div>
                </div>
                <?php
                $ship_array = explode(',',$quote_detail['buyer_shipping_method']);
                ?>
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$text_shipping_method?></label>
                    <div class="col-sm-9">
                        <select name="buyer_shipping_method[]" id="buyer_shipping_method" multiple  class="form-control select_multiple">
                            <option <?=(in_array('Air',$ship_array))?'selected':''?>  value="Air">Air</option>
                            <option <?=(in_array('Sea',$ship_array))?'selected':''?>  value="Sea">Sea</option>
                            
                        </select>
                    </div>
                </div>
                <?php 
                $oring_cnt = explode(',',$seller_countries);
                //$oring_cnt = $oring_cnt;
                ?>
                <h4><?=$heading_shipping?> <span style="font-size: 12px; font-weight: normal; "><?=$heading_shipping_subheading?></span></h4>
                <div class="form-group <?=($quote_detail['need_seller_shipping']==1)?'required':''?> ">
                    <label class="col-sm-3 control-label"><?=$text_origin?></label>
                    <div class="col-sm-9">
                        <select name="origin_country" id="origin_country"  class="form-control">
                            <option value=""><?=$entry_select?></option>
                            <?php foreach($oring_cnt as $k=>$v){ ?>
                            <option  <?=($quote_detail['origin_country']==$v)?'selected':''?>  value="<?=$v?>"><?=$v?></option>
                            <?php } ?>
                        </select>
                    </div>
                </div>
                
                <div class="form-group <?=($quote_detail['need_seller_shipping']==1)?'required':''?>">
                    <label class="col-sm-3 control-label"><?=$text_lead_time?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$quote_detail['lead_time']?>"  name="lead_time" id="lead_time" class="form-control ">
                    </div>
                </div>
                
                <div class="form-group <?=($quote_detail['need_seller_shipping']==1)?'required':''?>">
                    <label class="col-sm-3 control-label"><?=$text_transit_time?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$quote_detail['transit_time']?>"  name="transit_time" id="transit_time" class="form-control ">
                    </div>
                </div>
                
                <div class="form-group <?=($quote_detail['need_seller_shipping']==1)?'required':''?>">
                    <label class="col-sm-3 control-label"><?=$text_dispatch?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$quote_detail['dispatch_place']?>"  name="dispatch_place" id="dispatch_place" class="form-control ">
                    </div>
                </div>
                
                <div class="form-group <?=($quote_detail['need_seller_shipping']==1)?'required':''?>">
                    <label class="col-sm-3 control-label"><?=$text_port_name?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$quote_detail['nearest_port']?>"  name="nearest_port" id="nearest_port" class="form-control ">
                    </div>
                </div>
                
                <?php
                $goods_per_array = explode(',',$quote_detail['goods_per_container']);
                ?>
                
                <div class="form-group <?=($quote_detail['need_seller_shipping']==1)?'required':''?>">
                    <label class="col-sm-3 control-label"><?=$text_gp_container?></label>
                    <div class="col-sm-9">
                        
                        <select name="goods_per_container[]" id="goods_per_container" multiple  class="form-control select_multiple">
                            <option <?=(in_array('20 ft container',$goods_per_array))?'selected':''?>  value="20 ft container">20 ft container</option>
                            <option <?=(in_array('40 DC ft container',$goods_per_array))?'selected':''?>  value="40 DC ft container">40 DC ft container</option>
                            <option <?=(in_array('40 HC ft container',$goods_per_array))?'selected':''?>  value="40 HC ft container">40 HC ft container</option>
                        </select>
                    
                    </div>
                </div>
                <?php
                $array_units = array('EXW','FCA','FOB','CPT','CIP','DAT','DAP','DDP');
                
                $units_saved_keys = $units_saved = array();
                
                if($quote_detail['unit_inco_terms']!="") {
                $units_saved = json_decode($quote_detail['unit_inco_terms'],true);
                foreach ($units_saved as $kk=>$vv) {
                    $units_saved_keys[] = $kk; 
                }
                }
                ?>
                <div class="form-group <?=($quote_detail['need_seller_shipping']==1)?'required':''?>">
                    <label class="col-sm-3 control-label"><?=$text_up_inco_terms?><br>
                        Click here to view <a href="<?=$cms_resources_link?>" target=_blank><?=$cms_resources?></a>
                    </label>
                    <div class="col-sm-9">
                        <input type="hidden" name="all_price_units" id="all_price_units" value="<?=implode(',',$array_units)?>">
                        <select id="all_units" name="all_units[]" multiple="multiple" class="form-control">
                            <?php foreach ($array_units as $uk=>$uv) { ?>
                            <option <?=(in_array($uv,$units_saved_keys))?'selected':''?> value="<?=$uv?>"><?=$uv?></option>
                            <?php } ?>
                     </select>
                        <div id="" class="">
                            <?php foreach ($array_units as $uk=>$uv) { ?>
                            <div id="id_<?=$uv?>" style="padding-top: 8px; <?=(in_array($uv,$units_saved_keys))?'':'display: none;'?>">
                                <label control-label><?=$uv?></label> : <input type='text' name="unit_option_price[<?=$uv?>]" value="<?=(isset($units_saved[$uv]))?$units_saved[$uv]:''?>" placeholder="Unit Price" class="form-control" style="float:right; width: 90%;" />
                            </div>
                            <?php } ?>
                            
                            
                        </div>
                   </div>
                </div>
                
                
                
                <h4><?=$entry_other?></h4>
                <div class="form-group ">
                    <label class="col-sm-3 control-label"><?=$entry_reference?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$quote_detail['reference']?>"  name="reference" id="reference" class="form-control ">
                    </div>
                </div>
                <div class="form-group ">
                    <label class="col-sm-3 control-label"><?=$entry_additional_detail?></label>
                    <div class="col-sm-9">
                        <textarea name="message" id="message" class="form-control "><?=$quote_detail['message']?></textarea>
                    </div>
                </div>
                
                <div class="form-group ">
                    <label class="col-sm-3 control-label"><?=$entry_status?></label>
                    <div class="col-sm-9">
                        <select name="status" id="status" class="form-control">
                             <option value="New" <?=($quote_detail['status']=='New')?'selected':''?>>New</option>
                             <option value="Pending" <?=($quote_detail['status']=='Pending')?'selected':''?>>Pending</option>
                             <option value="Closed" <?=($quote_detail['status']=='Closed')?'selected':''?>>Closed</option>
                            
                       </select>
                    </div>
                </div>
                
                <div class="form-group ">
                    <label class="col-sm-3 control-label">&nbsp;</label>
                    <div class="col-sm-9">
                        <input type="button" value="<?=$btn_send?>" name="id_submit_q" id="id_submit_q" class="btn btn-primary"> &nbsp;&nbsp;
                        <input type="button" value="<?=$btn_save?>" name="id_save_q" id="id_save_q" class="btn btn-default">
                    </div>
                </div>
                </form>
            </div>
        </div>
    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<?php
    $zone_id = $quote_detail['buyer_state'];
    ?>
<script src="catalog/view/javascript/jquery.mask.min.js" type="text/javascript"></script>
<script type="text/javascript">
     $(document).ready(function () {
                $(".phone_us").mask('(000) 000-0000');
            });
  </script> 
  
<script type="text/javascript"><!--
    
    $('#id_submit_q').on('click', function () {
        $('#id_errors,#id_success').html('').hide();
        $('div .form-group').removeClass('has-error');
        $.post("index.php?route=product/product/editquote", ($('#form_q').serialize() + '&' + $.param({ btn_type: 'send' })),function(data){
		  var obj = eval(data);
		   if(obj.status=='success') {
				$('#id_success').html(obj.error).show();
                               // $('#form_q')[0].reset();
                                $("html, body").animate({ scrollTop: 0 }, "slow");
			}else{
                                var arry_errors = obj.required;
                                for (error in obj.required) {
                                    $('#' + error + '').parents('.form-group').addClass('has-error');
                                }
				$('#id_errors').html(obj.error).show();
                                $("html, body").animate({ scrollTop: 0 }, "slow");
			}
	}, "json");
        
    });
    
    $('#id_save_q').on('click', function () {
        $('#id_errors,#id_success').html('').hide();
        $('div .form-group').removeClass('has-error');
        $.post("index.php?route=product/product/editquote", ($('#form_q').serialize() + '&' + $.param({ btn_type: 'save' })),function(data){
		  var obj = eval(data);
		   if(obj.status=='success') {
				$('#id_success').html(obj.error).show();
                               // $('#form_q')[0].reset();
                                $("html, body").animate({ scrollTop: 0 }, "slow");
			}else{
                                var arry_errors = obj.required;
                                for (error in obj.required) {
                                    $('#' + error + '').parents('.form-group').addClass('has-error');
                                }
				$('#id_errors').html(obj.error).show();
                                $("html, body").animate({ scrollTop: 0 }, "slow");
			}
	}, "json");
        
    });
    
    $('select[name=\'buyer_country\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=account/account/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'buyer_country\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},
		complete: function() {
			$('.fa-spin').remove();
		},
		success: function(json) {
			$('.fa-spin').remove();
	
			if (json['postcode_required'] == '1') {
				$('input[name=\'postcode\']').parent().parent().addClass('required');
			} else {
				$('input[name=\'postcode\']').parent().parent().removeClass('required');
			}
	
			html = '<option value=""><?php echo $entry_select; ?></option>';
	
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
					html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	
					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
						html += ' selected="selected"';
			  		}
	
			  		html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
	
			$('select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'buyer_country\']').trigger('change');
function numbersonly(e) {
        var unicode = e.charCode ? e.charCode : e.keyCode
        if (unicode != 8) { //if the key isn't the backspace key (which we should allow)
            if (unicode < 48 || unicode > 57) //if not a number
                return false //disable key press
        }
    }
//--></script>  

  
<?php echo $footer; ?>
