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
                
                <div class="cathead"><h2> <?php echo $heading_title; ?></h2></div>
                <hr>
                <div class="alert alert-success" style="display: none;" id="id_success"></div>
                <div class="alert alert-danger" style="display: none;" id="id_errors"></div>
            
                <div class="col-md-3"><?php echo $column_left; ?></div>
                <div class="col-md-9">
                    <div class="main-content" >
        <div class="row">
            <div class="col-sm-8">
                <form class="form-horizontal" action='' method="post" name="form_q" id="form_q">
                    <input type="hidden" name="buyer_id" id="buyer_id" value="<?=$buyer_id?>">
                    <input type="hidden" value="" name="product_id" id="product_id">
                        
                    <h3><?=$heading_title_multiple?></h3>
                    <h4><?=$heading_buyer?></h4>
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_company?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$buyer_company?>" name="buyer_company" id="buyer_company" class="form-control">
                    </div>
                </div>
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_name?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$buyer_name?>" name="buyer_name" id="buyer_name" class="form-control">
                    </div>
                </div>
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_email?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$buyer_email?>" name="buyer_email" id="buyer_email" class="form-control">
                    </div>
                </div>
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_phone?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$buyer_phone?>" name="buyer_phone" id="buyer_phone" class="form-control phone_us">
                    </div>
                </div>
               
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_country?></label>
                    <div class="col-sm-9">
                        <select name="buyer_country" id="buyer_country"  class="form-control">
                            <option value=""><?=$entry_select?></option>
                            <?php foreach($countries as $country){ ?>
                            <option <?=($buyer_country==$country['country_id'])?'selected':''?> value="<?=$country['country_id']?>"><?=$country['name']?></option>
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
                        <input type="text" value="<?=$buyer_city?>" name="buyer_city" id="buyer_city" class="form-control ">
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_address?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$buyer_address?>" name="buyer_address" id="buyer_address" class="form-control ">
                    </div>
                </div>
                <h4><?=$heading_product?></h4>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$text_category?></label>
                    <div class="col-sm-9">
                        <select name="category_id" id="category_id" class="form-control ">
                            <option value=""><?=$entry_select?></option>
                            <?php foreach ($categories as $category) { ?>
                            <option value="<?=$category['category_id']?>"><?=$category['name']?></option>
                            <?php } ?>
                        </select>
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_name?></label>
                    <div class="col-sm-9" id="id_all_products">
                        <select name="product_name" id="product_name" class="form-control ">
                            <option value=""><?=$entry_select?></option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_product_detail?></label>
                    <div class="col-sm-9">
                        <textarea name="product_detail" id="product_detail" class="form-control "></textarea>
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_qty?></label>
                    <div class="col-sm-9">
                        <input type="text" value="" onKeyPress="return numbersonly(event)" name="quantity" id="quantity" class="form-control ">
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_currency?></label>
                    <div class="col-sm-9 ">
                        <select name="currency" id="currency" class="form-control ">
                            <?php foreach ($currency as $key =>$val) { ?>
                            <option value="<?=$key?>"><?=$key?></option>
                            <?php } ?>
                        </select> 
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$entry_unit?></label>
                    <div class="col-sm-9 ">
                       <select name="unit" id="unit" class="form-control">
                            <?php foreach ($weight_classes as $weight_class) { ?>
                             <option value="<?php echo $weight_class['title']; ?>"><?php echo $weight_class['title']; ?></option>
                            <?php } ?>
                       </select>
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$text_manufacturers?></label>
                    <div class="col-sm-9 " id="id_manufacturer">
                        <select name="manufacturer[]" multiple id="manufacturer" class="form-control">
                            
                       </select>
                    </div>
                </div>
                
                 <h4><?=$heading_shipping?> <span style="font-size: 12px; font-weight: normal; "><?=$heading_shipping_sub?></span></h4>
                
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$text_destination?></label>
                    <div class="col-sm-9">
                        <select name="buyer_destination" id="buyer_destination"  class="form-control">
                            <option value=""><?=$entry_select?></option>
                            <?php foreach($countries as $country){ ?>
                            <option <?=($buyer_country==$country['country_id'])?'selected':''?> value="<?=$country['country_id']?>"><?=$country['name']?></option>
                            <?php } ?>
                        </select>
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$text_payment_terms?></label>
                    <div class="col-sm-9">
                        <input type="text" value=""  name="buyer_payment_terms" id="buyer_payment_terms" class="form-control ">
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$text_shipping_method?></label>
                    <div class="col-sm-9">
                        <select name="buyer_shipping_method[]" id="buyer_shipping_method" multiple  class="form-control">
                            <option  value="Air">Air</option>
                            <option  value="Sea">Sea</option>
                            
                        </select>
                    </div>
                </div>
                 
                <div class="form-group ">
                    <label class="col-sm-3 control-label"><?=$text_required_shipping?></label>
                    <div class="col-sm-9">
                        <label><input type="radio" name="need_seller_shipping" id="need_seller_shipping" value="1" checked > Yes</label>
                        <label><input type="radio" name="need_seller_shipping" id="need_seller_shipping" value="0"> No</label>
                    </div>
                </div> 
                
                <h4><?=$entry_other?></h4>
                <div class="form-group ">
                    <label class="col-sm-3 control-label"><?=$entry_reference?></label>
                    <div class="col-sm-9">
                        <input type="text" value=""  name="reference" id="reference" class="form-control ">
                    </div>
                </div>
                <div class="form-group ">
                    <label class="col-sm-3 control-label"><?=$entry_additional_detail?></label>
                    <div class="col-sm-9">
                        <textarea name="message" id="message" class="form-control "></textarea>
                    </div>
                </div>
                
                <div class="form-group ">
                    <label class="col-sm-3 control-label">&nbsp;</label>
                    <div class="col-sm-9">
                        <input type="button" value="<?=$btn_submit?>" name="id_submit_q" id="id_submit_q" class="btn btn-primary">
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


  
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                </button>
                <h4 class="modal-title" id="myModalLabel"><?php echo $this->config->get('config_quote_alert_title'); ?></h4>
            </div>
            <div class="modal-body">
                <div class="row" id="">
                    <div class='alert alert-warning'>
                        <?=$this->config->get('config_quote_alert_detail');?>
                    </div> 

                </div>
            </div>
        </div>
    </div>
</div>  
<script src="catalog/view/javascript/jquery.mask.min.js" type="text/javascript"></script>
<script type="text/javascript">
     $(document).ready(function () {
                $(".phone_us").mask('(000) 000-0000');
            });
    
    <?php if($this->config->get('config_quote_alert_option')=='Yes') { ?>       
     get_quote_popup();       
    <?php } ?> 
    
    function get_quote_popup() {
        $('#myModal').appendTo("body").modal('show');
        $("#myModal").css("z-index", "1500");
     }        
  </script> 
  
<script type="text/javascript"><!--
    
    $('#category_id').on('change', function () {
        $.post("index.php?route=product/product/getproducts", { category_id:$('#category_id').val() },function(data){
		var obj = eval(data);
		if(obj.status=='success') {
                    $('#id_all_products').html(obj.products).show();
                    $('#id_manufacturer').html(obj.manufacturer).show();
                }
	}, "json");
    });
    
   
    function set_product_id(id){
        $('#product_id').val(id);
    }
    
    $('#id_submit_q').on('click', function () {
        $('#id_errors,#id_success').html('').hide();
        $('div .form-group').removeClass('has-error');
        $.post("index.php?route=product/product/addmultiplequote", $('#form_q').serialize(),function(data){
		  var obj = eval(data);
		   if(obj.status=='success') {
				$('#id_success').html(obj.error).show();
                                $('#form_q')[0].reset();
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
				html += '<option value="0" selected="selected"><?php echo "No Record"; ?></option>';
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
