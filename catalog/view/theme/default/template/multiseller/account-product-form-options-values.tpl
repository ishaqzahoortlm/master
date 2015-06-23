<div class="option">
    <input type="hidden" name="product_option[<?php echo $option_index; ?>][option_id]" value="<?php echo $option['option_id']; ?>"></td>
    <input type="hidden" name="product_option[<?php echo $option_index; ?>][required]" value="1"></td>
    <div class="o-heading"><span class="option_required <?php echo isset($option['required']) && !$option['required'] ? "bw" : ""; ?>" title="<?php echo $ms_options_required; ?>"></span><?php echo $option['name']; ?><a class="btn-sm btn-danger pull-right option_delete" style="margin-right: 8px;" title="<?php echo $ms_delete; ?>"><i class="fa fa-trash-o"></i></a></div>

    <?php if (!empty($values)) { ?>
    <div class="o-content">
        <div class="option_values mmCtr">
            <div class="option_value ffSample row" >

                <div class="col-sm-2"><span class="option_name"></span> 
                    <input type="hidden" name="product_option[<?php echo $option_index; ?>][product_option_value][0][option_value_id]" value="">
                    <input type="hidden" name="product_option[<?php echo $option_index; ?>][product_option_value][0][price_prefix]" value="+">
                </div>
                <div class="col-sm-1"><span class="option_price_prefix plus" title="<?php echo $ms_options_price_prefix; ?>"></span></div>
                <div class="col-sm-4"><span class="option_price">
                        <?php echo $this->currency->getSymbolLeft(); ?>
                        <input type="text" class="form-control inline" style="width: 200px; display: inline !important;" placeholder="<?php echo $ms_options_price; ?>" name="product_option[<?php echo $option_index; ?>][product_option_value][0][price]" value="" size="5"></td>
                        <?php echo $this->currency->getSymbolRight(); ?>
                    </span></div>
                <div class="col-sm-3"><input class="option_quantity form-control inline" type="text" style="width: 200px;" placeholder="<?php echo $ms_options_quantity; ?>" name="product_option[<?php echo $option_index; ?>][product_option_value][0][quantity]" value="" size="5"></div>
                <div class="col-sm-1"><a class="btn-sm btn-danger option_value_delete" title="<?php echo $ms_delete; ?>"><i class="fa fa-trash-o"></i></a></div>
            </div>

            <?php if (!empty($product_option_values)) { ?>
            <?php $i = 1; ?>
            <?php foreach ($product_option_values as $value) { ?>
            <div class="option_value row">

                <div class="col-sm-2">    <span class="option_name"><?php echo $value['name']; ?></span>
                    <input type="hidden" name="product_option[<?php echo $option_index; ?>][product_option_value][<?php echo $i; ?>][option_value_id]" value="<?php echo $value['option_value_id']; ?>">
                    <input type="hidden" name="product_option[<?php echo $option_index; ?>][product_option_value][<?php echo $i; ?>][price_prefix]" value="<?php echo $value['price_prefix']; ?>">
                </div>
                <div class="col-sm-1"><span class="option_price_prefix <?php echo ($value['price_prefix'] == '+' ? "plus" : "minus"); ?>" title="<?php echo $ms_options_price_prefix; ?>"></span></div>
                <div class="col-sm-4">
                <span class="option_price">
                    <?php echo $this->currency->getSymbolLeft(); ?>
                    <input type="text" class="form-control inline" style="width: 200px; display: inline !important;" placeholder="<?php echo $ms_options_price; ?>" name="product_option[<?php echo $option_index; ?>][product_option_value][<?php echo $i; ?>][price]" value="<?php echo $this->MsLoader->MsHelper->trueCurrencyFormat($value['price']); ?>" size="5"></td>
                    <?php echo $this->currency->getSymbolRight(); ?>
                </span></div>
                <div class="col-sm-3"><input class="option_quantity form-control inline" type="text" style="width: 200px;" placeholder="<?php echo $ms_options_quantity; ?>" name="product_option[<?php echo $option_index; ?>][product_option_value][<?php echo $i; ?>][quantity]" value="<?php echo $value['quantity']; ?>" size="5"></div>
                <div class="col-sm-1"><a class="btn-sm btn-danger option_value_delete" title="<?php echo $ms_delete; ?>"><i class="fa fa-trash-o"></i></a></div>
            </div>			
            <?php $i++; ?>
            <?php } ?>
            <?php } ?>
        </div>

        <select class="select_option_value form-control" id="select_option_value<?php echo $option['option_id']; ?>" style="width: 200px;">
            <option value="0" disabled="disabled" selected="selected"><?php echo $ms_options_add_value; ?></option>
            <?php foreach($values as $value) { ?>
            <option value="<?php echo $value['option_value_id']?>"><?php echo $value['name']; ?></option>
            <?php } ?>
        </select>
    </div>
    <?php } ?>
</div>

<script type="text/javascript">
    $('input[name$="[option_value_id]"]').each(function (index) {
        $(this).closest('.option').find('.select_option_value option[value="' + $(this).val() + '"]').attr('disabled', true);
    });
</script>