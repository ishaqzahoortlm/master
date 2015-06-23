<div class="ms-options">
	<p class="error" id="error_options"></p>

	<div class="options"></div>
	
        <div style="margin: 8px;">
            <select name="options[0]" class="select_option form-control" style="width: 200px;">
			<option value="0" disabled="disabled" selected="selected"><?php echo $ms_options_add; ?></option>
			<?php foreach($options as $option) { ?>
			<option value="<?php echo $option['option_id']?>"><?php echo $option['name']; ?></option>
			<?php } ?>
		</select>
	</div>
</div>