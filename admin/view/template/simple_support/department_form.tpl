<?php echo $header; ?>
    <?php echo $column_left; ?>
    
    <div id="content">
        <div class="page-header">
            <div class="container-fluid">
                <div class="pull-right">
                    <button type="submit" form="form-support-department" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
                    <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
                </div>
                
                <div class="panel-body">
                    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-support-department" class="form-horizontal">
                        <div class="form-group required">
                            <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_name; ?></label>
                            <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                <?php foreach ($languages as $language) { ?>
                                    <div class="input-group">
                                        <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
                                        <input type="text" name="department_name[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($department_name[$language['language_id']]) ? $department_name[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_name; ?>" class="form-control" />
                                    </div>
                            
                                    <?php if (isset($error_name[$language['language_id']])) { ?>
              							<span class="text-danger"><?php echo $error_name[$language['language_id']]; ?></span><br />
              						<?php } ?>
                                <?php } ?>
                            </div>
                        </div>
                        
                        <div class="form-group required">
                            <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><span data-toggle="tooltip" title="<?php echo $help_department_head; ?>"><?php echo $entry_department_head; ?></label>
                            <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                <input type="text" name="department_head_name" value="<?php echo $department_head_name; ?>" class="form-control" placeholder="<?php echo $text_username; ?>" />
          						<input type="hidden" name="department_head_id" value="<?php echo $department_head_id; ?>" />
          						<?php if($error_department_head_name) { ?>
          							<span class="text-danger"><?php echo $error_department_head_name; ?></span>
          						<?php } ?>    
                            </div>
                        </div>
                        
                        <div class="form-group required">
                            <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><span data-toggle="tooltip" title="<?php echo $help_department_for; ?>"><?php echo $entry_department_for; ?></label>
                            <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                <div class="checkbox-inline">
                                    <input type="checkbox" name="department_for[]" value="customer" <?php if(in_array('customer', $department_for)) { echo "checked='checked'"; } ?> /> &nbsp;<?php echo $text_customer; ?>
                                </div>
                                <div class="checkbox-inline">
                                    <input type="checkbox" name="department_for[]" value="user" <?php if(in_array('user', $department_for)) { echo "checked='checked'"; } ?> /> &nbsp;<?php echo $text_admin; ?>
                                </div>
                                <?php if($error_department_for) { ?>
          							<span class="text-danger"><?php echo $error_department_for; ?></span>
          						<?php } ?> 
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label"><?php echo $entry_status; ?></label>
                            <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                <select name="status" class="form-control">
                                    <?php if($status) { ?>
              							<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
              							<option value="0"><?php echo $text_disabled; ?></option>
                                    <?php } else { ?>
                                        <option value="1"><?php echo $text_enabled; ?></option>
              							<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                    <?php } ?>
          						</select>    
                            </div>
                        </div>
                    </form>
                </div>                
            </div>
        </div>           
    </div>
    
    <script type="text/javascript"><!--
        $('input[name=\'department_head_name\']').autocomplete({
        	'source': function(request, response) {
        		$.ajax({
                    url: 'index.php?route=simple_support/department/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
        			dataType: 'json',
        			success: function(json) {
        				response($.map(json, function(item) {
        					return {
        						label: item['name'],
        						value: item['user_id']
        					}
        				}));
        			}
        		});
        	},
        	'select': function(item) {
        		$('input[name=\'department_head_name\']').val(item['label']);
                $('input[name=\'department_head_id\']').val(item['value']);
        	}
        });
    </script>
<?php echo $footer; ?>