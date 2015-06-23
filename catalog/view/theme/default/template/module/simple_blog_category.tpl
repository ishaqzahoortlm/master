<div class="sidebar">
    <div class="sidebar-link-list">
        <?php if($categories) { ?>
        <h4 class="sidebar-link-list-title meta"><?php echo $heading_title; ?></h4>
        <ul>
            <?php foreach ($categories as $category){ ?>  
            <li class=" "> <a href="<?=$category['href']?>"><?=$category['name']?></a> </li>
            <?php } ?>
        </ul>
        <?php } ?>
    </div>
</div>    
<?php if($categories) { ?>
<div class="panel panel-default" style="display: none;">
      	<div class="panel-heading"><h3 class="panel-title"><?php echo $heading_title; ?></h3></div>
      	<div class="panel-body">
        	
            <div class="list-group">
            	<?php foreach ($categories as $category) { ?>
            		<?php if ($category['simple_blog_category_id'] == $category_id) { ?>
            			<a href="<?php echo $category['href']; ?>" class="list-group-item active"><?php echo $category['name']; ?></a>
            			<?php if ($category['children']) { ?>
            				<?php foreach ($category['children'] as $child) { ?>
            					<?php if ($child['category_id'] == $child_id) { ?>
            						<a href="<?php echo $child['href']; ?>" class="list-group-item active">&nbsp;&nbsp;&nbsp;- <?php echo $child['name']; ?></a>
            					<?php } else { ?>
            						<a href="<?php echo $child['href']; ?>" class="list-group-item">&nbsp;&nbsp;&nbsp;- <?php echo $child['name']; ?></a>
            					<?php } ?>
            				<?php } ?>
            			<?php } ?>
            		<?php } else { ?>
            			<a href="<?php echo $category['href']; ?>" class="list-group-item"><?php echo $category['name']; ?></a>
            		<?php } ?>
            	<?php } ?>
            </div>

      	</div>
    </div>
<?php } ?>



<script type="text/javascript">
	$('#blog-search input[name=\'article_search\']').keydown(function(e) {
		if (e.keyCode == 13) {
			$('#button-search').trigger('click');
		}
	});

	$('#button-search').bind('click', function() {
		url = 'index.php?route=simple_blog/search';
		
		var article_search = $('#blog-search input[name=\'article_search\']').val();
		
		if (article_search) {
			url += '&blog_search=' + encodeURIComponent(article_search);
		}
		
		location = url;
	});
</script> 
