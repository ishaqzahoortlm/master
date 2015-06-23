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
            <div class="col-md-12" >
                
                <div class="cathead"><h2> <?php echo $heading_title; ?></h2></div>
                <hr >
                <span class="custom_alert" ></span>
                <div class="col-md-3"><?php echo $column_right; ?></div>
                <div class="col-md-9">
        <div class="main-content"  >
        <div id="content"  class=""><?php echo $content_top; ?>
            <h4><?php echo $heading_title; ?></h4>
            <?php if ($products) { ?>
            <div class="table-responsive">
            <table class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <td class="text-center"><?php echo $column_image; ?></td>
                        <td class="text-left"><?php echo $column_name; ?></td>
                        <td class="text-left"><?php echo $column_model; ?></td>
                        <td class="text-right"><?php echo $column_stock; ?></td>
                        <td class="text-right"><?php echo $column_price; ?></td>
                        <td class="text-right"><?php echo $column_action; ?></td>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($products as $product) { ?>
                    <tr>
                        <td class="text-center"><?php if ($product['thumb']) { ?>
                            <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                            <?php } ?></td>
                        <td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></td>
                        <td class="text-left"><?php echo $product['model']; ?></td>
                        <td class="text-right"><?php echo $product['stock']; ?></td>
                        <td class="text-right"><?php if ($product['price']) { ?>
                            <div class="price">
                                <?php if (!$product['special']) { ?>
                                <?php echo $product['price']; ?>
                                <?php } else { ?>
                                <b><?php echo $product['special']; ?></b> <s><?php echo $product['price']; ?></s>
                                <?php } ?>
                            </div>
                            <?php } ?></td>
                        <td class="text-right"><button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>',1);" data-toggle="tooltip" title="<?php echo $button_cart; ?>" class="btn btn-primary btn-sm custom_pading_btn_sm"><i class="fa fa-shopping-cart"></i></button>
                            <a href="<?php echo $product['remove']; ?>" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class=" btn-danger btn-sm "><i class="fa fa-trash-o"></i></a></td>
                    </tr>
                    <?php } ?>
                </tbody>
            </table>
            </div>    
            <?php } else { ?>
            <p><?php echo $text_empty; ?></p>
            <?php } ?>
            
            </div>

    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php echo $footer; ?> 