<div class="form-group">
    <?php if($histories) { ?>
        <?php foreach($histories as $history) { ?>
            <div class="form-group">
                <label class="col-lg-2 col-md-2 col-sm-2 col-xs-12 control-label">
                    <b><?php echo $history['name']; ?></b>
    				<br />
    				<?php echo $history['date_added']; ?>
                </label>   
                <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                    <?php echo $history['description']; ?><br />
                    <?php foreach($history['ticket_images'] as $image) { ?>
                        <?php if($image['value']) { ?>
    					   - <a href="<?php echo $image['href']; ?>"><?php echo $image['value']; ?></a><br />
                        <?php } ?>
    				<?php } ?>                           
                </div>  
            </div>
        <?php } ?>
    	<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 text-left"><?php echo $pagination; ?></div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 text-right"><?php echo $results; ?></div>
    <?php } ?>
</div>