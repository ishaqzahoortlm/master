<?php echo $header; ?>
    <?php echo $column_left; ?>
    
    <div id="content">
        <div class="page-header">
            <div class="container-fluid">
                <div class="pull-right">
                    <a href="<?php echo $insert; ?>" data-toggle="tooltip" title="<?php echo $button_insert; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
                    <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-support-faq').submit() : false;"><i class="fa fa-trash-o"></i></button>
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
            
            <?php if ($success) { ?>
                <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                </div>
            <?php } ?>
            
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $heading_title; ?></h3>
                </div>
                
                <div class="panel-body">
                    
                    <div class="well">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
                                <div class="form-group">
                                    <label class="control-label" for="input-name"><?php echo $column_faq_question; ?></label>
                                    <input type="text" name="filter_question" value="<?php echo $filter_question; ?>" class="form-control" />
                                </div>
                            </div>
                            
                            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                                <div class="form-group">
                                    <label class="control-label" for="input-group-name"><?php echo $column_faq_group_name; ?></label>
                                    <select name="filter_group_id" class="form-control">
            							<option value=""></option>
            							<?php foreach($faq_groups as $group) { ?>
            								<option value="<?php echo $group['simple_support_faq_group_id']; ?>" <?php if($filter_group_id == $group['simple_support_faq_group_id']) { echo "selected='selected'"; } ?>><?php echo $group['name']; ?></option>
            							<?php } ?>
            						</select>
                                </div>
                            </div>
                            
                            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
                                <div class="form-group">
                                    <label class="control-label" for="input-group-name"><?php echo $column_status; ?></label>
                                    <select name="filter_status" class="form-control">
                						<option value=""></option>
                						<option value="1" <?php if($filter_status == 1) { echo "selected='selected'"; } ?>><?php echo $text_enabled; ?></option>
                						<option value="0" <?php if($filter_status == 0 && $filter_status != '') { echo "selected='selected'"; } ?>><?php echo $text_disabled; ?></option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12">
                                <br />
                                <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> <?php echo $button_filter; ?></button>
                            </div>
                                                        
                        </div>                        
                    </div>
                    
                    <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-support-faq">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                                        
                                        <td class="text-left">
                                            <?php if ($sort == 'ssfd.question') { ?>
                                                <a href="<?php echo $sort_question; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_faq_question; ?></a>
                                            <?php } else { ?>
                                                <a href="<?php echo $sort_question; ?>"><?php echo $column_faq_question; ?></a>
                                            <?php } ?>
                                        </td>
				                
                                        <td class="text-left">
                                            <?php if ($sort == 'ssfgd.name') { ?>
                                                <a href="<?php echo $sort_group; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_faq_group_name; ?></a>
                                            <?php } else { ?>
                                                <a href="<?php echo $sort_group; ?>"><?php echo $column_faq_group_name; ?></a>
                                            <?php } ?>
                                        </td>	
				                
                                        <td class="text-right">
                                            <?php if ($sort == 'ssf.sort_order') { ?>
                                                <a href="<?php echo $sort_sortorder; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_sort_order; ?></a>
                                            <?php } else { ?>
                                                <a href="<?php echo $sort_sortorder; ?>"><?php echo $column_sort_order; ?></a>
                                            <?php } ?>
                                        </td>	
				                
                                        <td class="text-left">
                                            <?php if ($sort == 'ssf.status') { ?>
                                                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                                            <?php } else { ?>
                                                <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                                            <?php } ?>
                                        </td>	
                                        
        				                <td class="text-right"><?php echo $column_action; ?></td>
                                    </tr>
                                </thead>
                                
                                <tbody>
                                    <?php if ($faqs) { ?>
                                        <?php foreach($faqs as $faq) { ?>
                                            
                                            <tr>
                                                <td class="text-center">
                                                    <?php if (in_array($faq['simple_support_faq_id'], $selected)) { ?>
                                                        <input type="checkbox" name="selected[]" value="<?php echo $faq['simple_support_faq_id']; ?>" checked="checked" />
                                                    <?php } else { ?>
                                                        <input type="checkbox" name="selected[]" value="<?php echo $faq['simple_support_faq_id']; ?>" />
                                                    <?php } ?>
                                                </td>  
                                                                                              
                                                <td class="text-left"><?php echo $faq['question']; ?></td>
                                                <td class="text-left"><?php echo $faq['group_name']; ?></td>
                                                <td class="text-right"><?php echo $faq['sort_order']; ?></td>
                                                <td class="text-left"><?php echo $faq['status']; ?></td>
                                                <td class="text-right"><a href="<?php echo $faq['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>                                
                                            </tr>
                                                
                                        <?php } ?>    
                                    <?php } else { ?>
                                        <tr>
                                            <td class="text-center" colspan="6"><?php echo $text_no_results; ?></td>
                                        </tr>
                                    <?php } ?>                                
                                </tbody>                                
                            </table>
                        </div>
                    </form>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 text-left"><?php echo $pagination; ?></div>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 text-right"><?php echo $results; ?></div>
                    </div>
                </div>                
            </div>
        </div>       
    </div>    
    
    <script type="text/javascript">
        $('#button-filter').on('click', function() {
            
            url = 'index.php?route=simple_support/faq&token=<?php echo $token; ?>';
			
            var filter_question = $('input[name=\'filter_question\']').val();
			
			if (filter_question) {
				url += '&filter_question=' + encodeURIComponent(filter_question);
			}
			
			var filter_group_id = $('select[name=\'filter_group_id\']').val();
			
			if (filter_group_id) {
				url += '&filter_group_id=' + encodeURIComponent(filter_group_id);
			}
				
			var filter_status = $('select[name=\'filter_status\']').val();
			
			if (filter_status) {
				url += '&filter_status=' + encodeURIComponent(filter_status);
			}	
		
			location = url;        
        });
        
        
        $('input[name=\'filter_question\']').autocomplete({
        	'source': function(request, response) {
        		$.ajax({
                    url: 'index.php?route=simple_support/faq/autocomplete&token=<?php echo $token; ?>&filter_question=' +  encodeURIComponent(request),
        			dataType: 'json',
        			success: function(json) {
        				response($.map(json, function(item) {
        					return {
        						label: item['question'],
        						value: item['simple_support_faq_id']
        					}
        				}));
        			}
        		});
        	},
        	'select': function(item) {
        		$('input[name=\'filter_question\']').val(item['label']);
        	}
        });
        
    </script>
    
<?php echo $footer; ?>