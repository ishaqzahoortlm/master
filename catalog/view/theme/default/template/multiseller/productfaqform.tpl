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
                <h4><?=$ms_product_faq?></h4>
            </div>  
            <div class="col-sm-8">
                <form class="form-horizontal" action='' method="post" name="form_q" id="form_q">
                    <input type="hidden" name="seller_id" id="seller_id" value="<?=$seller_id?>">
                    <input type="hidden" name="id" id="seller_id" value="<?=$id?>">
                    
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$ms_faq_q?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$question?>" name="question" id="question" class="form-control">
                    </div>
                </div>
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$ms_faq_a?></label>
                    <div class="col-sm-9">
                        <textarea  name="answer" id="answer" class="form-control"><?=$answer?></textarea>
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-3 control-label"><?=$ms_faq_sort_order?></label>
                    <div class="col-sm-9">
                        <input type="text" value="<?=$sort_order?>" name="sort_order" id="sort_order" class="form-control">
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
    </div>
                </div>
            </div>
        </div>
    </div>
</div>

  
<script type="text/javascript"><!--
    
    $('#id_submit_q').on('click', function () {
        $('#id_errors,#id_success').html('').hide();
        $('div .form-group').removeClass('has-error');
        $.post("index.php?route=seller/product-faq/save", $('#form_q').serialize(),function(data){
		  var obj = eval(data);
		   if(obj.status=='success') {
				//$('#id_success').html(obj.error).show();
                                //$('#form_q')[0].reset();
                                //$("html, body").animate({ scrollTop: 0 }, "slow");
                                window.location = '<?=$this->url->link('seller/product-faq')?>';
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
