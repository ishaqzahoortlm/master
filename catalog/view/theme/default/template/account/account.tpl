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
                <?php if ($success) { ?>
                    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
                    <?php } ?>
                <div class="col-md-3"><?php echo $column_right; ?></div>
                <div class="col-md-9">
                <div class="main-content" >
                    

                    <div class="col-md-12" style="margin-top: 10px;">
                        <h4><?php echo $ms_account_dashboard_nav; ?></h4>
                        <div class="col-md-4">
                            <a class="link_color" href="<?php echo $order; ?>">
                                <i class="fa fa-shopping-cart"></i>
                                <span><?php echo $text_my_orders; ?></span>
                            </a>
                        </div>  
                        <div class="col-md-4">
                            <a class="link_color"  href="<?php echo $edit; ?>">
                                <i class="fa fa-user"></i>
                                <span><?php echo $text_edit; ?></span>
                            </a>
                        </div>   
                        <div class="col-md-4">
                            <a class="link_color"  href="<?php echo $address; ?>">
                                <i class="fa fa-folder"></i>	
                                <span><?php echo $text_address_dashboard; ?></span>
                            </a>
                        </div>
                    </div>

                </div>
                </div>
                
                
            </div>
        </div>
    </div>
</div>

<?php echo $footer; ?>