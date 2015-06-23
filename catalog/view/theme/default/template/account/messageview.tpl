<?php echo $header; ?>
<div class="main-content-wrapper" >
    <div class="page-header">
        <div class="breadcrumbs"> 
            <a href="<?=$this->url->link('common/home')?>">Home</a>
            <?php for($bi=1;$bi<count($breadcrumbs);$bi++){ ?>
            <span class="divider">/</span> 
            <?php
            if($bi<(count($breadcrumbs)-1)){
            ?>
            <span><a href="<?=$breadcrumbs[$bi]['href']?>"><?=$breadcrumbs[$bi]['text']?></a></span> 
            <?php }else { ?>
            <span><?=$breadcrumbs[$bi]['text']?></span> 
            <?php } ?>
            <?php } ?>
            

        </div>
        <h1 class="page-title"><?php echo $heading_title; ?></h1>
    </div>
    <div class="main-content" >
        <div class="row">
            <div class="alert alert-success" style="display: none;" id="id_success"></div>
            <div class="alert alert-danger" style="display: none;" id="id_errors"></div>
            <div class="col-md-12">
                <form class="form-horizontal" action='' method="post" name="form_q" id="form_q">
                    <input type="hidden" name="thread_id" id="thread_id" value="<?=$message_id?>">
                    <input type="hidden" name="receiver_id" id="receiver_id" value="<?=$seller_info['seller_id']?>">
                    <input type="hidden" name="receiver_type" id="receiver_type" value="seller">
                <h4><?=$heading_title?>
                    <div class='pull-right'><a href="<?=$this->url->link('account/message', '', 'SSL')?>"><button type="button"><?=$ms_all_message?></button></a></div>
                </h4>
                
                
    <div class="row">
        <div class="">
             <?php if(!empty($all_message)) { ?>
                <ul class="col-md-12">
                    <?php foreach ($all_message as $msg) { ?>
                    <li class="list-group-item">
                        <div class="row">
                            
                            <div class="col-xs-10 col-md-11">
                                
                                <div class="comment-text">
                                    <?=$msg['body']?>
                                </div>
                                <div  style="font-size: 14px;">
                                    <b>By</b>: <a href="javascript:void(0)"><?=($msg['receiver_type']=='seller')?$customer_info['firstname'].' '.$customer_info['lastname']:$seller_info['company']?></a> on <?php echo date('M d, Y h:i A',strtotime($msg['created_at'])); ?>
                                </div>
                                
                            </div>
                        </div>
                    </li>
                    <br/>
                    <?php } ?>
                    
                </ul>
             <?php } ?>
            
            <div class="col-md-12 " id="reply-box">
                <div class="alert" id="id_send_message"  style="display: none;"></div>
                <div class="form-group required col-md-10">
                <label><b><?=$ms_title_reply?></b></label>
                <textarea name="message_reply" style="resize:none; width:65%" rows="6" id="message_reply" class="form-control"  ></textarea>
                <button style="margin-top: 10px" type="button" name="id_post_reply" id="id_post_reply" ><?=$ms_btn_reply?></button>
                </div>
            </div>
                
        </div>
    </div>


                
                </form>
            </div>
        </div>
    </div>
    <?php echo $column_right; ?>
    
</div>
  
<script type="text/javascript"><!--
    
    $('#id_post_reply').on('click', function () {
        $('#id_send_message').removeClass('alert-danger,alert-success').hide();
        $('div .form-group').removeClass('has-error');
        $.post("index.php?route=account/message/replyback", $('#form_q').serialize(),function(data){
		  var obj = eval(data);
		   if(obj.status=='success') {
                                $('#message_reply').val('');
				$('#id_send_message').removeClass('alert-danger').addClass('alert-success').html(obj.error).show();
			}else{
                                var arry_errors = obj.required;
                                for (error in obj.required) {
                                    $('#' + error + '').parents('.form-group').addClass('has-error');
                                }
				$('#id_send_message').removeClass('alert-success').addClass('alert-danger').html(obj.error).show();
                                
			}
	}, "json");
        
    });
    
    
//--></script>  

  
<?php echo $footer; ?>
