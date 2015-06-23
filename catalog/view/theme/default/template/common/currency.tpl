<?php if (count($currencies) > 1) { ?>
<div class="select-wrapper currency-switcher">
    <div class="selected-currency"><?=$code?> <i class="fa fa-caret-down"></i></div>
    <select id="currencys" name="currencys" onchange="set_currency(this.value)">
        <?php foreach ($currencies as $currency) { ?>
        <option value="<?=$currency['code']?>" <?=($currency['code'] == $code)?'selected':''?> ><?=$currency['code']?></option>
        <?php } ?>
    </select>
</div>
<?php } ?>

<div class="pull-left">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form_cur">
        <input type="hidden" name="code" id="code" value="" />
        <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
    </form>
</div>
<script>
    function set_currency(val_cur){
     $("#code").val(val_cur);
     $("#form_cur").submit();
    }
    
</script>