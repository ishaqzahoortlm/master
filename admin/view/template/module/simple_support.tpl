<?php echo $header; ?>
    <?php echo $column_left; ?>
    
    <div id="content">
        <div class="page-header">
            <div class="container-fluid">
                
                <div class="pull-right">
                    <button type="submit" form="form-simple-support" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                    <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
                </div>
                <h1><?php echo $heading_title; ?></h1>
                <ul class="breadcrumb">
                    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                    <?php } ?>
                </ul>  
            </div>
        </div>
        
        <div class="container-fluid">
            <?php if ($error_warning) { ?>
                <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                </div>
            <?php } ?>
            
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
                </div>
                <div class="panel-body">
                    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-simple-support" class="form-horizontal">                    
                        <div class="form-group">
                            <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-status"><?php echo $entry_status; ?></label>
                            <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                                <select name="simple_support_status" id="input-status" class="form-control">
        							<option value="1" <?php if($simple_support_status == 1) { echo "selected='selected'"; } ?>><?php echo $text_enabled; ?></option>
        							<option value="0" <?php if($simple_support_status == 0) { echo "selected='selected'"; } ?>><?php echo $text_disabled; ?></option>
        						</select>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-prefix"><span data-toggle="tooltip" title="<?php echo $help_ticket_prefix; ?>"><?php echo $entry_ticket_prefix; ?></label>
                            <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                               <input type="text" name="simple_support_ticket_prefix" value="<?php echo $simple_support_ticket_prefix; ?>" maxlength="5" class="form-control" />
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-support-status"><span data-toggle="tooltip" title="<?php echo $help_default_simple_support_status; ?>"><?php echo $entry_simple_support_status; ?></label>
                            <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                                <select name="simple_support_status_id" class="form-control" id="input-support-status">
			                  		<?php foreach ($support_statues as $support_status) { ?>
			                  			<?php if ($support_status['simple_support_status_id'] == $simple_support_status_id) { ?>
			                  				<option value="<?php echo $support_status['simple_support_status_id']; ?>" selected="selected"><?php echo $support_status['name']; ?></option>
			                  			<?php } else { ?>
			                  				<option value="<?php echo $support_status['simple_support_status_id']; ?>"><?php echo $support_status['name']; ?></option>
			                  			<?php } ?>
			                  		<?php } ?>
			                	</select>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-search-faq"><span data-toggle="tooltip" title="<?php echo $help_search_faq; ?>"><?php echo $entry_search_faq; ?></label>
                            <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                                <div class="checkbox-inline">
                                    <?php if($simple_support_search_faq) { ?>
    	    							<input type="radio" name="simple_support_search_faq" id="input-search-faq" value="1" checked="checked" /> <?php echo $text_enabled; ?>&nbsp;
    	    							<input type="radio" name="simple_support_search_faq" id="input-search-faq" value="0" /> <?php echo $text_disabled; ?>
    	    						<?php } else { ?>
    	    							<input type="radio" name="simple_support_search_faq" id="input-search-faq" value="1" /> <?php echo $text_enabled; ?>&nbsp;
    	    							<input type="radio" name="simple_support_search_faq" id="input-search-faq" value="0" checked="checked" /> <?php echo $text_disabled; ?>
    	    						<?php } ?>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-search-faq"><span data-toggle="tooltip" title="<?php echo $help_show_ticket_all; ?>"><?php echo $entry_show_ticket_all; ?></label>
                            <div class="col-lg-10 col-md-10 col-sm-10 col-xs-10">
                                <div class="well well-sm" style="height: 150px; overflow: auto;">
                                	<?php foreach($user_groups as $group) { ?>
                                		<div class="checkbox">
                                			<label>
                                				<?php if (in_array($group['user_group_id'], $simple_support_ticket_permission)) { ?>
                                					<input type="checkbox" name="simple_support_ticket_permission[]" value="<?php echo $group['user_group_id']; ?>" checked="checked" /> <?php echo $group['name']; ?>
                                				<?php } else { ?>
                                					<input type="checkbox" name="simple_support_ticket_permission[]" value="<?php echo $group['user_group_id']; ?>" /> <?php echo $group['name']; ?>
                                				<?php } ?>
                                			</label>                                                                                        
                                		</div>    
                                	<?php } ?>
                                </div>
                                <a onclick="$(this).parent().find(':checkbox').prop('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);"><?php echo $text_unselect_all; ?></a>
                            </div>
                        </div>
                        
                    </form>                    
                </div>    
                    
            </div>
            
        </div>
        
    </div>
    
<?php echo $footer; ?>