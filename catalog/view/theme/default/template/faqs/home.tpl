<?php echo $header; ?>
<?php
//echo '<pre>';
//print_r($faq_groups);
//exit;
?>
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
    <div class="main-content" style="float: none;" >
        <?php
        if(!empty($faq_groups)) {
        ?>
        <div class="rte">
            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                <?php foreach ($faq_groups as $fq_group) { ?>
                <h4><?=$fq_group['name']?></h4>
                <?php 
                if(!empty($fq_group['faqs'])) {
                $count = 1;
                foreach ($fq_group['faqs'] as $faq) {
                ?>
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="heading<?=$count?>">
                        <h4 class="panel-title">
                            <a  class="<?=($count!=1)?'collapsed':''?>" data-toggle="collapse" data-parent="#accordion" href="#collapse<?=$count?>" aria-expanded="true" aria-controls="collapse<?=$count?>">
                                <?=$faq['question']?>
                            </a>
                        </h4>
                    </div>
                    <div id="collapse<?=$count?>" class="panel-collapse collapse <?=($count==1)?'in':''?>" role="tabpanel" aria-labelledby="heading<?=$count?>">
                        <div class="panel-body">
                            <?=$faq['answer']?>
                        </div>
                    </div>
                </div>
                
                <?php $count ++ ;} ?>
                <?php } ?>
                <?php } ?>
                
                
            </div>
        </div>
        <?php }else { ?>
        <div class='col-md-12' style="text-align: center;"><?=$text_no_faq_found?></div>
        <?php } ?>
    </div>
</div>
<?php echo $footer; ?> 