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

<script>
var get_total_customer_un = $('#customer_total').val();
if(get_total_customer_un>0){
$('#id_customer_message').html($('#id_customer_message').html()+' ('+get_total_customer_un+')');
}
</script>
    