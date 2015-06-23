<!DOCTYPE html>
<!--[if IE 7]><html class="no-js ie7 lt-ie8 lt-ie9 lt-ie10" lang="en"> <![endif]-->
<!--[if IE 8]><html class="no-js ie8 lt-ie9 lt-ie10" lang="en"> <![endif]-->
<!--[if IE 9]><html class="no-js ie9 lt-ie10"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
    <!--<![endif]-->
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><?php echo $title; ?></title>
        <base href="<?php echo $base; ?>" />
        <?php if ($description) { ?>
        <meta name="description" content="<?php echo $description; ?>" />
        <?php } ?>
        <?php if ($keywords) { ?>
        <meta name="keywords" content= "<?php echo $keywords; ?>" />
        <?php } ?>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <?php if ($icon) { ?>
        <link href="<?php echo $icon; ?>" rel="icon" />
        <?php } ?>
        <?php foreach ($links as $link) { ?>
        <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
        <?php } ?>
        <link href="catalog/view/theme/default/stylesheet/bootstrap.css" rel="stylesheet">
        <link href="catalog/view/theme/default/stylesheet/style.css" rel="stylesheet">
        <link href="catalog/view/theme/default/stylesheet/font-awesome.css" rel="stylesheet">
        <link href='http://fonts.googleapis.com/css?family=PT+Serif:400,700' rel='stylesheet' type='text/css'>
        <script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
        <script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <?php foreach ($styles as $style) { ?>
        <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
        <?php } ?>
        <script src="catalog/view/javascript/common.js" type="text/javascript"></script>
        <?php foreach ($scripts as $script) { ?>
        <script src="<?php echo $script; ?>" type="text/javascript"></script>
        <?php } ?>
        <script src="catalog/view/javascript/modernizr.js" type="text/javascript"></script>

        <?php echo $google_analytics; ?>
    </head>

    <body class=" sidebar-enabled template-index">
        <div class="container">
            <div id="header">
                <div class="headertop clearfix">
                    <div class="col-md-4 logo">
                        <?php if ($logo) { ?>
                        <a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="" /></a>
                        <?php } else { ?>
                        <a href="<?php echo $home; ?>"><?php echo $name; ?></a>
                        <?php } ?>
                    </div>
                    <div class="col-md-4 col-xs-12 pull-right">
                        <div class="toplinks">
                            <?php if ($logged) { ?>
                            <a href="<?php echo $account; ?>"><?php echo $text_account; ?></a> |
                            <a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a>
                            <?php } else { ?>
                            <a href="<?php echo $login; ?>"><?php echo $text_register; ?></a> |
                            <a href="<?php echo $login; ?>"><?php echo $text_login; ?></a>
                            <?php } ?>
                        </div>
                        <div class="searcharea">

                            <?php echo $search; ?>
                            <?php echo $cart; ?>

                        </div>
                    </div>
                </div>

            </div>
        </div> 
        <!-- Static navbar --> 
        <div class="container-fluid navbar navbar-default" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button> 
                </div>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li class="<?=$home_active?>"><a href="<?php echo $home; ?>"><i class="fa fa-home"></i></a></li>
                        
                        <li class="<?= $product_active ?> dropdown" > <a class="dropdown-toggle" data-toggle="dropdown" href="<?= $all_products ?>"><?= $text_products ?> <i class="fa fa-angle-down"></i>  </a>
                            <ul class="dropdown-menu">
                                <li ><a href="<?= $all_products ?>">All Products</a></li>
                                <?php foreach ($categories as $category) { ?>

                                    <li><a class="dropdown-toggle"  href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>                
                                        <?php if ($category['children']) { ?>
                                            <ul class="dropdown-menu">
                                                <?php foreach ($category['children'] as $children) { ?>
                                                    <li ><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
                                                <?php } ?>
                                            </ul>
                                        <?php } ?>
                                    </li>
                                <?php } ?>

                            </ul>
                        </li>
                        
                        <?php
                        foreach ($informations as $info) { ?>
                            <?php if ($info['information_id'] != 7) { ?>
                                <li class="<?= ($info_active == $info['information_id']) ? 'active' : '' ?>" ><a href="<?= $info['href'] ?>"><?= $info['title'] ?></a></li>
                            <?php } ?>    

                        <?php } ?>
                        
<!--                        <li class="<?=$blog_active?>"><a target="_blank" href="http://blog.thelevelmarket.com"><?=$text_blog?></a></li>-->
                        <li class="dropdown"> <a  class="dropdown-toggle" data-toggle="dropdown" href="#"><?=$text_community?> <i class="fa fa-angle-down"></i> </a> 
                            <ul class="dropdown-menu">
                                <li><a target="_blank" href="http://www.thelevelmarket.com/community/"><?=$text_blog?></a></li>
                                <!--<li><a href="<?=$news?>"><?=$text_news_events?></a></li> 
                                <li><a href="<?=$cms_resources_link?>"><?=$cms_resources?></a></li>
                                <li><a target="_blank" href="http://forum.thelevelmarket.com"><?=$text_forum?></a></li>-->
                            </ul>
                        </li>

                        <li class="<?=$contact_active?>" ><a href="<?=$contact?>"><?=$text_contact?></a></li>
                        
                        <!-- <li class="<?=$seller_active?> dropdown" > <a class="dropdown-toggle" data-toggle="dropdown" href="<?=$all_suppliers?>"><?=$cms_supplier?> <i class="fa fa-angle-down"></i></a>
                            <ul class="dropdown-menu">
                                <li><a href="<?=$all_suppliers?>"><?=$text_suppliers?></a></li> 
                                <?php //if($cms_supplier_promote!=""){ ?>
                                <li><a href="<?=$cms_supplier_promote_link?>"><?=$cms_supplier_promote?></a></li>
                                <?php //} ?>
                                <?php //if($cms_supplier_membership!=""){ ?>
                                <li><a href="<?=$cms_supplier_membership_link?>"><?=$cms_supplier_membership?></a></li>
                                <?php //} ?>
                                <li><a href="<?=$supplier_account_link?>"><?=$custom_account_title?></a></li>
                            </ul>
                        </li> -->
                        
                    </ul> 
                </div><!--/.nav-collapse -->
            </div>           
        </div>


