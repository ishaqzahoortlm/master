
<table class="table table-bordered">
    <thead>
        <tr>
            <td class="text-left" style="width: 15%;"><?=$ms_clm_date_add?></td>
            <td class="text-left"><?=$ms_text_rc?></td>
            <td class="text-left" style="width: 15%;"><?=$ms_text_status?></td>
            <td class="text-left" style="width: 15%;"><?=$ms_text_nc?></td>
        </tr>
    </thead>
    <tbody>
        <?php if(!empty($return_history)) { ?>
        <?php foreach ($return_history as $row) { ?>
        <tr>
            <td class="text-left"><?=date('M d, Y',strtotime($row['date_added']))?></td>
            <td class="text-left"><?=$row['comment']?></td>
            <td class="text-left"><?=$row['status']?></td>
            <td class="text-left"><?=($row['notify']=='1'?'Yes':'No')?></td>
        </tr>
        <?php } ?>
        <?php }else { ?>
        <tr>
            <td class="text-center" colspan="4"><?=$ms_no_record?></td>
        </tr>
        <?php } ?>
    </tbody>
</table>