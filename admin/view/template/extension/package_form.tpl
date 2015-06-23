<?php echo $header; ?>
<link href="<?=HTTP_CATALOG?>catalog/view/javascript/bsmselect-master/css/jquery.bsmselect.css" rel="stylesheet" media="screen" />
<link href="<?=HTTP_CATALOG?>catalog/view/javascript/bsmselect-master/css/example.css" rel="stylesheet" media="screen" />
 
<script src="<?=HTTP_CATALOG?>catalog/view/javascript/bsmselect-master/js/jquery.bsmselect.js" type="text/javascript"></script>
<script src="<?=HTTP_CATALOG?>catalog/view/javascript/bsmselect-master/js/jquery.bsmselect.sortable.js" type="text/javascript"></script>
<script src="<?=HTTP_CATALOG?>catalog/view/javascript/bsmselect-master/js/jquery.bsmselect.compatibility.js" type="text/javascript"></script>

<script src="<?=HTTP_CATALOG?>catalog/view/javascript/jquery.mask.min.js" type="text/javascript"></script>


<script type="text/javascript">//<![CDATA[
     $(document).ready(function () {
                $(".phone_us").mask('(000) 000-0000');
            });
    jQuery(function($) {
        
     $("select[multiple]").bsmSelect({
        
        highlight: 'highlight',
        addItemTarget: 'original',
        removeLabel: '<strong>X</strong>',
        containerClass: 'bsmContainer',                // Class for container that wraps this widget
        listClass: 'bsmList-custom',                   // Class for the list ($ol)
        listItemClass: 'bsmListItem-custom',           // Class for the <li> list items
        listItemLabelClass: 'bsmListItemLabel-custom', // Class for the label text that appears in list items
        removeClass: 'bsmListItemRemove-custom'
      });

    });

  //]]>
  
  
  </script>

<?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-package" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-package" class="form-horizontal">
          <ul class="nav nav-tabs" id="language">
			<?php foreach ($languages as $language) { ?>
			<li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
			<?php } ?>
		  </ul>
		  <div class="tab-content">
			<?php foreach ($languages as $language) { ?>
			<div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
			  <div class="form-group required">
				<label class="col-sm-2 control-label" for="input-title<?php echo $language['language_id']; ?>"><?php echo $text_title; ?></label>
				<div class="col-sm-10">
				  <input type="text" name="package[<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($package[$language['language_id']]) ? $package[$language['language_id']]['title'] : ''; ?>" placeholder="<?php echo $text_title; ?>" id="input-title<?php echo $language['language_id']; ?>" class="form-control" />
				</div>
			  </div>
			  
			  <div class="form-group">
				<label class="col-sm-2 control-label" for="input-description<?php echo $language['language_id']; ?>"><?php echo $text_description; ?></label>
				<div class="col-sm-10">
				  <textarea name="package[<?php echo $language['language_id']; ?>][description]" placeholder="<?php echo $text_description; ?>" id="input-description<?php echo $language['language_id']; ?>"><?php echo isset($package[$language['language_id']]) ? $package[$language['language_id']]['description'] : ''; ?></textarea>
				</div>
			  </div>
			</div>
			<?php } ?>
		  </div>
		   
		  <div class="form-group">
			<label class="col-sm-2 control-label" ><?php echo $text_price; ?></label>
			<div class="col-sm-5">
			  <input type="text" name="price" value="<?php echo $price; ?>" placeholder="<?php echo $text_price; ?>"  class="form-control" />
			</div>
		  </div>
                  <div class="form-group">
			<label class="col-sm-2 control-label" ><?php echo $text_trial; ?></label>
			<div class="col-sm-5">
                            <input type="radio" name="trial" id="trial" <?=($trial==1)?'checked':''?> value="1" > Yes
                            <input type="radio" name="trial" id="trial" <?=($trial==0)?'checked':''?> value="0" > No
                        </div>
		  </div>
                  <div class="form-group">
			<label class="col-sm-2 control-label" ><?php echo $text_duration; ?></label>
			<div class="col-sm-2">
                            <select  name="duration"    class="form-control" >
                                <?php for ($i=1;$i<=100;$i++){ ?>
                                <option  value="<?=$i?>" <?=($duration==$i)?'selected':''?> ><?=$i?></option>
                                <?php } ?>
                            </select>
			</div>
                        <div class="col-sm-3">
                            <select  name="duration_type"    class="form-control" >
                                <option value="day"  <?=($duration_type=='day')?'selected':''?> >Day</option>
                                <option value="month" <?=($duration_type=='month')?'selected':''?>  >Month</option>
                                <option value="year" <?=($duration_type=='year')?'selected':''?> >Year</option>
                                
                            </select>
			</div>
		  </div>
                  <div class="form-group">
			<label class="col-sm-2 control-label" ><?php echo $text_sort; ?></label>
			<div class="col-sm-5">
			  <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $text_sort; ?>"  class="form-control" />
			</div>
		  </div>
                  <div class="form-group">
			<label class="col-sm-2 control-label" ><?php echo $text_modules; ?></label>
			<div class="col-sm-5">
			  <?php
                          $array_modules = array();
                          if($modules!=""){
                           $array_modules = explode(',',$modules);
                          }
                          ?>
                          <select class="form-control" name="modules[]"  multiple>
                                        <?php foreach ($modules_list as $row) { ?>
                                        <option value="<?=$row['module_id']?>" <?=(in_array($row['module_id'],$array_modules))?'selected':''?>  ><?=$row['name']?></option>
                                        <?php } ?>
                           </select>
			</div>
		  </div>
		  <div class="form-group">
			<label class="col-sm-2 control-label" for="input-status"><?php echo $text_status; ?></label>
			<div class="col-sm-5">
			  <select name="status" id="input-status" class="form-control">
				<?php if ($status) { ?>
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
<script type="text/javascript">
$('#language a:first').tab('show');

<?php foreach ($languages as $language) { ?>
$('#input-description<?php echo $language['language_id']; ?>').summernote({height: 300});
<?php } ?>
</script>
<?php echo $footer; ?>