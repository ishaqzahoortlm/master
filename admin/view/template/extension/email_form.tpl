<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-certification" data-toggle="tooltip" title="Save" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="Cancel" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-certification" class="form-horizontal">

                    <div class="form-group required">
                        <label class="col-sm-2 control-label" for=""><?php echo $text_type; ?></label>
                        <div class="col-sm-8">
                            <input type="text" name="email_type" <?=$type_action?> value="<?php echo isset($email_type) ? $email_type : ''; ?>" placeholder="<?php echo $text_type; ?>" id="" class="form-control" />
                        </div>
                    </div>
                    
                    <div class="form-group required">
                        <label class="col-sm-2 control-label" for=""><?php echo $text_subject; ?></label>
                        <div class="col-sm-8">
                            <input type="text" name="subject" value="<?php echo isset($subject) ? $subject : ''; ?>" placeholder="<?php echo $text_subject; ?>" id="" class="form-control" />
                        </div>
                    </div>
                    
                    <div class="form-group">
				<label class="col-sm-2 control-label" for="input-contents"><?php echo $text_description; ?></label>
				<div class="col-sm-8">
				  <textarea name="contents" placeholder="<?php echo $text_description; ?>" id="input-contents"><?php echo isset($contents) ? $contents : ''; ?></textarea>
				</div>
			  </div>

                    <div class="form-group" style="display: none">
                        <label class="col-sm-2 control-label" for="input-status"><?php echo $text_status; ?></label>
                        <div class="col-sm-8">
                            <select name="status" id="input-status" class="form-control">
                                <option value="1" selected="selected">Enabled</option>
                                <option value="0">Disabled</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

$('#input-contents').summernote({height: 300});

</script>
<?php echo $footer; ?>