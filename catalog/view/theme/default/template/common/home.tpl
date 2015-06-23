<?php echo $header; ?>
   <div class="container" id="homebody">
      	<div class="row">
        	<div class="col-md-12">
                <div class="col-md-8">
                	<div class="homeleft">
                    	<div class="homeimage"><img src="catalog/view/theme/default/image/logo-large.jpg" width="595px" height="112px" class="img-responsive"></div>
                        <hr>
                        <div class="homecat row">
                            <!--<div class="col-md-4">
                                <?php //echo $column_left; ?>
                            </div>-->
                            <div class="col-md-12 homecattext">
                            	<?php echo $description; ?>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                	<div class="homeright">
                    	<div class="boxitem">
                        	<div class="row">
                                <div class="col-md-4">
                                    <a href="<?=$server.'?route=product/search&search='; ?>"><b><i class="fa fa-search"></i> <?=$search_title?></b></a>
                                </div>
                                <div class="col-md-8">
                                    <p><?=$search_description?></p>
                                </div>
                            </div>
                        </div>
                    	<div class="boxitem">
                        	<div class="row">
                                <div class="col-md-4">
                                    <a href="<?=$server . 'cart';?>"><b><i class="fa fa-shopping-cart"></i> <?=$order_title?></b></a>
                                </div>
                                <div class="col-md-8">
                                    <p><?=$order_description?></p>
</p>
                                </div>
                            </div>
                        </div>
                    	<div class="boxitem">
                        	<div class="row">
                                <div class="col-md-4">
                                    <b style="margin-top: 21%;"><i class="fa fa-pagelines"></i> <?=$thrive_title?></b>
                                </div>
                                <div class="col-md-8">
                                    <p><?=$thrive_description?></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
      </div>

      <div class="homebottom">
          <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-5">
                    	<div class="boxitemtwo clearfix catimages">
                            <h2>Categories</h2>
                            
                            <?php 
                            if(!empty($categories)) {
                            $count = 1;
                            ?>
                            <?php foreach ($categories as $category) {
                            
                            
                            if($count%2==1){
                            $size = 'style="height: 102px; width: 100%;" ';//'width="496" height="86"';
                            $img = $category['image'];
                            }else {
                            $size = "";
                            $img = $category['thumb'];
                            }
                            
                            ?>
                            <a href="<?=$category['href']?>" title="<?=$category['name']?>"><img alt="<?=$category['name']?>" src="<?=$img?>" <?=$size?>  class="img-responsive" ></a>
                            <?php } ?>
                            
                            <?php $count++; } ?>
                        </div>
                    </div>
                    <div class="col-md-7">
                        <?php echo $content_top; ?>
                        
                    	
                    </div>
                </div>
            </div>
          </div>
      </div>
<script>
    $("#id_home").hide();
</script>
<?php echo $footer; ?>
