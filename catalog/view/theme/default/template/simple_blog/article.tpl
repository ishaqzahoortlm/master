<?php echo $header; ?>
    <div class="main-content-wrapper" >
    <div class="page-header">
        <div class="breadcrumbs"> 
            <a href="<?=$this->url->link('common/home')?>">Home</a>
            <?php for($bi=1;$bi<count($breadcrumbs);$bi++){ ?>
            <span class="divider">/</span> 
            <?php
            if($bi<(count($breadcrumbs)-1)){
            ?>
            <span><a href="<?=$breadcrumbs[$bi]['href']?>"><?=$breadcrumbs[$bi]['text']?></a></span> 
            <?php }else { ?>
            <span><?=$breadcrumbs[$bi]['text']?></span> 
            <?php } ?>
            <?php } ?>


        </div>
        <h1 class="page-title"><?php echo $heading_title; ?></h1>
    </div>
    <div class="main-content" >
        <div id="content" class="">
                <h4><?php echo $heading_title; ?></h4>
                
                <div class="row">
                    <?php if($articles) { ?>
                        <?php foreach($articles as $article) { ?>                            
                            <div class="form-group">
                                <div class="article-title">
                                    <h1><a href="<?php echo $article['href']; ?>"><?php echo ucwords($article['article_title']); ?></a><h1>
                                </div>
                                
                                <div class="article-sub-title">
        							<span class="article-author"><a href="<?php echo $article['author_href']; ?>"><?php echo $article['author_name']; ?></a></span>
        							<!-- <span class="article-author"><?php echo $article['author_name']; ?></span> -->
        							<span class="bullet">&bull;</span>
        							<span class="article-date"><?php echo $article['date_added']; ?></span>
        							
        							<?php if($article['allow_comment']) { ?>
        								<span class="bullet">&bull;</span>
        								<span class="article-comment"><a href="<?php echo $article['comment_href']; ?>#comment-section"><?php echo $article['total_comment']; ?></a></span>
        							<?php } ?>
        							
        						</div>
                                
                                <?php if($article['image']) { ?>
        							<?php if($article['featured_found']) { ?>
        								<div class="article-image">
        									<img src="<?php echo $article['image']; ?>" alt="<?php echo $article['article_title']; ?>" />
        								</div>
        							<?php } else { ?>
        								<div class="article-thumbnail-image">
        									<img src="<?php echo $article['image']; ?>" alt="<?php echo $article['article_title']; ?>" />
        									<span class="article-description">
        										<?php echo $article['description']; ?>
        									</span>
        								</div>
        							<?php } ?>
        						<?php } ?>
                                
                                <?php if($article['featured_found']) { ?>						
        							<div class="article-description">
        								<?php echo $article['description']; ?>
        							</div>
        						<?php } else { ?>
        							<div class="article-description">
        								<?php echo $article['description']; ?>
        							</div>
        						<?php } ?>
                                
                                <div align="right">
                                    <a class="btn btn-default btn-large" href="<?php echo $article['href']; ?>"><b><?php echo $button_continue_reading; ?></b></a>
                                </div>
                                
                                <?php if(!$article['featured_found']) { ?>
        							<div class="article-thumbnail-found"></div>
        						<?php } ?>                                
                            </div>
                        <?php } ?>
                        
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 text-left"><?php echo $pagination; ?></div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 text-right"><?php echo $results; ?></div>
                        </div>
                           
                    <?php } else { ?>
                        <h3 class="text-center"><?php echo $text_no_found; ?></h3>
                    <?php } ?>
                </div>               
            </div> 
     </div>
     <?php echo $content_bottom; ?>
</div>
<?php echo $footer; ?>     
