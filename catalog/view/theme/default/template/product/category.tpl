<?php echo $header; ?>
<div id="breadcrumb">
    <div class="container">
        <div class="row">
            <a href="<?=$this->url->link('common/home')?>">Home</a>
            <?php for($bi=1;$bi<count($breadcrumbs);$bi++){ ?>
            <i class="fa fa-angle-double-right"></i>
            <?php
            if($bi<(count($breadcrumbs)-1)){
            ?>
            <span><a href="<?=$breadcrumbs[$bi]['href']?>"><?=$breadcrumbs[$bi]['text']?></a></span> 
            <?php }else { ?>
            <span><?=$breadcrumbs[$bi]['text']?></span> 
            <?php } ?>
            <?php } ?>
        </div>
    </div>
</div>

<div id="bodyiner">
      	<div class="container">
        	<div class="row">
            	<div class="col-md-12">
                	<!--<div class="col-md-3">
                        <?php //echo $column_left; ?>
                    	<?php /* 
                        <div class="pricewidget">
                        	<div class="cathead"><h2> Price</h2></div>
                        	<div class="myslider"> 
                               <!-- <div class="spacer-b15">
                                    <label for="amountx">Price range:</label>
                                    <input type="text" id="amountx" class="slider-input">
                                </div>-->
                                <div class="slider-wrapper black-slider">
                                    <div id="slider-range2"></div>  
                                </div> 
                            </div>
                        </div>
                        
                        */?>
                        
                        
                    	<div class="pricewidget">
                        	<div class="cathead"><h2> Vendor</h2></div>
                            <div class="vendor">
                                <?php //foreach ($f_supplier as $row) { ?>
                                <label> <a href="<?=$row['href']?>"><?php //echo $row['company']; ?></a></label>
                                <?php //} ?>
                            </div>
                        </div>
                    </div> -->
                    <div class="col-md-12">                    
                    	<div class="cathead"><h2> <?php echo $heading_title; ?></h2></div>
                        <hr>
                        <?php  if ($products) { ?>
                        <div class="row">
                        	<div class="col-md-9 col-xs-12 col-sm-6">
                                    <div class="searcharea" style="display: none;">
                                    <input type="text" placeholder="Search" class="form-control">
                                    <button><i class="fa fa-search"></i></button>
                                </div>
                            </div>
                            <div class="col-md-3 col-xs-12 col-sm-6 caption">
                            	<div class="col-md-11 col-xs-7 sortarea">
                                	<span>Sort: </span>
                                    <div class="selectsort">
                                        <select id="input-sort" class="" onchange="location = this.value;">
                                            <?php foreach ($sorts as $sorts) { ?>
                                            <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                                            <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
                                            <?php } else { ?>
                                            <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                                            <?php } ?>
                                            <?php } ?>
                                        </select>
                                        <i class="fa fa-caret-down"></i>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                        <div class="row"> 
                        	<div class="col-md-12">
                                <?php $cnt = 1; foreach ($products as $product) { ?>    
                                <div class="productboxstwo <?=($cnt==1 || $cnt==5 || $cnt==9 || $cnt==13 )?'nomarleft':''?>">
                                    <div class="proscrolimg">
                                        <a href="<?php echo $product['href']; ?>"><img class="img-responsive" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                                        </div>
                                    <a class="protitle" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                                    <div class="proprice"><?php echo $product['price']; ?></div>
                                    <span>
                            <?php if($product['stock_status']=='Out Of Stock') { ?>
                            Sold
                            <?php }else { ?>
                            In Stock
                            <?php } ?>
                                        </span>
                                </div> 
                                <?php $cnt++; } ?>
                            
                                </div>
                            
                            <div class="row mrg_top_pags">
                            <div class="col-md-12">
                            <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
                            <div class="col-sm-6 text-right"><?php echo $results; ?></div>
                            </div>
                        </div>
                        </div>
                        <?php } ?>
                        <?php if (!$products) { ?>
                        <p><?php echo $text_empty; ?></p>
                        <?php } ?>
                    </div>
                </div>
            </div>
        </div>
      </div>
<?php echo $footer; ?>
