<input type="hidden" name="supplier_total" id="supplier_total" value="<?=$supplier_total?>" >
<input type="hidden" name="customer_total" id="customer_total" value="<?=$customer_total?>" >

<div class="list-group" id="id_customer_menu">
  <?php if (!$logged) { ?>
  <a  href="<?php echo $login; ?>" class="list-group-item"><?php echo $text_login; ?></a>
  <a href="<?php echo $register; ?>" class="list-group-item"><?php echo $text_register; ?></a>
  <a href="<?php echo $forgotten; ?>" class="list-group-item"><?php echo $text_forgotten; ?></a>
  <?php } ?>

				
			
  <a href="<?php echo $account; ?>" class="list-group-item"><?php echo $text_account; ?></a>
  <?php if ($logged) { ?>
  <a href="<?php echo $edit; ?>" class="list-group-item"><?php echo $text_edit; ?></a>
  <a id="id_account_password" href="<?php echo $password; ?>" class="list-group-item"><?php echo $text_password; ?></a>
  <?php } ?>
  <a href="<?=$link_messages?>" class="list-group-item" id="id_customer_message"><?=$text_messages?></a>
  <a href="<?php echo $address; ?>" class="list-group-item"><?php echo $text_address; ?></a>
  <a href="<?php echo $wishlist; ?>" class="list-group-item"><?php echo $text_wishlist; ?></a>
  <a href="<?php echo $order; ?>" class="list-group-item"><?php echo $text_order; ?></a>
  <a href="<?php echo $download; ?>" class="list-group-item"><?php echo $text_download; ?></a>
  <a href="<?php echo $reward; ?>" class="list-group-item"><?php echo $text_reward; ?></a>
  <a href="<?php echo $return; ?>" class="list-group-item"><?php echo $text_return; ?></a>
  <a href="<?php echo $transaction; ?>" class="list-group-item"><?php echo $text_transaction; ?></a>
  <a href="<?php echo $recurring; ?>" class="list-group-item"><?php echo $text_recurring; ?></a>
  <?php if ($logged) { ?>
  <a id="id_log_out" href="<?php echo $logout; ?>" class="list-group-item"><?php echo $text_logout; ?></a>
  <?php } ?>
</div>

			    <div class="list-group" id="id_seller_menu">
			        <span class="list-group-item"><b><?php echo $ms_account_seller_account; ?></b></span>
                    <?php if ($ms_seller_created) { ?>
                    <?php if ($this->MsLoader->MsSeller->getStatus($this->customer->getId()) == MsSeller::STATUS_ACTIVE) { ?>
                        <a class="list-group-item" href="<?php echo $this->url->link('seller/account-dashboard', '', 'SSL'); ?>"><?php echo $ms_account_dashboard; ?></a>
                    <?php } ?>

                    <a class="list-group-item" href= "<?php echo $this->url->link('seller/account-profile', '', 'SSL'); ?>"><?php echo $ms_account_sellerinfo; ?></a>
				
                    <?php if ($this->MsLoader->MsSeller->getStatus($this->customer->getId()) == MsSeller::STATUS_ACTIVE) { ?>
                        <a class="list-group-item" href= "<?php echo $this->url->link('seller/product-message', '', 'SSL'); ?>" id="id_seller_message"><?php echo $ms_product_message; ?></a>
                        <a class="list-group-item" href= "<?php echo $this->url->link('seller/account-product/create', '', 'SSL'); ?>"><?php echo $ms_account_newproduct; ?></a>
                        <a class="list-group-item" href= "<?php echo $this->url->link('seller/account-product', '', 'SSL'); ?>"><?php echo $ms_account_products; ?></a>
                        <a class="list-group-item" href= "<?php echo $this->url->link('seller/product-quote', '', 'SSL'); ?>"><?php echo $ms_product_quote; ?></a>
                        <a class="list-group-item" href= "<?php echo $this->url->link('seller/product-review', '', 'SSL'); ?>"><?php echo $ms_product_review; ?></a>
                            <a class="list-group-item" href= "<?php echo $this->url->link('seller/product-return', '', 'SSL'); ?>"><?php echo $ms_product_return; ?></a>
                        <a class="list-group-item" href= "<?php echo $this->url->link('seller/product-faq', '', 'SSL'); ?>"><?php echo $ms_product_faq; ?></a>
                        <a class="list-group-item" href= "<?php echo $this->url->link('seller/account-order', '', 'SSL'); ?>"><?php echo $ms_account_orders; ?></a>
                        <a class="list-group-item" href= "<?php echo $this->url->link('seller/account-transaction', '', 'SSL'); ?>"><?php echo $ms_account_transactions; ?></a>
                        <?php if ($this->config->get('msconf_allow_withdrawal_requests')) { ?>
                        <a class="list-group-item" href= "<?php echo $this->url->link('seller/account-withdrawal', '', 'SSL'); ?>"><?php echo $ms_account_withdraw; ?></a>
                        <?php } ?>
                        <a class="list-group-item" href= "<?php echo $this->url->link('seller/account-stats', '', 'SSL'); ?>"><?php echo $ms_account_stats; ?></a>
                        
                    <?php } ?>
                    <?php } else { ?>
                        <a class="list-group-item" href="<?php echo $this->url->link('account/register-seller/customer', '', 'SSL'); ?>"><?php echo $ms_account_register; ?></a>
                    <?php } ?>
                        </div>
                        <?php if ($ms_seller_created) { ?>    
                            <script>
                            $("#id_customer_menu").hide();
                            $("[id^='id_seller_menu']").append($('#id_account_password').clone(true).show().css("display", "block"));
                            $("[id^='id_seller_menu']").append($('#id_log_out').clone(true).show().css("display", "block"));
                            var get_total_un = $('#supplier_total').val();
                            if(get_total_un>0){
                            $('#id_seller_message').html($('#id_seller_message').html()+' ('+get_total_un+')');
                            }
                            </script>        
                        <div class="list-group" id="id_box_buyer">
                                    <span class="list-group-item"><b>Buyer Account</b></span>
                                    <a class="list-group-item" onclick="set_session_custome(1,'<?php echo $this->url->link('account/account', '', 'SSL'); ?>')" href="javascript:void(0)"><?php echo $ms_account_dashboard; ?></a>
                        </div>   
                            <?php } ?>
                            
                            <div class="list-group" id="id_box_supplier" style="display:none">
                                    <span class="list-group-item"><b><?php echo $ms_account_seller_account; ?></b></span>
                                    <a class="list-group-item" onclick="set_session_custome('','<?php echo $this->url->link('seller/account-dashboard', '', 'SSL'); ?>')" href="javascript:void(0)"><?php echo $ms_account_dashboard; ?></a>
                            </div>
                            
                            <?php
if(isset($this->session->data['buyer_to_seller']) && $this->session->data['buyer_to_seller']==1){
?>
<script >
    $('#id_seller_menu,#id_box_buyer').hide();
    $("#id_customer_menu").show();
    $('#id_box_supplier').show();
                                                    
</script>
<?php } ?>
                                         
                            
			

<script>
var get_total_customer_un = $('#customer_total').val();
if(get_total_customer_un>0){
$('#id_customer_message').html($('#id_customer_message').html()+' ('+get_total_customer_un+')');
}
</script>
    