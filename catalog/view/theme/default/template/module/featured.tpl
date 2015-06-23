<div class="boxitemtwo clearfix">
    <h2>Popular Items</h2>
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <a class="left carousel-control" href="#myCarousel" data-slide="prev"><span class="fa fa-angle-left"></span></a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next"><span class="fa fa-angle-right"></span></a>
        <div class="carousel-inner">
            
           <?php 
           $count = 1;
            foreach (array_chunk($products, 3, true) as $array){
           ?>
           <div class="item <?=($count==1)?'active':''?>">
            <?php foreach($array as $product) { ?>
                    <div class="productboxs">
                    <div class="proscrolimg">
                        <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a>
                    </div>

                    <a class="protitle" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                    <div class="proprice"><?php echo $product['price']; ?></div>
                    </div>
            <?php } ?>
                
                </div>
            <?php $count++; } ?>
            

        </div>                              
    </div>
</div>

