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
                    <?php if(!empty($all_news)) { ?>
                    <?php foreach ($all_news as $news) { ?>
                    <article class="blog-post">
                        <div class="col-md-12">
                            <?php if($news['image']!="") { ?>
                            <img src="<?php echo $news['image']; ?>" />
                            <?php } ?>
                        </div>
                        <h3 class="post-title"><a href="<?php echo $news['view']; ?>"><?php echo $news['title']; ?></a></h3>
                        <div class="rte post-content">
                            <p><?php echo $news['description']; ?></p>
                        </div>
                        <div class=" col-md-12 pull-left" style="margin-bottom: 10px; float: left; padding-left: 0px; "><a class="" href="<?php echo $news['view']; ?>"><input type="button" class="btn btn-primary " value="<?php echo $text_view; ?>"></a></div>
                    </article>
                    <?php }}else { ?>
                    <div style="text-align: center;" >
                        <?=$no_record?>
                    </div>

                    <?php } ?>

                </div>
                <br/>
                <br/>
                <div class="row">
                    <div class="col-sm-12">

                        <div class="col-sm-12 text-right"><?php echo $results; ?> <?php echo $pagination; ?></div>

                    </div>
                </div> 
            </div>
        </div>
    </div>
</div>


<?php echo $footer; ?>