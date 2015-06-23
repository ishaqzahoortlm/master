<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
      </div>
      <h1><?php echo $heading; ?></h1>
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
   <?php if (isset($success) && $success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $heading; ?></h3>
      </div>
      <div class="panel-body">
		<div class="table-responsive">
        <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
		<table class="list table table-bordered table-hover" style="text-align: center" id="list-message">
			<thead>
				<tr>
					<td>By</td>
                                        <td>To</td>
					<td>Product</td>
					<td>Date</td>
                                        <td><?php echo $ms_seller_groups_column_action; ?></td>
				</tr>
				
			</thead>
			<tbody></tbody>
		</table>
		</form>
		</div>
      </div>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function() {
    $('#list-message').dataTable( {
		"sAjaxSource": "index.php?route=multiseller/messages/getTableData&token=<?php echo $token; ?>",
		"aoColumns": [
			{ "mData": "by" , "sClass": "text-left"},
			{ "mData": "to" , "sClass": "text-left"},
			{ "mData": "product", "sClass": "text-left" },
                        { "mData": "date" },
			{ "mData": "actions", "bSortable": false, "sClass": "text-right" }
		],
	});
        
});
</script>
<?php echo $footer; ?> 