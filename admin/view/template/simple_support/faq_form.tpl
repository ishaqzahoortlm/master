<?php echo $header; ?>
    <?php echo $column_left; ?>
    <div id="content">
        <div class="page-header">
            <div class="container-fluid">
                <div class="pull-right">
                    <button type="submit" form="form-support-faq" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
                    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-support-faq" class="form-horizontal">
                    
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                            <li><a href="#tab-data" data-toggle="tab"><?php echo $tab_data; ?></a></li>
                        </ul>
                        
                        <div class="tab-content">
                            <div class="tab-pane active" id="tab-general">
                                <ul class="nav nav-tabs" id="language">
                                    <?php foreach ($languages as $language) { ?>
                                        <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                                    <?php } ?>
                                </ul>
                                
                                <div class="tab-content">
                                    <?php foreach ($languages as $language) { ?>
                                        <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                                            
                                            <div class="form-group required">
                                                <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-name<?php echo $language['language_id']; ?>"><?php echo $entry_question; ?></label>
                                                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                                    <input type="text" name="faq_description[<?php echo $language['language_id']; ?>][question]" value="<?php echo isset($faq_description[$language['language_id']]) ? $faq_description[$language['language_id']]['question'] : ''; ?>" class="form-control" />
                          							<?php if (isset($error_question[$language['language_id']])) { ?>
                          								<span class="text-danger"><?php echo $error_question[$language['language_id']]; ?></span>
                          							<?php } ?>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group" style="display: none;">
                                                <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-meta-description<?php echo $language['language_id']; ?>"><?php echo $entry_meta_description; ?></label>
                                                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                                    <textarea name="faq_description[<?php echo $language['language_id']; ?>][meta_description]" cols="40" rows="5" class="form-control"><?php echo isset($faq_description[$language['language_id']]) ? $faq_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group" style="display: none;">
                                                <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-meta-keyword<?php echo $language['language_id']; ?>"><?php echo $entry_meta_keyword; ?></label>
                                                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                                    <textarea name="faq_description[<?php echo $language['language_id']; ?>][meta_keyword]" cols="40" rows="5" class="form-control"><?php echo isset($faq_description[$language['language_id']]) ? $faq_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group required">
                                                <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-meta-description<?php echo $language['language_id']; ?>"><?php echo $entry_answer; ?></label>
                                                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                                    <textarea name="faq_description[<?php echo $language['language_id']; ?>][answer]" id="answer<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($faq_description[$language['language_id']]) ? $faq_description[$language['language_id']]['answer'] : ''; ?></textarea>
                        							<?php if (isset($error_answer[$language['language_id']])) { ?>
                          								<span class="text-danger"><?php echo $error_answer[$language['language_id']]; ?></span>
                          							<?php } ?>
                                                </div>
                                            </div>
                                                
                                        </div> <!-- end of language id -->
                                    <?php } ?>
                                </div> <!-- end of tab-content class -->                                    
                            </div> <!-- end of tab-general id -->
                            
                            <div class="tab-pane" id="tab-data">
                                
                                <div class="form-group">
                                    <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-faq-group"><?php echo $entry_faq_group; ?></label>
                                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                        <select name="simple_support_faq_group_id" class="form-control">
            								<?php foreach($faq_groups as $group) { ?>
            									<option value="<?php echo $group['simple_support_faq_group_id']; ?>" <?php if($simple_support_faq_group_id == $group['simple_support_faq_group_id']) { echo "selected='selected'"; } ?>><?php echo $group['name']; ?></option>        									
            								<?php } ?>
            							</select>    
                                    </div>
                                </div>
                                
                                <div class="form-group required" style="display: none;">
                                    <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-store"><?php echo $entry_store; ?></label>
                                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                        <div class="well well-sm" style="height: 150px; overflow: auto; margin-bottom:0;">
                                            <div class="checkbox">
                                                <label>
                                                    <?php if (in_array(0, $faq_to_store)) { ?>
                            							<input type="checkbox" name="faq_to_store[]" value="0" checked="checked" />
                            							<?php echo $text_default; ?>
                            						<?php } else { ?>
        							                    <input type="checkbox" name="faq_to_store[]" value="0" />
        							                    <?php echo $text_default; ?>
                            						<?php } ?>
                                                </label>
                                            </div>
                                            
                                            <?php foreach ($stores as $store) { ?>
                                                <div class="checkbox">
                                                    <label>
                                                        <?php if (in_array($store['store_id'], $faq_to_store)) { ?>
        								                    <input type="checkbox" name="faq_to_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
        								                    <?php echo $store['name']; ?>
        							                    <?php } else { ?>
        								                    <input type="checkbox" name="faq_to_store[]" value="<?php echo $store['store_id']; ?>" />
        								                    <?php echo $store['name']; ?>
        							                    <?php } ?>
                                                    </label>
                                                </div>   
                                            <?php } ?>                                            
                                        </div>                                        
                                        <?php if ($error_store) { ?>
              								<span class="text-danger"><?php echo $error_store; ?></span>
              							<?php } ?>                                        
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-sort-order"><?php echo $entry_sort_order; ?></label>
                                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                        <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" class="form-control" />
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label" for="input-status"><?php echo $entry_status; ?></label>
                                    <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                                        <select name="status" class="form-control">
                  							<option value="1" <?php if($status == 1) { echo "selected='selected'"; } ?>><?php echo $text_enabled; ?></option>
                  							<option value="0" <?php if($status == 0) { echo "selected='selected'"; } ?>><?php echo $text_disabled; ?></option>
                  						</select>
                                    </div>
                                </div>                                    
                            </div> <!-- end of tab-data id -->                            
                        </div> <!-- end of tab-content id -->
                    </form>
                </div>               
                
            </div> <!-- end of panel-default class -->
            
        </div> <!-- end of container-fluid class -->      
    </div> <!-- end of content id -->
    
    
    <script type="text/javascript">
    
        <?php foreach ($languages as $language) { ?>
            $('#answer<?php echo $language['language_id']; ?>').summernote({height: 300});
            <?php if(!$simple_support_faq_id) { ?>
                $('#answer<?php echo $language['language_id']; ?>').code('');    
            <?php } ?>
        <?php } ?>
        $('#language a:first').tab('show');
        $('#option a:first').tab('show');
    </script>
    
<?php echo $footer; ?>