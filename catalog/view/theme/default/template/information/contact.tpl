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
                <div class="main-content" style="float: none;" >
                    <div id="content" class="">
                        <div class="col-sm-9">      
                            <h4 style="display: none;"><?php echo $heading_title; ?></h4>
                            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">


                                <div class="form-group required">
                                    <label class="col-sm-3 control-label" for="input-name"><?php echo $entry_name; ?></label>
                                    <div class="col-sm-9">
                                        <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" />
                                        <?php if ($error_name) { ?>
                                            <div class="text-danger"><?php echo $error_name; ?></div>
                                        <?php } ?>
                                    </div>
                                </div>
                                <div class="form-group required">
                                    <label class="col-sm-3 control-label" for="input-name"><?php echo $entry_CompanyName; ?></label>
                                    <div class="col-sm-9">
                                        <input type="text" name="CompanyName" value="<?php echo $CompanyName; ?>" id="input-CompanyName" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group required">
                                    <label class="col-sm-3 control-label" for="input-email"><?php echo $entry_email; ?></label>
                                    <div class="col-sm-9">
                                        <input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control" />

                                        <?php if ($error_email) { ?>
                                            <div class="text-danger"><?php echo $error_email; ?></div>
                                        <?php } ?>
                                    </div>
                                </div>
                                <div class="form-group"> <!--  required -->
                                    <label class="col-sm-3 control-label" for="input-subject"><?php echo $entry_subject; ?></label>
                                    <div class="col-sm-9">
                                        <input type="text" name="subject" value="<?php echo $subject; ?>" id="input-subject" class="form-control" />

                                        <?php if ($error_subject) { ?>
                                            <div class="text-danger"><?php echo $error_subject; ?></div>
                                        <?php } ?>
                                    </div>
                                </div>
                                <div class="form-group required">
                                    <label class="col-sm-3 control-label" for="input-enquiry"><?php echo $entry_enquiry; ?></label>
                                    <div class="col-sm-9">
                                        <textarea name="enquiry" rows="10" id="input-enquiry" class="form-control"><?php echo $enquiry; ?></textarea>
                                        <?php if ($error_enquiry) { ?>
                                            <div class="text-danger"><?php echo $error_enquiry; ?></div>
                                        <?php } ?>
                                    </div>
                                </div>
                                <div class="form-group required">
                                    <label class="col-sm-3 control-label" for="input-captcha"><?php echo $entry_captcha; ?></label>
                                    <div class="col-sm-9">
                                        <input type="text" name="captcha" id="input-captcha" class="form-control" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-9 pull-right">
                                        <img src="index.php?route=tool/captcha" alt="" />
                                        <?php if ($error_captcha) { ?>
                                            <div class="text-danger"><?php echo $error_captcha; ?></div>
                                        <?php } ?>
                                    </div>
                                </div>
                                <div class="form-group " style="display: none;">
                                    <label class="col-sm-3 control-label" for="input-confirm"></label>
                                    <div class="col-sm-9"><input type="checkbox"  name="check_newsletter" id="check_newsletter" value="1"> <?= $text_newsletter_signup ?>
                                    </div>
                                </div>
                                <div class="form-group ">
                                    <label class="col-sm-3 control-label" for="input-confirm"></label>
                                    <div class="col-sm-9"><input class="btn btn-primary" type="submit" value="<?php echo $button_submit; ?>" /></div>
                                </div>

                            </form>
                        </div>

                        <div class="col-sm-3">
                            <div style=" float: left; " >  <?php if ($thumb_contact != "") { ?><img src="<?= $thumb_contact ?>"><?php } ?></div>
                            <div class="">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <i class="fa fa-inbox"></i> &nbsp; <?php echo $config_email; ?><br />
                                            <i class="fa fa-phone"></i> &nbsp; <?php echo $telephone; ?><br />
                                            <?php if ($fax) { ?>
<!--                                                <strong><?php echo $text_fax; ?></strong><br>-->
                                                <i class="fa fa-fax"></i> &nbsp; <?php echo $fax; ?><br />
                                            <?php } ?>
                                        </div>

                                        <div class="col-sm-12">
                                            <address>
                                                <i class="fa fa-envelope"></i> &nbsp; <?php echo $address; ?>
                                            </address>

                                        </div>


                                    </div>
                                </div>
                            </div>                
                        </div>
                    </div>



                </div>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>
