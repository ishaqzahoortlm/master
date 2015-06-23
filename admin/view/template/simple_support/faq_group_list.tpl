<?php echo $header; ?>
    <?php echo $column_left; ?>
    
    <div id="content">
        <div class="page-header">
            <div class="container-fluid">
                <div class="pull-right">
                    <a href="<?php echo $insert; ?>" data-toggle="tooltip" title="<?php echo $button_insert; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
                    <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-support-faq-group').submit() : false;"><i class="fa fa-trash-o"></i></button>
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
                            <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                                <div class="form-group">
                                    <label class="control-label" for="input-name"><?php echo $column_name; ?></label>
                                    <input type="text" name="filter_group_name" value="<?php echo $filter_group_name; ?>" placeholder="<?php echo $column_name; ?>" id="input-name" class="form-control" />
                                </div>
                            </div>
                            
                             <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12">
                                <div class="form-group">
                                    <label class="control-label" for="input-name"><?php echo $column_status; ?></label>
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
                
                    <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-support-faq-group">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                                        
                                        <td class="text-left">
                                            <?php if ($sort == 'ssfgd.name') { ?>
        					                	<a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
        					                <?php } else { ?>
        					                	<a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
        					                <?php } ?>
                                        </td>
				                
                                        <td class="text-right">
                                            <?php if ($sort == 'ssfg.sort_order') { ?>
        					                	<a href="<?php echo $sort_sortorder; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_sort_order; ?></a>
        					                <?php } else { ?>
        					                	<a href="<?php echo $sort_sortorder; ?>"><?php echo $column_sort_order; ?></a>
        					                <?php } ?>
                                        </td>	
				                
                                        <td class="text-left">
                                            <?php if ($sort == 'ssfgd.status') { ?>
        					                	<a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
        					                <?php } else { ?>
        					                	<a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
        					                <?php } ?>
                                        </td>	
				                        
        				                <td class="text-right"><?php echo $column_action; ?></td>
                                    </tr>
                                </thead>
                                
                                <tbody>
                                    
                                
                                    <?php if ($faq_groups) { ?>
                                        <?php foreach($faq_groups as $group) { ?>
                                            
                                            <tr>
                                                <td class="text-center">
                                                    <?php if (in_array($group['simple_support_faq_group_id'], $selected)) { ?>
                                                        <input type="checkbox" name="selected[]" value="<?php echo $group['simple_support_faq_group_id']; ?>" checked="checked" />
                                                    <?php } else { ?>
                                                        <input type="checkbox" name="selected[]" value="<?php echo $group['simple_support_faq_group_id']; ?>" />
                                                    <?php } ?>
                                                </td>  
                                                                                              
                                                <td class="text-left"><?php echo $group['name']; ?></td>
                                                <td class="text-right"><?php echo $group['sort_order']; ?></td>
                                                <td class="text-left"><?php echo $group['status']; ?></td>
                                                <td class="text-right"><a href="<?php echo $group['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>                                
                                            </tr>
                                                
                                        <?php } ?>    
                                    <?php } else { ?>
                                        <tr>
                                            <td class="text-center" colspan="5"><?php echo $text_no_results; ?></td>
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
            
            url = 'index.php?route=simple_support/faq_group&token=<?php echo $token; ?>';
			
			var filter_group_name = $('input[name=\'filter_group_name\']').val();
			
			if (filter_group_name) {
				url += '&filter_group_name=' + encodeURIComponent(filter_group_name);
			}
				
			var filter_status = $('select[name=\'filter_status\']').val();
			
			if (filter_status) {
				url += '&filter_status=' + encodeURIComponent(filter_status);
			}	
            
			location = url;            
        });
        
        
        $('input[name=\'filter_group_name\']').autocomplete({
        	'source': function(request, response) {
        		$.ajax({
                    url: 'index.php?route=simple_support/faq_group/autocomplete&token=<?php echo $token; ?>&filter_group_name=' +  encodeURIComponent(request),
        			dataType: 'json',
        			success: function(json) {
        				response($.map(json, function(item) {
        					return {
        						label: item['name'],
        						value: item['simple_support_faq_group_id']
        					}
        				}));
        			}
        		});
        	},
        	'select': function(item) {
        		$('input[name=\'filter_group_name\']').val(item['label']);
        	}
        });
        
    </script>
    
<?php echo $footer; ?>