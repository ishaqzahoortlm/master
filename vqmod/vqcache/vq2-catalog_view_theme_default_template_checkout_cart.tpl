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
                
                <div class="cathead"><h2> <?php echo $heading_title; ?></h2></div>
                <hr>
                <?php if ($attention) { ?>
            <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
            <?php } ?>
            <?php if ($success) { ?>
            <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
            <?php } ?>
            <?php if ($error_warning) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
            <?php } ?>
                <!--<div class="col-md-3"><?php //echo $column_left; ?></div>-->
                <div class="col-md-12">
                    <div class="main-content">
            
            <div id="content" class=""><?php echo $content_top; ?>
                
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <td class="text-center"><?php echo $column_image; ?></td>
                                    <td class="text-left"><?php echo $column_name; ?></td>
                                    <td class="text-left"><?php echo $column_model; ?></td>
                                    <td class="text-left"><?php echo $column_quantity; ?></td>
                                    <td class="text-right"><?php echo $column_price; ?></td>
                                    <td class="text-right"><?php echo $column_total; ?></td>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($products as $product) { ?>
                                <tr>
                                    <td class="text-center"><?php if ($product['thumb']) { ?>
                                        <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail" /></a>
                                        <?php } ?></td>
                                    <td class="text-left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>

				<?php
					$this->load->language('multiseller/multiseller');
					$seller = $this->MsLoader->MsSeller->getSeller($this->MsLoader->MsProduct->getSellerId($product['product_id']));
					if ($seller) {
						echo "<span class='ms-by-seller'>" . $this->language->get('ms_by') . " <a href='". $this->url->link('seller/catalog-seller/profile', 'seller_id=' . $seller['seller_id']) ."'>{$seller['ms.company']}</a>";
					}
				?>
			
                                        <?php if (!$product['stock']) { ?>
                                        <span class="text-danger">***</span>
                                        <?php } ?>
                                        <?php if ($product['option']) { ?>
                                        <?php foreach ($product['option'] as $option) { ?>
                                        <br />
                                        <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                                        <?php } ?>
                                        <?php } ?>
                                        <?php if ($product['reward']) { ?>
                                        <br />
                                        <small><?php echo $product['reward']; ?></small>
                                        <?php } ?>
                                        <?php if ($product['recurring']) { ?>
                                        <br />
                                        <span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small>
                                        <?php } ?></td>
                                    <td class="text-left"><?php echo $product['model']; ?></td>
                                    <td class="text-left"><div class="input-group btn-block" style="max-width: 200px;">
                                            <input type="text" onKeyPress="return numbersonly(event)" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" class="form-control" />
                                            <span class="input-group-btn">
                                                <button type="submit" data-toggle="tooltip" title="<?php echo $button_update; ?>" class="btn btn-primary"><i class="fa fa-refresh"></i></button>
                                                <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="cart.remove('<?php echo $product['key']; ?>');"><i class="fa fa-times-circle"></i></button></span></div></td>
                                    <td class="text-right"><?php echo $product['price']; ?></td>
                                    <td class="text-right"><?php echo $product['total']; ?></td>
                                </tr>
                                <?php } ?>
                                <?php foreach ($vouchers as $vouchers) { ?>
                                <tr>
                                    <td></td>
                                    <td class="text-left"><?php echo $vouchers['description']; ?></td>
                                    <td class="text-left"></td>
                                    <td class="text-left"><div class="input-group btn-block" style="max-width: 200px;">
                                            <input type="text" name="" value="1" size="1" disabled="disabled" class="form-control" />
                                            <span class="input-group-btn"><button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="voucher.remove('<?php echo $vouchers['key']; ?>');"><i class="fa fa-times-circle"></i></button></span></div></td>
                                    <td class="text-right"><?php echo $vouchers['amount']; ?></td>
                                    <td class="text-right"><?php echo $vouchers['amount']; ?></td>
                                </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                    </div>
                </form>
                <?php if ($coupon || $voucher || $reward || $shipping) { ?>
                <h2><?php echo $text_next; ?></h2>
                <p><?php echo $text_next_choice; ?></p>
                <div class="panel-group" id="accordion"><?php echo $coupon; ?><?php echo $voucher; ?><?php echo $reward; ?><?php echo $shipping; ?></div>
                <?php } ?>
                <br />
                <div class="row">
                    <div class="col-sm-4 col-sm-offset-8">
                        <table class="table table-bordered">
                            <?php foreach ($totals as $total) { ?>
                            <tr>
                                <td class="text-right"><strong><?php echo $total['title']; ?>:</strong></td>
                                <td class="text-right"><?php echo $total['text']; ?></td>
                            </tr>
                            <?php } ?>
                        </table>
                    </div>
                </div>
                <div class="buttons">
                    <div class="pull-left"><a href="<?php echo $continue; ?>" class=""><button class="btn btn-primary" type="button" ><?php echo $button_shopping; ?></button></a></div>
                    <div class="pull-right">
                        
                        <a href="<?php echo $checkout; ?>" class="">
                            <input type="button" value="<?php echo $button_checkout; ?>" class="btn btn-primary" />
                            </a></div>
                </div>
                <?php echo $content_bottom; ?></div>
        </div>
    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function numbersonly(e) {
        var unicode = e.charCode ? e.charCode : e.keyCode
        if (unicode != 8) { //if the key isn't the backspace key (which we should allow)
            if (unicode < 48 || unicode > 57) //if not a number
                return false //disable key press
        }
    }
    
</script>

<?php echo $footer; ?>




