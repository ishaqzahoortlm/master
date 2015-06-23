<?php echo $header; ?>
    <?php echo $column_left; ?>
    
    <div id="content">
        <div class="page-header">
            <div class="container-fluid">
                <div class="pull-right">
                    <button type="submit" form="form-support-admin-ticket" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                    <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
                </div>
                <h1><?php echo $heading_title; ?></h1>
                <ul class="breadcrumb">
                    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                    <?php } ?>
                </ul>
            </div>
        </div> <!-- end of page-header class -->
        
        <div class="container-fluid">
            <?php if ($error_warning) { ?>
                <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                </div>
            <?php } ?>
            
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
                </div>
                
                <div class="panel-body">
                    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-support-admin-ticket" class="form-horizontal">
                    
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                            <li><a href="#tab-history" data-toggle="tab"><?php echo $tab_history; ?></a></li>
                        </ul>
                        
                        <div class="tab-content">
                            <div class="tab-pane active" id="tab-general">
                                <div class="form-group required">
                                    <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-subject"><?php echo $entry_subject; ?></label>
                                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                        <?php if(!$simple_support_ticket_id) { ?>
    	    								<input type="text" name="subject" value="<?php echo $subject; ?>" class="form-control" />
    	    								<?php if($error_subject) { ?>
    	    									<span class="text-danger"><?php echo $error_subject; ?></span>	
    	    								<?php } ?>
    	    							<?php } else { ?>
    	    								<label class="form-control"><?php echo $subject; ?></label>
    	    								<input type="hidden" name="subject" value="<?php echo $subject; ?>" class="form-control" />
    	    							<?php } ?>
                                    </div>
                                </div> 
                                
                                
                                <?php if($simple_support_ticket_id) { ?>
                                    <div class="form-group">
                                        <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-ticket-id"><?php echo $entry_ticket_id; ?></label>
                                        <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                            <label class="form-control"><?php echo $ticket_id; ?></label>
                                            <input type="hidden" name="ticket_id" value="<?php echo $ticket_id; ?>" class="form-control" />    
                                        </div>
                                    </div> 
                                <?php } ?>
                                
                                <?php if($simple_support_ticket_id) { ?>
                                    <div class="form-group">
                                        <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-date-added"><?php echo $entry_date_added; ?></label>
                                        <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                            <lable class="form-control"><?php echo $date_added; ?></label>
	    								    <input type="hidden" name="date_added" value="<?php echo $date_added; ?>" class="form-control" />
                                        </div>
                                    </div> 
                                    
                                    <div class="form-group">
                                        <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-date-modified"><?php echo $entry_date_modified; ?></label>
                                        <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                            <lable class="form-control"><?php echo $date_modified; ?></label>
	    								    <input type="hidden" name="date_modified" value="<?php echo $date_modified; ?>" class="form-control" />
                                        </div>
                                    </div> 
                                    
                                <?php } ?>
                                
                                <div class="form-group">
                                    <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-date-status"><?php echo $entry_status; ?></label>
                                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                        <select name="status" class="form-control">
	    									<option value="1" <?php if($status == 1) { echo "selected='selected'"; } ?>><?php echo $text_enabled; ?></option>
	    									<option value="0" <?php if($status == 0) { echo "selected='selected'"; } ?>><?php echo $text_disabled; ?></option>
	    								</select>
                                    </div>
                                </div> 
                                      
                            </div>
                            
                            <div class="tab-pane" id="tab-history">
                                <?php if($simple_support_ticket_id) { ?>
                                    
                                    <div style="border-bottom: 1px solid #cddddd; margin-bottom: 20px;">
                                        
                                        <div class="form-group">
                                            <h3 class="text-center"><?php echo $text_default_status_text; ?></h3>
                                        </div> 
                                        
                                        <div class="form-group">
                                            <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-description"><?php echo $entry_description; ?></label>
                                            <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                                <textarea class="form-control" disabled style="background-color: #ffffff; cursor: text; font-weight: bold;"><?php echo $main_description; ?></textarea>
                                            </div>
                                        </div>  
                                        
                                        <div class="form-group">
                                            <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-current-status"><?php echo $entry_current_status; ?></label>
                                            <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                                <label class="form-control"><b><?php echo $status_name['name']; ?></b></label>
                                            </div>
                                        </div> 
                                        
                                        <div class="form-group">
                                            <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-assign-user"><?php echo $entry_assign_user; ?></label>
                                            <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                                <label class="form-control"><b><?php echo $user['firstname'] . " " . $user['lastname']; ?></b></label>
                                            </div>
                                        </div>
                                    </div>                                        
                                <?php } ?>  
                                
                                <div id="history"></div>
                                
                                <?php if($simple_support_ticket_id) { ?>
                                    <div class="form-group">
                                        <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-assign-user"><?php echo $entry_ticket_status; ?></label>
                                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
                                            <select name="simple_support_ticket_status_id" class="form-control">
    											<?php foreach($ticket_status as $status) { ?>
    												<option value="<?php echo $status['simple_support_status_id']; ?>" <?php if($simple_support_ticket_status_id == $status['simple_support_status_id']) { echo "selected='selected'"; } ?>><?php echo $status['name']; ?></option>
    											<?php } ?>
    										</select>    
                                        </div>
                                        
                                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                            <div class="checkbox-inline">
                                                <?php echo $text_notify_customer; ?> <input type="checkbox" name="notify_customer" value="1" style="margin-left: 0;" />
                                            </div>       
                                        </div>                                        
                                    </div>       
                                <?php } ?>
                                
                                <div class="form-group required">
                                    <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-department"><?php echo $entry_department; ?></label>
                                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                        <select name="simple_support_department_id" onchange="getDepartmentUser(this.value);" class="form-control">
    										<option value=""><?php echo $text_select_department; ?></option>
    										<?php foreach($departments as $department) { ?>
    											<option value="<?php echo $department['simple_support_department_id']; ?>" <?php if($simple_support_department_id == $department['simple_support_department_id']) { echo "selected='selected'"; } ?>><?php echo $department['name']; ?></option>
    										<?php } ?>
    									</select>
    									<?php if($error_department_id) { ?>
    										<span class="text-danger"><?php echo $error_department_id; ?></span>	
    									<?php } ?>
                                    </div>
                                </div> 
                                
                                <div class="form-group required" id="assign-user-ticket" style="display:none">
                                    <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-user-ticket"><?php echo $entry_assign_ticket; ?></label>
                                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                        <select name="user_id" id="user_id" class="form-control"></select>
    									<?php if($error_user_id) { ?>
    										<span class="text-danger"><?php echo $error_user_id; ?></span>	
    									<?php } ?>
                                    </div>
                                </div> 
                                
                                <div class="form-group required">
                                    <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-department"><?php echo $entry_description; ?></label>
                                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                        <textarea name="description" cols="100" rows="10" class="form-control"><?php echo $description; ?></textarea>
    									<?php if($error_description) { ?>
    										<span class="text-danger"><?php echo $error_description; ?></span>	
    									<?php } ?>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-file"><?php echo $entry_file; ?></label>
                                    <div class="col-lg-1 col-md-1 col-sm-1 col-xs-12">
                                        <button type="button" id="button-upload" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i></button>    
                                    </div>
                                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
                                        <label id="upload-file-name" class="form-control"></label> 
                                        <input type="hidden" id="upload-file" name="filename" value="" />
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <script type="text/javascript">
	    $(document).ready(function() {
			getDepartmentUser(<?php echo $simple_support_department_id; ?>);
		});
	</script>
    
    <script type="text/javascript">
    	function getDepartmentUser(department_id) {
    	
    		if(department_id) {
    			
    			$.ajax({
					url: 'index.php?route=simple_support/admin_ticket/departmentUser&token=<?php echo $token; ?>&department_id=' + department_id,
					dataType: 'json',
					beforeSend: function() {
						$('select[name=\'simple_support_department_id\']').after('<span class="wait">&nbsp;<img src="view/image/loading.gif" alt="" /></span>');
					},
					complete: function() {
						$('.wait').remove();
					},			
					success: function(json) {
						
						html = '';
									
						html = '<option value=""><?php echo $text_select_user; ?></option>';
						
						var user_id = '';
						
						<?php if(isset($user_id) && $user_id) { ?>
							user_id = <?php echo $user_id; ?>;
						<?php } ?>
						
						$("#assign-user-ticket").css({display: "inherit"});
						
						if (json['users'] != '') {
						
							for (i = 0; i < json['users'].length; i++) {
								if(user_id == json['users'][i]['user_id']) {
									html += '<option value="' + json['users'][i]['user_id'] + '" selected>' + json['users'][i]['firstname'] + ' ' + json['users'][i]['lastname'] + ' (' + json['users'][i]['email'] + ')' + '</option>';
								} else {
									html += '<option value="' + json['users'][i]['user_id'] + '">' + json['users'][i]['firstname'] + ' ' + json['users'][i]['lastname'] + ' (' + json['users'][i]['email'] + ')' + '</option>';
								}			        			
							}
						} else {
							html += '<option value="0">none</option>';
						}
						
						$('select[name=\'user_id\']').html(html);
						
					},
					
				});
    		}
    	}
    </script>
    
    <?php if ($simple_support_ticket_id) { ?>
		<script type="text/javascript">
		$('#history').delegate('.pagination a', 'click', function(e) {
        	e.preventDefault();
        	
        	$('#history').load(this.href);
        });			
			
			$('#history').load('index.php?route=simple_support/admin_ticket/history&token=<?php echo $token; ?>&simple_support_ticket_id=<?php echo $simple_support_ticket_id; ?>');
		</script>
	<?php } ?>
    
    <script type="text/javascript">
        $('button[id=\'button-upload\']').on('click', function() {
        	var node = this;
        	
        	$('#form-upload').remove();
        	
        	$('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');
        	
        	$('#form-upload input[name=\'file\']').trigger('click');
        	
        	$('#form-upload input[name=\'file\']').on('change', function() {
        		$.ajax({
        			url: 'index.php?route=simple_support/admin_ticket/upload&token=<?php echo $token; ?>',
        			type: 'post',
        			dataType: 'json',
        			data: new FormData($(this).parent()[0]),
        			cache: false,
        			contentType: false,
        			processData: false,
        			beforeSend: function() {
        				$(node).button('loading');
        			},
        			complete: function() {
        				$(node).button('reset');
        			},
        			success: function(json) {
        				$('.text-danger').remove();
        				
        				if (json['error']) {
        					$('#upload-file-name').after('<div class="text-danger">' + json['error'] + '</div>');
        				}
        				
        				if (json['success']) {
        					alert(json['success']);
        					
                            $("#upload-file-name").text(json['filename']);
                            
                            $("#upload-file").val(json['file']);
                            
        					$(node).parent().find('input').attr('value', json['code']);
                            
        				}
        			},
        			error: function(xhr, ajaxOptions, thrownError) {
        				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        			}
        		});
        	});
        });
    </script> 
    
    
<?php echo $footer; ?>