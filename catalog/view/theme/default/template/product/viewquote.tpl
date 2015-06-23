<?php 
$text_font_size = 'font-size:14px;';
?>
<div style="width: 100%; padding: 1%; float: left;">
    <div style="width: 50%; float: left; <?=$text_font_size?>  ">
        &nbsp;<?=$entry_id?> : <?=sprintf("%08d",$quote_detail[0]['id'])?>
    </div>

    <div style="width: 50%; float: left; <?=$text_font_size?>">
        &nbsp;<?=$entry_date?> : <?=date('m/d/Y',strtotime($quote_detail[0]['create_date']))?>
    </div>
    <?php if($flag_type=='view') { ?>
    <div style="width: 50%; float: left; <?=$text_font_size?>">
        &nbsp;<?=$entry_status?> : <?=$quote_detail[0]['status']?>
    </div>

    <div style="width: 50%; float: left; <?=$text_font_size?>">
        &nbsp;<?=$entry_date_responded?> : <?=($quote_detail[0]['responded_date']!='0000-00-00 00:00:00')?date('m/d/Y h:i A',strtotime($quote_detail[0]['responded_date'])):''?>
    </div>
    <?php } ?>

    <h4 style="padding: 0px; margin-top: 0px;">&nbsp;</h4>
    <h4 style="padding: 8px; margin-top: 0px; background: #2a3e51; color:#fff"><?=$heading_buyer?></h4>

    <div style="width: 100%; background-color:#eeeeef; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?> ">
        <div style="width: 30%; float: left; ">
            <?=$entry_company?> : 
        </div>
        <div style="width: 70%; float: left; ">
            <?=$quote_detail[0]['buyer_company']?>
        </div>
    </div>
    <div style="width: 100%; background-color:#FFF; padding: 2px 0px 2px 2px;  float: left;  <?=$text_font_size?>">
        <div style="width: 30%; float: left; ">
            <?=$entry_name?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['buyer_name']?>
        </div>
    </div>
    <div style="width: 100%; background-color:#eeeeef; padding: 2px 0px 2px 2px;  float: left;  <?=$text_font_size?>">

        <div style="width: 30%; float: left;">
            <?=$entry_email?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['buyer_email']?>
        </div>
    </div>
    <div style="width: 100%; background-color:#FFF; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?> ">

        <div style="width: 30%; float: left;">
            <?=$entry_phone?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['buyer_phone']?>
        </div>
    </div>
    <div style="width: 100%; background-color:#eeeeef; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?> ">

        <div style="width: 30%; float: left;">
            <?=$entry_address?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['buyer_address']?>, <?=$quote_detail[0]['buyer_city']?><br/> <?=$quote_state?>, <?=$quote_country?>
        </div>
    </div>
    <h4 style="padding: 0px; margin-top: 0px;">&nbsp;</h4>
    <h4 style="padding: 8px; margin-top: 0px; background: #2a3e51; color:#fff"><?=$heading_product?></h4>
    <div style="width: 100%; background-color:#eeeeef; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?> ">

        <div style="width: 30%; float: left;">
            <?=$entry_name?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['product_name']?>
        </div>
    </div>
    <div style="width: 100%; background-color:#FFF; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">

        <div style="width: 30%; float: left;">
            <?=$entry_product_detail?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['product_detail']?>
        </div>
    </div>
    <div style="width: 100%; background-color:#eeeeef; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">

        <div style="width: 30%; float: left;">
            <?=$entry_price?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['price']?>
        </div>
    </div>
    <div style="width: 100%; background-color:#FFF; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">

        <div style="width: 30%; float: left;">
            <?=$entry_qty?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['quantity']?>
        </div>
    </div>
    <div style="width: 100%; background-color:#eeeeef; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">

        <div style="width: 30%; float: left;">
            <?=$entry_currency?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['currency']?>&nbsp;
        </div>
    </div>
    <div style="width: 100%; background-color:#FFF; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">

        <div style="width: 30%; float: left;">
            <?=$entry_unit?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['unit']?>&nbsp;
        </div>
    </div>
    <div style="width: 100%; background-color:#eeeeef; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">

        <div style="width: 30%; float: left;">
            <?=$entry_billing?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['billing_address']?>&nbsp;
        </div>
    </div>
    <h4 style="padding: 0px; margin-top: 0px;">&nbsp;</h4>
    <h4 style="padding: 8px; margin-top: 0px;  background: #2a3e51; color:#fff"><?=$heading_shipping?> <?=$heading_shipping_sub?></h4>
    
    <div style="width: 100%; background-color:#eeeeef; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">

        <div style="width: 30%; float: left;">
            <?=$text_destination?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$buyer_country?>
        </div>
    </div>
    
    <div style="width: 100%; background-color:#FFF; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">

        <div style="width: 30%; float: left;">
            <?=$text_payment_terms?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['buyer_payment_terms']?>
        </div>
    </div>
    
    <div style="width: 100%; background-color:#eeeeef; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">

        <div style="width: 30%; float: left;">
            <?=$text_shipping_method?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['buyer_shipping_method']?>
        </div>
    </div>
    <?php 
    if($mail_type =='to_buyer'){
    ?>
    <h4 style="padding: 0px; margin-top: 0px;">&nbsp;</h4>
    <h4 style="padding: 8px; margin-top: 0px;  background: #2a3e51; color:#fff"><?=$heading_shipping?> <?=$heading_shipping_subheading?></h4>
    
    <?php 
    if($quote_detail[0]['origin_country']!="") {
    ?>
    <div style="width: 100%; background-color:#eeeeef; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">

        <div style="width: 30%; float: left;">
            <?=$text_origin?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['origin_country']?>
        </div>
    </div>
    <?php } ?>
    <?php 
    if($quote_detail[0]['lead_time']!="") {
    ?>
    <div style="width: 100%; background-color:#FFF; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">
        <div style="width: 30%; float: left;">
            <?=$text_lead_time?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['lead_time']?>
        </div>
    </div>
    <?php } ?>
    <?php 
    if($quote_detail[0]['transit_time']!="") {
    ?>
    <div style="width: 100%; background-color:#eeeeef; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">

        <div style="width: 30%; float: left;">
            <?=$text_transit_time?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['transit_time']?>
        </div>
    </div>
    <?php } ?>
    <?php 
    if($quote_detail[0]['dispatch_place']!="") {
    ?>
    <div style="width: 100%; background-color:#FFF; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">
        <div style="width: 30%; float: left;">
            <?=$text_dispatch?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['dispatch_place']?>
        </div>
    </div>
    <?php } ?>
     <?php 
    if($quote_detail[0]['nearest_port']!="") {
    ?>
    <div style="width: 100%; background-color:#eeeeef; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">

        <div style="width: 30%; float: left;">
            <?=$text_port_name?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['nearest_port']?>
        </div>
    </div>
    <?php } ?>
    <?php 
    if($quote_detail[0]['goods_per_container']!="") {
    ?>
    <div style="width: 100%; background-color:#FFF; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">
        <div style="width: 30%; float: left;">
            <?=$text_gp_container?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['goods_per_container']?>
        </div>
    </div>
    <?php } ?>
    <?php 
    if($quote_detail[0]['unit_inco_terms']!="") {
    ?>
    <div style="width: 100%; background-color:#eeeeef; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">

        <div style="width: 30%; float: left;">
            <?=$text_up_inco_terms?> :
        </div>
        <div style="width: 70%; float: left;">
            <?php
            if($quote_detail[0]['unit_inco_terms']!=""){ 
            $units = json_decode($quote_detail[0]['unit_inco_terms'],true);
            $html = '';
            foreach($units as $ku=>$vu) {
            $html .= ''.$ku.' : $'.number_format($vu,2).'<br/>';
            }
            echo $html;
            }
            ?>
        </div>
    </div>
    <?php } ?>
    <?php } ?>
    
    <h4 style="padding: 0px; margin-top: 0px;">&nbsp;</h4>
    <h4 style="padding: 8px; margin-top: 0px;  background: #2a3e51; color:#fff"><?=$entry_other?></h4>
    <div style="width: 100%; background-color:#eeeeef; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">

        <div style="width: 30%; float: left;">
            <?=$entry_reference?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['reference']?>
        </div>
    </div>
    <div style="width: 100%; background-color:#FFF; padding: 2px 0px 2px 2px;  float: left; <?=$text_font_size?>">

        <div style="width: 30%; float: left;">
            <?=$entry_additional_detail?> :
        </div>
        <div style="width: 70%; float: left;">
            <?=$quote_detail[0]['message']?>
        </div>
    </div>

</div>
