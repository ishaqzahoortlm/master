<?php echo $header; ?>
    <?php echo $column_left; ?>
    
    <div id="content">
        <div class="page-header">
            <div class="container-fluid">
                <div class="pull-right">
                    <?php if(isset($found_user_view_all)) { ?>
      					<a href="<?php echo $view_all_ticket; ?>" class="btn btn-info" data-toggle="tooltip" title="<?php echo $button_view_all; ?>"><i class="fa fa-eye"></i></a>
      				<?php } ?>
                    <a href="<?php echo $insert; ?>" data-toggle="tooltip" title="<?php echo $button_insert; ?>" class="btn btn-primary"><i class="fa fa-plus"></i></a>
                    <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-support-admin-ticket').submit() : false;"><i class="fa fa-trash-o"></i></button>
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
                    
                    <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-support-admin-ticket">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                                        
                                        <td class="text-left">
                                            <?php if ($sort == 'sst.ticket_id') { ?>
        					                	<a href="<?php echo $sort_ticket; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_ticket; ?></a>
        					                <?php } else { ?>
        					                	<a href="<?php echo $sort_ticket; ?>"><?php echo $column_ticket; ?></a>
        					                <?php } ?>
                                        </td>
				                        
                                        <td class="text-left">
                    						<?php echo $column_username; ?>
        				                </td>
        				                <td class="text-left">
                    						<?php echo $column_useremail; ?>
        				                </td>	
                                        
                                        <td class="text-left">
                                            <?php if ($sort == 'sst.subject') { ?>
        					                	<a href="<?php echo $sort_subject; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_subject; ?></a>
        					                <?php } else { ?>
        					                	<a href="<?php echo $sort_subject; ?>"><?php echo $column_subject; ?></a>
        					                <?php } ?>
                                        </td>	
				                
                                        <td class="text-left">
                                            <?php if ($sort == 'sst.simple_support_ticket_status_id') { ?>
        					                	<a href="<?php echo $sort_ticket_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_ticket_status; ?></a>
        					                <?php } else { ?>
        					                	<a href="<?php echo $sort_ticket_status; ?>"><?php echo $column_ticket_status; ?></a>
        					                <?php } ?>
                                        </td>	
				                
                                        <td class="text-left">
                                            <?php if ($sort == 'sst.status') { ?>
        					                	<a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
        					                <?php } else { ?>
        					                	<a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
        					                <?php } ?>
                                        </td>	
                                        
                                        <td class="text-right">
                                            <?php if ($sort == 'sst.date_added') { ?>
        					                	<a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
        					                <?php } else { ?>
        					                	<a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
        					                <?php } ?>
                                        </td>	
                                        
                                        <td class="text-right">
                                            <?php if ($sort == 'sst.date_modified') { ?>
        					                	<a href="<?php echo $sort_date_modified; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_modified; ?></a>
        					                <?php } else { ?>
        					                	<a href="<?php echo $sort_date_modified; ?>"><?php echo $column_date_modified; ?></a>
        					                <?php } ?>
                                        </td>	
                                        
        				                <td class="text-right"><?php echo $column_action; ?></td>
                                    </tr>
                                </thead>
                                
                                <tbody>
                                    <?php if ($tickets) { ?>
                                        <?php foreach($tickets as $ticket) { ?>
                                            
                                            <tr>
                                                <td class="text-center">
                                                    <?php if (in_array($ticket['simple_support_ticket_id'], $selected)) { ?>
                                                        <input type="checkbox" name="selected[]" value="<?php echo $ticket['simple_support_ticket_id']; ?>" checked="checked" />
                                                    <?php } else { ?>
                                                        <input type="checkbox" name="selected[]" value="<?php echo $ticket['simple_support_ticket_id']; ?>" />
                                                    <?php } ?>
                                                </td>  
                                                                                              
                                                <td class="text-left"><?php echo $ticket['ticket_id']; ?></td>
        										<td class="text-left"><?php echo $ticket['username']; ?></td>
        										<td class="text-left"><?php echo $ticket['useremail']; ?></td>
        										<td class="text-left"><?php echo $ticket['subject']; ?></td>
        										<td class="text-left"><?php echo $ticket['ticket_status']; ?></td>
        										<td class="text-left"><?php echo $ticket['status']; ?></td>
        										<td class="text-right"><?php echo $ticket['date_added']; ?></td>
        										<td class="text-right"><?php echo $ticket['date_modified']; ?></td>
                                                <td class="text-right"><a href="<?php echo $ticket['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>                                
                                            </tr>
                                                
                                        <?php } ?>    
                                    <?php } else { ?>
                                        <tr>
                                            <td class="text-center" colspan="10"><?php echo $text_no_results; ?></td>
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
<?php echo $footer; ?>