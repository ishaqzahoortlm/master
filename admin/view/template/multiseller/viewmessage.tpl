<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
         <a href="<?php echo $this->url->link('multiseller/messages', 'token=' . $this->session->data['token']); ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <div style="display: none" class="alert alert-danger"><i class="fa fa-exclamation-circle"></i>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>

    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading; ?></h3>
      </div>
      <div class="panel-body">
        <div class="row">
        <div class="">
             <?php if(!empty($all_message)) { ?>
                <ul class="col-md-12">
                    <?php foreach ($all_message as $msg) { ?>
                    <li class="list-group-item">
                        <div class="row">
                            
                            <div class="col-xs-10 col-md-11">
                                <div>
                                    <div class="mic-info">
                                        By: <a href="javascript:void(0)"><?=($msg['receiver_type']=='seller')?$customer_info['firstname'].' '.$customer_info['lastname']:$seller_info['company']?></a> on <?php echo date('M d, Y h:i A',strtotime($msg['created_at'])); ?>                                    </div>
                                </div>
                                <div class="comment-text">
                                    <?=$msg['body']?>
                                </div>
                                
                            </div>
                        </div>
                    </li>
                    <br/>
                    <?php } ?>
                    
                </ul>
             <?php } ?>
            
            
        </div>
    </div>
      </div>
	</div>
  </div>
</div>


<?php echo $footer; ?> 