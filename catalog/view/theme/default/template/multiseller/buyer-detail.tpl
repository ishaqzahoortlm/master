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

                <div class="cathead"><h2> <?php echo $heading_title; ?></h2></div>
                <hr>
                <div class="alert alert-success" style="display: none;" id="id_success"></div>
                <div class="alert alert-danger" style="display: none;" id="id_errors"></div>

<!--<div class="col-md-3"><?php //echo $column_right;  ?></div> -->
                <div class="col-md-12">
                    <div class="main-content" >
                        <div class="row">
                            <div class="col-md-12">
                                <h4>Reviews - <?= ucfirst($customer_info['firstname']) ?> <?= $customer_info['lastname'] ?> </h4>
                                <form class="form-horizontal" action='' method="post" name="form_q" id="form_q">




                                    <div class="row">
                                        <div class="">
                                            <?php if (!empty($all_reviews)) { ?>
                                                <ul class="col-md-12">
                                                    <?php foreach ($all_reviews as $review) { ?>
                                                        <li class="list-group-item">
                                                            <div class="row">

                                                                <div class="col-xs-12 col-md-12">

                                                                    <div class="comment-text" style="padding-left: 6px; text-align: justify;">
                                                                        <?= $review['text'] ?>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6" style="padding: 10px 0px 0px 12px ;">
                                                                    <?php for ($i = 1; $i <= 5; $i++) { ?>
                                                                        <?php if ($review['rating'] < $i) { ?>
                                                                            <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                                                                        <?php } else { ?>
                                                                            <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                                                                        <?php } ?>
                                                                    <?php } ?>
                                                                </div>
                                                                <div class="pull-right col-md-6"  style="font-size: 14px; text-align: right; color: #555;">
                                                                    <b style="padding-left: 6px;">By</b>: <a target="_blank" href="<?= $review['seller_href'] ?>"><?= $review['seller_company'] ?></a> on <?php echo date('M d, Y ', strtotime($review['date_added'])); ?>
                                                                </div>
                                                            </div>
                                                        </li>
                                                        <br/>
                                                    <?php } ?>

                                                </ul>
                                            <?php } else { ?>
                                                <div class="row">

                                                    <div class="col-xs-12 col-md-12" style="text-align: center;">No Record Found.</div>
                                                </div>
                                            <?php } ?>


                                        </div>
                                    </div>



                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>





<?php echo $footer; ?>
