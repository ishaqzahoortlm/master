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

<div id="bodyiner" class="innerbody">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="cathead"><h2> <?php echo $heading_title; ?></h2></div>
                <hr>
                <div class="blog-posts">

                    <article class="blog-post">

                        
                        <div class="rte post-content">
                            <?php if ($image) { ?>
                            <div class="text-center">
                                <img src="<?php echo $image; ?>" alt="<?php echo $heading_title; ?>" />
                            </div>
                            <?php } ?>
                            <p><?php echo $description; ?></p>
                        </div>
                    </article>


                </div>
            </div>
        </div>
    </div>
</div>




<?php echo $footer; ?> 