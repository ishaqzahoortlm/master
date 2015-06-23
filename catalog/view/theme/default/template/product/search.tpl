<?php echo $header; ?>

<div id="breadcrumb">
    <div class="container">
        <div class="row">
            <a href="<?= $this->url->link('common/home') ?>">Home</a>
            <?php for ($bi = 1; $bi < count($breadcrumbs); $bi++) { ?>
                <i class="fa fa-angle-double-right"></i>
                <?php
                if ($bi < (count($breadcrumbs) - 1)) {
                    ?>
                    <span><a href="<?= $breadcrumbs[$bi]['href'] ?>"><?= $breadcrumbs[$bi]['text'] ?></a></span> 
                <?php } else { ?>
                    <span><?= $breadcrumbs[$bi]['text'] ?></span> 
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
        </div>-->
                <div class="col-md-12">
                    <div class="cathead"><h2> <?php echo $heading_title; ?></h2></div>
                    <hr>
                    <div class="row" >
                        <div class="col-sm-4">
                            <input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $text_keyword; ?>" id="input-search" class="form-control" />
                        </div>
                        <div class="col-sm-3">
                            <select name="category_id" class="form-control">
                                <option value="0"><?php echo $text_category; ?></option>
                                <?php foreach ($categories as $category_1) { ?>
                                    <?php if ($category_1['category_id'] == $category_id) { ?>
                                        <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
                                    <?php } ?>
                                    <?php foreach ($category_1['children'] as $category_2) { ?>
                                        <?php if ($category_2['category_id'] == $category_id) { ?>
                                            <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
                                        <?php } else { ?>
                                            <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
                                        <?php } ?>
                                        <?php foreach ($category_2['children'] as $category_3) { ?>
                                            <?php if ($category_3['category_id'] == $category_id) { ?>
                                                <option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
                                            <?php } else { ?>
                                                <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
                                            <?php } ?>
                                        <?php } ?>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </div>
                        <div class="col-sm-3">
                            <label class="checkbox-inline">
                                <?php if ($sub_category) { ?>
                                    <input type="checkbox" name="sub_category" value="1" checked="checked" />
                                <?php } else { ?>
                                    <input type="checkbox" name="sub_category" value="1" />
                                <?php } ?>
                                <?php echo $text_sub_category; ?></label>
                        </div>
                    </div>
                    <p>
                        <label class="checkbox-inline">
                            <?php if ($description) { ?>
                                <input type="checkbox" name="description" value="1" id="description" checked="checked" />
                            <?php } else { ?>
                                <input type="checkbox" name="description" value="1" id="description" />
                            <?php } ?>
                            <?php echo $entry_description; ?></label>
                    </p>
                    <input type="button" value="<?php echo $button_search; ?>" id="button-search" class="btn btn-primary" />
                    <hr/>

                    <?php if ($products) { ?>
                        <div class="row">
                            <div class="col-md-9 col-xs-12 col-sm-6">
                                <?php if ($this->customer->getId()) { ?>
                                    <a href="<?= $this->url->link('product/product/quote') ?>"><button id="btn_custom" type="button" class="btn btn-primary"><?= $this->config->get('config_btn_product_quote') ?></button></a>
                                <?php } else { ?>
                                    <a href="javascript:void(0)" onclick="javascript:alert('<?= $alert_login ?>')" ><button id="btn_custom" type="button" class="btn btn-primary "><?= $this->config->get('config_btn_product_quote') ?></button> </a>
                                <?php } ?>
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
                                <?php $cnt = 1;
                                foreach ($products as $product) { ?>    
                                    <div class="productboxstwo <?= ($cnt == 1 || $cnt == 5 || $cnt == 9 || $cnt == 13 ) ? 'nomarleft' : '' ?>">
                                        <div class="proscrolimg">
                                            <a href="<?php echo $product['href']; ?>"><img class="img-responsive" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="" /></a>
                                        </div>
                                        <a class="protitle" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                                        <div class="proprice"><?php echo $product['price']; ?></div>
                                        <span>
                                            <?php if ($product['stock_status'] == 'Out Of Stock') { ?>
                                                Sold
                                            <?php } else { ?>
                                                In Stock
        <?php } ?>
                                        </span>
                                    </div> 
        <?php $cnt++;
    } ?>

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




<script type="text/javascript"><!--
$('#button-search').bind('click', function () {
        url = 'index.php?route=product/search';

        var search = $('#content input[name=\'search\']').prop('value');

        if (search) {
            url += '&search=' + encodeURIComponent(search);
        }

        var category_id = $('#content select[name=\'category_id\']').prop('value');

        if (category_id > 0) {
            url += '&category_id=' + encodeURIComponent(category_id);
        }

        var sub_category = $('#content input[name=\'sub_category\']:checked').prop('value');

        if (sub_category) {
            url += '&sub_category=true';
        }

        var filter_description = $('#content input[name=\'description\']:checked').prop('value');

        if (filter_description) {
            url += '&description=true';
        }
        location = url;
    });

    $('#content input[name=\'search\']').bind('keydown', function (e) {
        if (e.keyCode == 13) {
            $('#button-search').trigger('click');
        }
    });

    $('select[name=\'category_id\']').on('change', function () {
        if (this.value == '0') {
            $('input[name=\'sub_category\']').prop('disabled', true);
        } else {
            $('input[name=\'sub_category\']').prop('disabled', false);
        }
    });

    $('select[name=\'category_id\']').trigger('change');
--></script> 
<?php echo $footer; ?> 