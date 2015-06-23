<!--<div class="cathead"><h2><i class="fa fa-list-ul"></i> Category</h2></div>
<hr id="id_home">
<ul class="homecatmenu">
    <?php //foreach ($categories as $category){ ?>  
    <li class=""> <a class="<?=($category_id==$category['category_id'])?'active':''?>" href="<?=$category['href']?>"><?=$category['name']?> <i class="fa fa-angle-right"></i></a> </li>
    <?php //} ?>
    
</ul>-->

<div class="cathead"><h2><i class="fa fa-list-ul"></i> Suppliers and Manufacturers</h2></div>
<hr id="id_home">
<ul class="homecatmenu">
    <li class=""> <a class="" href="<?=$cms_supplier_promote_link;?>"><?="Why should I be a supplier on The Level Market?";?> <i class="fa fa-angle-right"></i></a> </li>
    <li class=""> <a class="" href="<?=$cms_supplier_membership_link;?>"><?="Supplier Membership plans";?> <i class="fa fa-angle-right"></i></a> </li>
    <li class=""> <a class="" href="<?=$cms_supplier_membership_link;?>"><?="Create Supplier Account"?> <i class="fa fa-angle-right"></i></a> </li>
</ul>

<?php  //($category_id==$category['category_id'])?'active':''?>
<?php 
//if(count($categories)>5){
//<a href="#">ALL CATEGORIES <i class="fa fa-angle-double-right"></i></a>
?>

<?php // } ?>



