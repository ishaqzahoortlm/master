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
    <div class="alert alert-danger warning main" style="display:none;"></div>
    <div class="col-md-2"></div>
    <div class="col-md-8">
    <div class="main-content" style="float: none;" >
        
        <div id="content" class="">
            <h4><?php echo $ms_account_register_seller; ?></h4>
            <br/>
            <p style="display: none;"><?php echo $text_account_already; ?></p>

            <form id="seller-form" class="form-horizontal">
                <input type="hidden" name="seller_selected_package" id="seller_selected_package"  value="<?php echo $seller_selected_package;?>">
                <input type="hidden" name="package_plane_page" id="package_plane_page" value="<?php echo $package_plane_page;?>">
                <h4><?php echo $ms_account_register_details; ?></h4>

                <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_firstname; ?></label>
                    <div class="col-sm-10">
                        <input type="text" name="seller[firstname]" placeholder="<?php echo $entry_firstname; ?>" class="form-control" />
                    </div>
                </div>

                <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_lastname; ?></label>
                    <div class="col-sm-10">
                        <input type="text" name="seller[lastname]" placeholder="<?php echo $entry_lastname; ?>" class="form-control" />
                    </div>
                </div>

                <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $ms_account_sellerinfo_nickname; ?></label>
                    <div class="col-sm-10">
                        <input type="text" name="seller[nickname]" placeholder="<?php echo $ms_account_sellerinfo_nickname_note; ?>" class="form-control" />
                    </div>
                </div>
                
                <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $ms_account_sellerinfo_company; ?></label>
                    <div class="col-sm-10">
                        <input type="text" name="seller[company]" placeholder="<?php echo $ms_account_sellerinfo_company; ?>" class="form-control" />
                    </div>
                </div>

                <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_email; ?></label>
                    <div class="col-sm-10">
                        <input type="email" name="seller[email]" placeholder="<?php echo $entry_email; ?>" class="form-control" />
                    </div>
                </div>

                <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_password; ?></label>
                    <div class="col-sm-10">
                        <input type="password" name="seller[password]" placeholder="<?php echo $entry_password; ?>" class="form-control" />
                    </div>
                </div>

                <div class="form-group required">
                    <label class="col-sm-2 control-label"><?php echo $entry_confirm; ?></label>
                    <div class="col-sm-10">
                        <input type="password" name="seller[password_confirm]" placeholder="<?php echo $entry_confirm; ?>" class="form-control" />
                    </div>
                </div>

                <?php if (isset($seller_terms)) { ?>
                <div class="form-group ">
                    <label class="col-sm-2 control-label"></label>
                    <div class="col-sm-10">
                        <p style="margin-bottom: 0">
                            <input type="checkbox" name="seller[terms]" value="1" />
                            <?php echo $seller_terms; ?>
                        </p>
                    </div>
                </div>
                <?php } ?>



                <div class="form-group ">
                    <label class="col-sm-2 control-label" for="input-confirm"></label>
                    <div class="col-sm-10"><input type="button" id="ms-submit-button" value="<?php echo $button_continue; ?>" class="btn btn-primary" /></div>
                </div>


            </form>

            </div>

    </div>
    </div>
    </div>
    </div>
    </div>
    </div>

<script>
    var msGlobals = {
        formError: '<?php echo htmlspecialchars($ms_error_form_submit_error, ENT_QUOTES, "UTF-8"); ?>'
    };
</script>
<?php echo $footer; ?>