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
                <div class="alert alert-success" style="display: none;" id="id_success"></div>
            <div class="alert alert-danger" style="display: none;" id="id_errors"></div>
                <!--<div class="col-md-3"><?php //echo $column_right; ?></div> -->
                <div class="col-md-12">
                    <div class="main-content" >
        <div class="">
            
            <div class="col-sm-12">
                <h4><?=$ms_product_return_heading?></h4>
            </div>  
            <div class="col-sm-12">
                    
                    
                <ul id="general-tabs" class="nav nav-tabs">
                    <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $ms_account_product_tab_general; ?></a></li>
                    <li ><a href="#tab-history" data-toggle="tab"><?php echo $ms_return_tab_history; ?></a></li>
                </ul>
                <div class="tab-content ">
                <div id="tab-general" class="tab-pane active">
                    <div class="col-sm-8">
                <form class="form-horizontal" action='' method="post" name="form_q" id="form_q">
                    <input type="hidden" name="rid" id="rid" value="<?=$return_info['return_id']?>">
                    <h4 class="bb_zero"><?=$ms_text_order?></h4>
                <div class="form-group ">
                    <label class="col-sm-3 control-label"><?=$entry_order_id?></label>
                    <div class="col-sm-9">
                        <input type='text' readonly  name="order_id" id="order_id" class="form-control" value="<?=$return_info['order_id']?>">
                    </div>
                </div>
                <div class="form-group ">
                    <label class="col-sm-3 control-label"><?=$entry_date_ordered?></label>
                    <div class="col-sm-9">
                        <input type='text' readonly  name="date_ordered" id="date_ordered" class="form-control" value="<?=$return_info['date_ordered']?>">
                    </div>
                </div>
                <div class="form-group ">
                    <label class="col-sm-3 control-label"><?=$column_customer?></label>
                    <div class="col-sm-9">
                        <input type='text' readonly  name="date_ordered" id="date_ordered" class="form-control" value="<?=$return_info['firstname']?> <?=$return_info['lastname']?>">
                    </div>
                </div>    
                <h4 class="bb_zero"><?=$ms_text_pr?></h4>
                <div class="form-group ">
                    <label class="col-sm-3 control-label"><?=$entry_product?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$return_info['product']?>" readonly name="product" id="product" class="form-control">
                        
                    </div>
                </div>
                
                <div class="form-group ">
                    <label class="col-sm-3 control-label"><?=$entry_model?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$return_info['model']?>" readonly name="model" id="model" class="form-control">
                        
                    </div>
                </div>
                
                <div class="form-group ">
                    <label class="col-sm-3 control-label"><?=$entry_quantity?></label>
                    <div class="col-sm-9">
                        <input type="text" onKeyPress="return numbersonly(event)" readonly value="<?=$return_info['quantity']?>" name="quantity" id="quantity" class="form-control">
                        
                    </div>
                </div>
                
                <div class="form-group ">
                    <label class="col-sm-3 control-label"><?=$ms_text_rr?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$return_info['reason']?>" readonly name="reason" id="reason" class="form-control">
                        
                    </div>
                </div>
                
                <div class="form-group ">
                    <label class="col-sm-3 control-label"><?=$entry_opened?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=($return_info['opened']==0)?'No':'Yes'?>" readonly name="opened" id="opened" class="form-control">
                        
                    </div>
                </div>
                <?php if($return_info['comment']!="") { ?>
                <div class="form-group ">
                    <label class="col-sm-3 control-label"><?=$ms_text_rc?></label>
                    <div class="col-sm-9">
                        <textarea readonly name="comment" id="comment" class="form-control"><?=$return_info['comment']?></textarea>
                        
                    </div>
                </div>
                <?php } ?>
                
                <div class="form-group required ">
                    <label class="col-sm-3 control-label"><?=$column_action?> </label>
                    <div class="col-sm-9">
                        <select  name="action" id="action" class="form-control">
                            <option value="">Select</option>
                            <?php foreach ($all_return_actions as $ac) { ?>
                            <option <?=($return_info['action']==$ac['name'])?'selected':''?> value="<?=$ac['return_action_id']?>"><?=$ac['name']?></option>
                            <?php } ?>
                        </select>    
                        
                    </div>
                </div>
                
                <div class="form-group ">
                    <label class="col-sm-3 control-label">&nbsp;</label>
                    <div class="col-sm-9">
                        <input type="button" value="<?=$ms_button_submit?>" name="id_submit_q" id="id_submit_q" class="btn btn-primary"> &nbsp;&nbsp;
                    </div>
                </div>
                </form>
                    </div>
                </div>
                    
                    <div id="tab-history" class="tab-pane "> 
                        <div id="history"></div>
                        <div class="col-sm-8">
                            <h4 class="bb_zero"><?=$ms_heading_history?></h4>
                            <form class="form-horizontal" action='' method="post" name="form_history" id="form_history">
                            <input type="hidden" name="return_id" id="return_id" value="<?=$return_info['return_id']?>">
                            <div class="form-group ">
                                <label class="col-sm-3 control-label"><?=$ms_text_rs?></label>
                                <div class="col-sm-9">
                                    <select id="input-return-status" class="form-control" name="return_status_id">
                                    <?php foreach ($return_statuses as $return_status) { ?>
                                        <option value="<?php echo $return_status['return_status_id']; ?>"><?php echo $return_status['name']; ?></option>
                                    <?php } ?>
                                    </select>

                                </div>
                            </div>
                            
                            <div class="form-group ">
                                <label class="col-sm-3 control-label"><?=$ms_text_nc?></label>
                                <div class="col-sm-9">
                                    <label class="control-label"> <input id="input-notify" type="checkbox" value="1" name="notify"></label>

                                </div>
                            </div>
                            
                            <div class="form-group ">
                                <label class="col-sm-3 control-label"><?=$ms_text_rc?></label>
                                <div class="col-sm-9">
                                   <textarea id="input-history-comment" class="form-control" rows="8" name="history_comment"></textarea>
                                </div>
                            </div>
                            
                            <div class="form-group ">
                            <label class="col-sm-3 control-label">&nbsp;</label>
                            <div class="col-sm-9">
                                <input type="button" value="<?=$ms_button_history?>" name="id_submit_history" id="id_submit_history" class="btn btn-primary"> &nbsp;&nbsp;
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
        </div>
    </div>
</div>

  
<script type="text/javascript"><!--
    function numbersonly(e){
        var unicode=e.charCode? e.charCode : e.keyCode
        if (unicode!=8){ //if the key isn't the backspace key (which we should allow)
        if (unicode<48||unicode>57) //if not a number
        return false //disable key press
        }
    }
    load_history();
    function load_history(){
        $.post("index.php?route=seller/product-return/history", { return_id:$('#return_id').val() },function(data){
		  var obj = eval(data);
                        if(obj.status=='success') {
                            $('#history').html(obj.html);
                            }
	}, "json");
    }
    
    $('#id_submit_history').on('click', function () {
        $('#id_errors,#id_success').html('').hide();
        $('div .form-group').removeClass('has-error');
        $.post("index.php?route=seller/product-return/savehistory", $('#form_history').serialize(),function(data){
		  var obj = eval(data);
                        if(obj.status=='success') {
                            load_history();
                            $('#id_success').html(obj.error).show();
                            $('#form_history')[0].reset();
                            $("html, body").animate({ scrollTop: 0 }, "slow");
                        }
	}, "json");
        
    });
    
    $('#id_submit_q').on('click', function () {
        $('#id_errors,#id_success').html('').hide();
        $('div .form-group').removeClass('has-error');
        $.post("index.php?route=seller/product-return/save", $('#form_q').serialize(),function(data){
		  var obj = eval(data);
		   if(obj.status=='success') {
				$('#id_success').html(obj.error).show();
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
    
    
//--></script>  

  
<?php echo $footer; ?>
