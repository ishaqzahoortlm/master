<?php echo $header; ?>
<div id="breadcrumb">
    <div class="container">
        <div class="row">
            <a href="<?=$this->url->link('common/home')?>">Home</a><i class="fa fa-angle-double-right"></i>
            <span><?=$breadcrumbs[1]['text']?></span>
        </div>
    </div>
</div>

<div id="bodyiner">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="main-content info_text_align">
                    
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="cathead"><h2> <?php echo $heading_title; ?></h2></div>
                        </div>
                        <div class="col-md-6">
                            <?php if ($information_id == '4'): ?>
                            <div class="pull-right">
                                <a href="http://www.thelevelmarket.com/tlm/the-team" target="_blank" class="">
                                    <?= "The Team"; ?>
                                </a> | 
                                <a href="http://www.thelevelmarket.com/tlm/careers" target="_blank" class="">
                                    <?= "Careers"; ?>
                                </a>
                            </div>
                            <?php endif; ?>
                        </div>
                    </div>
                    
                
                    <hr style="margin-top: 0px;">
                    
                    <div class="rte">
                        <?php echo $description; ?>
                    </div>
                

                    <?php //if($information_id==8) { ?>
                <!--
                    <script type="text/javascript">
                        $(document).ready(function () {
                            $('[data-toggle="popover"]').popover({trigger: "hover"});
                        });
                    </script>

                    <table cellpadding="0" cellspacing="0" border="0" align="center" width="660px" class="howitwork">
                        <tr>
                            <td align="right" ><img   src="catalog/view/theme/default/image/arrow-01.png" /></td>
                            <td align="center">
                                <img data-trigger="hover" data-toggle="popover" data-placement="top" title="<?=$this->config->get('config_hw_s1_title')?>" data-content="<?=$this->config->get('config_hw_s1_detail')?>" src="<?=HTTP_SERVER?>image/<?=$this->config->get('config_image_hw_s1')?>" class="imgborder" />
                                <h4><?=$this->config->get('config_hw_s1_title')?></h4>
                            </td>
                            <td align="left"><img src="catalog/view/theme/default/image/arrow-02.png" /></td>
                        </tr>
                        <tr>
                            <td align="center">
                                <img data-trigger="hover" data-toggle="popover" data-placement="top" title="<?=$this->config->get('config_hw_s4_title')?>" data-content="<?=$this->config->get('config_hw_s4_detail')?>" src="<?=HTTP_SERVER?>image/<?=$this->config->get('config_image_hw_s4')?>" class="imgborder" />
                                <h4><?=$this->config->get('config_hw_s4_title')?></h4>
                            </td>
                            <td>&nbsp;</td>
                            <td align="center">
                                <img data-trigger="hover" data-toggle="popover" data-placement="top" title="<?=$this->config->get('config_hw_s2_title')?>" data-content="<?=$this->config->get('config_hw_s2_detail')?>" src="<?=HTTP_SERVER?>image/<?=$this->config->get('config_image_hw_s2')?>" class="imgborder" />
                                <h4><?=$this->config->get('config_hw_s2_title')?></h4>
                            </td>               
                        </tr>
                        <tr>
                            <td align="right"><img src="catalog/view/theme/default/image/arrow-03.png" /></td>
                            <td align="center">
                                <img data-trigger="hover" data-toggle="popover" data-placement="top" title="<?=$this->config->get('config_hw_s3_title')?>" data-content="<?=$this->config->get('config_hw_s3_detail')?>" src="<?=HTTP_SERVER?>image/<?=$this->config->get('config_image_hw_s3')?>" class="imgborder" />
                                <h4><?=$this->config->get('config_hw_s3_title')?></h4>
                            </td>
                            <td align="left"><img src="catalog/view/theme/default/image/arrow-04.png" /></td>
                        </tr>
                    </table> -->
                    <?php //} ?>
                </div>
            </div>
        </div>
    </div>
</div>

<?php echo $footer; ?>

<script>
    $('body').removeClass('sidebar-enabled');
</script>