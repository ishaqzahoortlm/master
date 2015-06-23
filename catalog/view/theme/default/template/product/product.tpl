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
            	<div class="col-md-12 custom_alert" id="content" >
                	<div class="col-md-9">                    
                    	<div class="cathead"><h2> <?php echo $heading_title; ?></h2></div>
                        <hr>
                        <div class="row productdetailleft">
                        	<div class="col-md-6">
                            	 <?php if ($thumb || $images) { ?>
                            	<ul class="bxslider">
                                  <?php if ($thumb) { ?>
                            <li><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></li>
                            <?php } ?>
                            <?php $cnt = 0; foreach ($images as $image) { ?>
                            <li><img src="<?php echo $image['thumb2']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></li>
                            <?php $cnt++; } ?>
                                </ul>
                                <div id="bx-pager">
                                <?php if ($images) { ?>
                                 <?php $cnt = 0; foreach ($images as $image) { ?>
                                  <a data-slide-index="<?=$cnt?>" href=""><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
                                 <?php $cnt++; } ?>
                            <?php } ?>
                                </div>
                                <?php } ?>
                            </div>
                        	<div class="col-md-6">
                            	
                            	<div class="topproinfo">
                                	
                                	<ul>
                                     <?php if ($manufacturer) { ?>
                                    	<li><b><?php echo $text_manufacturer; ?></b> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></li>
                                        <?php } ?>
                                    	<li><b>Product code</b> <?php echo $model; ?></li>
                                    	
                                        <?php
                                        $stock_class = 'label-warning';
                                        if($stock=='Out Of Stock'){
                                        $stock_class = 'label-danger';
                                        }else if($stock=='In Stock'){
                                        $stock_class = 'btn btn-sm btn-success';
                                        }
            
                                        ?>
                                        <li><b>Availability</b> 
                                            <span  class=" label <?=$stock_class?>"> <?php echo $stock; ?></span>
                                        </li>
                                        
                                    </ul>
                                	
                                </div>
                                <div class="pricedet">
                                	
                                	<b><?php echo $price; ?></b><br/>
                                    <?php if ($tax) { ?>
                                    <?php echo $text_tax; ?> <?php echo $tax; ?>
                                    <?php } ?>
                                     <?php if($price_for>0){ ?>
                                <span><?=$ms_price_for_products?> of <?=$price_for?> products</span>
                                <?php } ?>
                                </div>
                                <div class="quantitybox" id="product">
                                	<div class="input-group">
                                      <span class="input-group-btn" >
                                      <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
                                	   <input type="hidden" name="id_product_for" id="id_product_for" value="<?=$price_for?>" >
                                          <button type="button" class="btn btn-success btn-number"  data-type="minus" data-field="quantity">
                                            <span class="glyphicon glyphicon-minus"></span>
                                          </button>
                                      </span>
                                      
                                      <input type="text" name="quantity" onKeyPress="return numbersonly(event)" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control input-number"  min="1" max="100" > 
                                          <button type="button" class="btn btn-success btn-number" data-type="plus" data-field="quantity">
                                              <span class="glyphicon glyphicon-plus"></span>
                                          </button> 
                                      <span class="input-group-bt pull-right">
                                      	<input type="button" id="button-cart" class="btn btn-success" value="Buy Now">
                                      </span>
                                      
                                      
                                      
                                  </div>
                                  
                                  
                                <div style="float: left; width: 100%; margin-bottom: 15px; padding:10px 0px 5px; 10px;">
                                    <?php if ($this->customer->getId()) { ?>
                                    <a href="<?=$this->url->link('product/product/quote', 'product_id=' . $product_id)?>"><button type="button" id="btn_custom" class="btn  btn-primary btn_rfq" style="width:100%;"><?=$this->config->get('config_btn_product_quote')?></button> </a>
                                    <?php } else { ?>
                                    <a href="javascript:void(0)" onclick="javascript:alert('<?=$alert_login?>')" ><button type="button" id="btn_custom" class="btn   btn-primary btn_rfq" style="width:100%;"><?=$this->config->get('config_btn_product_quote')?></button> </a>
                                    <?php } ?>
                                    
                                </div>
                            
                                  <?php if ($minimum > 1) { ?>
                                      <div class=" rateinfo" ><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
                                      <?php } ?>
                                </div>                                
                            	
                                	<?php if ($review_status) { ?>
                                    <div class="rateinfo">
                                    <div class="rating">
                                        <p>
                                            <?php for ($i = 1; $i <= 5; $i++) { ?>
                                            <?php if ($rating < $i) { ?>
                                            <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                                            <?php } else { ?>
                                            <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                                            <?php } ?>
                                            <?php } ?>
                                            <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click');
                                                    return false;"><?php echo $reviews; ?></a> / <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click');
                                                            return false;"><?php echo $text_write; ?></a></p>
                                       
                                        
                                    </div>
                                    </div>
                                    <?php } ?>
                                                               
                            	<div class="shareinfo">
                                	<!-- AddThis Button BEGIN -->
                                        <div class="addthis_toolbox addthis_default_style"><a class="addthis_button_facebook_like" fb:like:layout="button_count"></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>
                                        <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-515eeaf54693130e"></script> 
                                        <!-- AddThis Button END --> 
                                </div>
                                
                                <?php if ($options) { ?>
                            <hr>
                            <h3><?php echo $text_option; ?></h3>
                            <?php foreach ($options as $option) { ?>
                            <?php if ($option['type'] == 'select') { ?>
                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                                    <option value=""><?php echo $text_select; ?></option>
                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                    <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                                        <?php if ($option_value['price']) { ?>
                                        (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                        <?php } ?>
                                    </option>
                                    <?php } ?>
                                </select>
                            </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'radio') { ?>
                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                <label class="control-label"><?php echo $option['name']; ?></label>
                                <div id="input-option<?php echo $option['product_option_id']; ?>">
                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                            <?php echo $option_value['name']; ?>
                                            <?php if ($option_value['price']) { ?>
                                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                            <?php } ?>
                                        </label>
                                    </div>
                                    <?php } ?>
                                </div>
                            </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'checkbox') { ?>
                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                <label class="control-label"><?php echo $option['name']; ?></label>
                                <div id="input-option<?php echo $option['product_option_id']; ?>">
                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                            <?php echo $option_value['name']; ?>
                                            <?php if ($option_value['price']) { ?>
                                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                            <?php } ?>
                                        </label>
                                    </div>
                                    <?php } ?>
                                </div>
                            </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'image') { ?>
                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                <label class="control-label"><?php echo $option['name']; ?></label>
                                <div id="input-option<?php echo $option['product_option_id']; ?>">
                                    <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                                            <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> <?php echo $option_value['name']; ?>
                                            <?php if ($option_value['price']) { ?>
                                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                            <?php } ?>
                                        </label>
                                    </div>
                                    <?php } ?>
                                </div>
                            </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'text') { ?>
                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                            </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'textarea') { ?>
                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
                            </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'file') { ?>
                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                <label class="control-label"><?php echo $option['name']; ?></label>
                                <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                                <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
                            </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'date') { ?>
                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                <div class="input-group date">
                                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                                    </span></div>
                            </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'datetime') { ?>
                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                <div class="input-group datetime">
                                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                    </span></div>
                            </div>
                            <?php } ?>
                            <?php if ($option['type'] == 'time') { ?>
                            <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                                <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                                <div class="input-group time">
                                    <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                                    <span class="input-group-btn">
                                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                                    </span></div>
                            </div>
                            <?php } ?>
                            <?php } ?>
                            <?php } ?>
                                
                                <div class="">
                            <button type="button" data-toggle="tooltip" class="btn btn-primary" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product_id; ?>');"><?php echo $button_wishlist; ?></button>
                            <button type="button" data-toggle="tooltip" class="btn btn-primary" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product_id; ?>');"><?php echo $button_compare; ?></button>
                        </div>
                            </div>
                        </div>
                        <div class="row">
                        	<div class="col-md-12">
                    <ul class="nav nav-tabs" role="tablist" id="myTab">
                    <li class="active"><a href="#tab-description" data-toggle="tab"><?php echo $tab_description; ?></a></li>
                    <?php if ($attribute_groups) { ?>
                    <li><a href="#tab-specification" data-toggle="tab"><?php echo $tab_attribute; ?></a></li>
                    <?php } ?>
                    <?php if ($review_status) { ?>
                    <li><a href="#tab-review" data-toggle="tab"><?php echo $tab_review; ?></a></li>
                    <?php } ?>
                    <li ><a href="#tab-related" data-toggle="tab"><?php echo $text_related; ?></a></li>
                    <?php if (isset($seller) && !empty($seller)) { ?>
                    <li ><a href="#tab-seller" data-toggle="tab"><?php echo $tab_seller; ?></a></li>
                    <?php } ?>
                    <?php if(!empty($seller_faqs)) { ?>
                    <li ><a href="#tab-seller_faq" data-toggle="tab"><?=$tab_supplier_faq?></a></li>
                    <?php } ?>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="tab-description"><?php echo $description; ?></div>
                    <?php if ($attribute_groups) { ?>
                    <div class="tab-pane" id="tab-specification">
                        <table class="table table-bordered">
                            <?php foreach ($attribute_groups as $attribute_group) { ?>
                            <thead>
                                <tr>
                                    <td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                                <tr>
                                    <td><?php echo $attribute['name']; ?></td>
                                    <td><?php echo $attribute['text']; ?></td>
                                </tr>
                                <?php } ?>
                            </tbody>
                            <?php } ?>
                        </table>
                    </div>
                    <?php } ?>
                    <?php if ($review_status) { ?>
                    <div class="tab-pane" id="tab-review">
                        <form class="form-horizontal">
                            <div id="review"></div>
                            <h2><?php echo $text_write; ?></h2>
                            <?php if ($review_guest) { ?>
                            <div class="form-group required">
                                <div class="col-sm-12">
                                    <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
                                    <input type="text" name="name" value="" id="input-name" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group required">
                                <div class="col-sm-12">
                                    <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
                                    <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                                    <div class="help-block"><?php echo $text_note; ?></div>
                                </div>
                            </div>
                            <div class="form-group required">
                                <div class="col-sm-12">
                                    <label class="control-label"><?php echo $entry_rating; ?></label>
                                    &nbsp;&nbsp;&nbsp; <?php echo $entry_bad; ?>&nbsp;
                                    <input type="radio" name="rating" value="1" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="2" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="3" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="4" />
                                    &nbsp;
                                    <input type="radio" name="rating" value="5" />
                                    &nbsp;<?php echo $entry_good; ?></div>
                            </div>
                            <div class="form-group required">
                                <div class="col-sm-12">
                                    <label class="control-label" for="input-captcha"><?php echo $entry_captcha; ?></label>
                                    <input type="text" name="captcha" value="" id="input-captcha" class="form-control" />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12"> <img src="index.php?route=tool/captcha" alt="" id="captcha" /> </div>
                            </div>
                            
                            <div class="form-group ">
                                <div class="col-sm-12">
                                    <input type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>"  value="<?php echo $button_continue; ?>" class="btn btn-primary " />
                                </div>
                            </div>
                            
                            
                            
                            <div class="form-group ">
              <label class="col-sm-2 control-label" for="input-confirm"></label>
              <div class="col-sm-10"></div>
          </div>
                            
                            
                            <?php } else { ?>
                            <?php echo $text_login; ?>
                            <?php } ?>
                        </form>
                    </div>
                    <?php } ?>
                    <div class="tab-pane " id="tab-related"> <?php if ($products) { ?>
                        
                        <div class="row">
                            <?php $i = 0;
                            if($products) {
                            ?>
                            <?php foreach ($products as $product) { ?>
                            <?php if ($column_left && $column_right) { ?>
                            <?php $class = 'col-lg-6 col-md-6 col-sm-12 col-xs-12'; ?>
                            <?php } elseif ($column_left || $column_right) { ?>
                            <?php $class = 'col-lg-4 col-md-4 col-sm-6 col-xs-12'; ?>
                            <?php } else { ?>
                            <?php $class = 'col-lg-3 col-md-3 col-sm-6 col-xs-12'; ?>
                            <?php } ?>
                            
                                 <div class="productboxstwo">
                                <div class="proscrolimg"><a href="<?php echo $product['href']; ?>">
                                <img src="<?php echo $product['thumb']; ?>" class="img-responsive" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>"  />
                               </a></div>
                                
                                <a  class="protitle" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                                <div class="proprice"><?php echo $product['price']; ?></div>
                                <span>
                            <?php if($product['stock_status']=='Out Of Stock') { ?>
                            Sold
                            <?php }else { ?>
                            In Stock
                            <?php } ?>
                            </span>
                            </div>
                           
                            
                            <?php if (($column_left && $column_right) && ($i % 2 == 0)) { ?>
                            <div class="clearfix visible-md visible-sm"></div>
                            <?php } elseif (($column_left || $column_right) && ($i % 3 == 0)) { ?>
                            <div class="clearfix visible-md"></div>
                            <?php } elseif ($i % 4 == 0) { ?>
                            <div class="clearfix visible-md"></div>
                            <?php } ?>
                            <?php $i++; ?>
                            <?php } ?>
                        </div>
                        <?php } }else { ?>
                        <p>No result found</p>
                        <?php }?>
                    </div>

                    <div class="tab-pane" id="tab-seller">

                    </div>
                    <?php if(!empty($seller_faqs)) { ?>
                    <div class="tab-pane" id="tab-seller_faq"> 
                        <?php foreach ($seller_faqs as $faq) { ?>
                        <div class="sellerfqs">
                            <h5><?=$faq['question']?></h5>
                            <p><?=$faq['answer']?></p>
                        </div>
                        <?php } ?>
                    </div>
                    <?php } ?>

                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="cathead"><h2>Related Products</h2></div>
                        <hr>
                        <div class="relatedproducts">
                        	<?php 
                            if($products) {
                            ?>
                            <?php foreach ($products as $product) { ?>
                            
                            <div class="productboxstwo">
                                <div class="proscrolimg"><a href="<?php echo $product['href']; ?>">
                                <img src="<?php echo $product['thumb']; ?>" class="img-responsive" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>"  />
                               </a></div>
                                
                                <a  class="protitle" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                                <div class="proprice"><?php echo $product['price']; ?></div>
                                <span>
                            <?php if($product['stock_status']=='Out Of Stock') { ?>
                            Sold
                            <?php }else { ?>
                            In Stock
                            <?php } ?>
                            </span>
                            </div>
                            <?php } ?>
                            <?php  }else { ?>
                            <p style="text-align: center;">No result found</p>
                            <?php }?>
                        </div>
                    </div>                    
                </div>
            </div>
        </div>
      </div>
<script type="text/javascript"><!--
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function () {
        $.ajax({
            url: 'index.php?route=product/product/getRecurringDescription',
            type: 'post',
            data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
            dataType: 'json',
            beforeSend: function () {
                $('#recurring-description').html('');
            },
            success: function (json) {
                $('.alert, .text-danger').remove();
                if (json['success']) {
                    $('#recurring-description').html(json['success']);
                }
            }
        });
    });
//--></script> 
<script type="text/javascript"><!--
$('#button-cart').on('click', function () {
        var flag = 0;
        var p_for = parseInt($('#id_product_for').val());
        var p_q = parseInt($('#input-quantity').val());
        
        if(p_for!=0){
            if(p_q>p_for){
               //alert('it\'s a large order please go to Quote a large order button ');
               $('#content').parent().before('<div class="alert alert-danger">it\'s a large order please go to <?=$this->config->get('config_btn_product_quote')?> button</div>');
               flag = 1;
            }
        }
    
        if(flag==0){
            $.ajax({
            url: 'index.php?route=checkout/cart/add',
            type: 'post',
            data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
            dataType: 'json',
            beforeSend: function () {
               // $('#button-cart').button('loading');
            },
            complete: function () {
                //$('#button-cart').button('reset');
            },
            success: function (json) {
                $('.alert, .text-danger').remove();
                $('.form-group').removeClass('has-error');
                if (json['error']) {
                    if (json['error']['option']) {
                        for (i in json['error']['option']) {
                            var element = $('#input-option' + i.replace('_', '-'));
                            if (element.parent().hasClass('input-group')) {
                                element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                            } else {
                                element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
                            }
                        }
                    }

                    if (json['error']['recurring']) {
                        $('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
                    }
                    
                    if(json['error']['seller']){
                        $('#content').parent().before('<div class="alert alert-danger">' + json['error']['seller'] + '</div>');
                   
                    }

                    // Highlight any found errors
                    $('.text-danger').parent().addClass('has-error');
                }

                if (json['success']) {

                    $('#content').parent().before('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                    $('.bag-count,#id_mobile_cart').html(json['total_top']);
                    $('html, body').animate({scrollTop: 0}, 'slow');
                    $('#cart > ul').load('index.php?route=common/cart/info ul li');
                }
            }
        });
        }
    });
//--></script> 
<script type="text/javascript"><!--
$('.date').datetimepicker({
        pickTime: false
    });
    $('.datetime').datetimepicker({
        pickDate: true,
        pickTime: true
    });
    $('.time').datetimepicker({
        pickDate: false
    });
    $('button[id^=\'button-upload\']').on('click', function () {
        var node = this;
        $('#form-upload').remove();
        $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');
        $('#form-upload input[name=\'file\']').trigger('click');
        timer = setInterval(function () {
            if ($('#form-upload input[name=\'file\']').val() != '') {
                clearInterval(timer);
                $.ajax({
                    url: 'index.php?route=tool/upload',
                    type: 'post',
                    dataType: 'json',
                    data: new FormData($('#form-upload')[0]),
                    cache: false,
                    contentType: false,
                    processData: false,
                    beforeSend: function () {
                        $(node).button('loading');
                    },
                    complete: function () {
                        $(node).button('reset');
                    },
                    success: function (json) {
                        $('.text-danger').remove();
                        if (json['error']) {
                            $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
                        }

                        if (json['success']) {
                            alert(json['success']);
                            $(node).parent().find('input').attr('value', json['code']);
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }
        }, 500);
    });
//--></script> 
<script type="text/javascript"><!--
$('#review').delegate('.pagination a', 'click', function (e) {
        e.preventDefault();
        $('#review').fadeOut('slow');
        $('#review').load(this.href);
        $('#review').fadeIn('slow');
    });
    $('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');
    $('#button-review').on('click', function () {
        $.ajax({
            url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
            type: 'post',
            dataType: 'json',
            data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
            beforeSend: function () {
               // $('#button-review').button('loading');
            },
            complete: function () {
               // $('#button-review').button('reset');
                $('#captcha').attr('src', 'index.php?route=tool/captcha#' + new Date().getTime());
                $('input[name=\'captcha\']').val('');
            },
            success: function (json) {
                $('.alert-success, .alert-danger').remove();
                if (json['error']) {
                    $('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
                }

                if (json['success']) {
                    $('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
                    $('input[name=\'name\']').val('');
                    $('textarea[name=\'text\']').val('');
                    $('input[name=\'rating\']:checked').prop('checked', false);
                    $('input[name=\'captcha\']').val('');
                }
            }
        });
    });
    $(document).ready(function () {
        $('.thumbnails').magnificPopup({
            type: 'image',
            delegate: 'a',
            gallery: {
                enabled: true
            }
        });
    });

    function numbersonly(e) {
        var unicode = e.charCode ? e.charCode : e.keyCode
        if (unicode != 8) { //if the key isn't the backspace key (which we should allow)
            if (unicode < 48 || unicode > 57) //if not a number
                return false //disable key press
        }
    }
//--></script> 

<script src="catalog/view/javascript/jquery-ui-1.10.4.custom.min.js"></script>
<script src="catalog/view/javascript/jquery-ui-touch-punch.min.js"></script>  
<script src="catalog/view/javascript/jquery.bxslider.js"></script>
	<script type="text/javascript">
		
			$(function() {
			  
				var valtooltip = function(sliderObj, ui){
					val1            = '<span class="slider-tip">'+ sliderObj.slider("values", 0) +'</span>';
					val2            = '<span class="slider-tip">'+ sliderObj.slider("values", 1) +'</span>';
					sliderObj.find('.ui-slider-handle:first').html(val1);
					sliderObj.find('.ui-slider-handle:last').html(val2);		                 
				};
				
				$( "#slider-range2" ).slider({
					range: true,
					animate: true,
					min: 0,
					max: 500,
					values: [180, 300],              
					create:function(event,ui){
						valtooltip($(this),ui);                    
					},
					slide: function( event, ui ) {
						valtooltip($(this),ui);
						$( "#amountx" ).val("$" + ui.values[0] + " - $" + ui.values[1]); 
					}, 
					stop:function(event,ui){
						valtooltip($(this),ui);             
					}
				}); 
				
				//tabs
				$('#myTab a:first').tab('show');
				
				//bx slider
			    $('.bxslider').bxSlider({
					 pagerCustom: '#bx-pager',
					 mode: "fade"	
				});
			
			});
			
			//plugin bootstrap minus and plus 
		$('.btn-number').click(function(e){
			e.preventDefault();
			
			fieldName = $(this).attr('data-field');
			type      = $(this).attr('data-type');
			var input = $("input[name='"+fieldName+"']");
			var currentVal = parseInt(input.val());
			if (!isNaN(currentVal)) {
				if(type == 'minus') {
					
					if(currentVal > input.attr('min')) {
						input.val(currentVal - 1).change();
					} 
					if(parseInt(input.val()) == input.attr('min')) {
						$(this).attr('disabled', true);
					}
		
				} else if(type == 'plus') {
		
					if(currentVal < input.attr('max')) {
						input.val(currentVal + 1).change();
					}
					if(parseInt(input.val()) == input.attr('max')) {
						$(this).attr('disabled', true);
					}
		
				}
			} else {
				input.val(0);
			}
		});
		$('.input-number').focusin(function(){
		   $(this).data('oldValue', $(this).val());
		});
		$('.input-number').change(function() {
			
			minValue =  parseInt($(this).attr('min'));
			maxValue =  parseInt($(this).attr('max'));
			valueCurrent = parseInt($(this).val());
			
			name = $(this).attr('name');
			if(valueCurrent >= minValue) {
				$(".btn-number[data-type='minus'][data-field='"+name+"']").removeAttr('disabled')
			} else {
				alert('Sorry, the minimum value was reached');
				$(this).val($(this).data('oldValue'));
			}
			if(valueCurrent <= maxValue) {
				$(".btn-number[data-type='plus'][data-field='"+name+"']").removeAttr('disabled')
			} else {
				alert('Sorry, the maximum value was reached');
				$(this).val($(this).data('oldValue'));
			}
			
			
		});
		$(".input-number").keydown(function (e) {
				// Allow: backspace, delete, tab, escape, enter and .
				if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190]) !== -1 ||
					 // Allow: Ctrl+A
					(e.keyCode == 65 && e.ctrlKey === true) || 
					 // Allow: home, end, left, right
					(e.keyCode >= 35 && e.keyCode <= 39)) {
						 // let it happen, don't do anything
						 return;
				}
				// Ensure that it is a number and stop the keypress
				if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
					e.preventDefault();
				}
			});
			
			$('.bx-controls-direction,.bx-prev').hide();
        </script>
<?php echo $footer; ?>
