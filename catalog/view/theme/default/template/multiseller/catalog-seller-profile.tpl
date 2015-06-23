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
    <div class="cathead"><h2> <?php echo $seller['company']; ?></h2></div>
    <hr>
    <div class="main-content" >
            <div class="rte custome_seller_detail">
                <table width="100%">
                    <tbody>
                        <tr>
                            <td><?=$ms_title_mission?></td>
                            <td><?=$seller['description']?></td>
                        </tr>
                        <tr>
                            <td><?=$ms_h_address?></td>
                            <td><p><?php echo $seller['street']; ?>, <?php echo $seller['city']; ?></p>
                                <p><?php echo $seller['zone']; ?>, <?php echo $seller['country']; ?></p>

                        </tr>
                        <tr>
                            <td>Website</td>
                            <td><p><a href="<?=$seller['website']?>" title="" target="_blank"><?=$seller['website']?></a></p>
                        </tr>
                        <?php
                        $array_leardes = array();
                        if($seller['leader_ship']!=""){
                        $array_leardes = json_decode($seller['leader_ship'],true);
                        }
                        ?>
                        <tr>
                            <td><?=$ms_leadership?></td>
                            <td>
                                
                                <?php
                                if(!empty($array_leardes)) { ?>
                                <table class=""  style="width: 100%;">
                                    <tr>
                                        <td class="" style="width: 20%;"><?=$ms_lp_name?></td>
                                        <td class="" style="width: 20%;"><?=$ms_lp_address?></td>
                                        <td class="" style="width: 80%;"><?=$ms_lp_nature?></td>
                                    </tr>
                                
                                <?php 
                                for($ind = 0; $ind<count($array_leardes); $ind++) {
                                ?>
                                 <tr>
                                        <td class="col-md-3"><?=$array_leardes[$ind]['first_name']?></td>
                                        <td class="col-md-3"><?=$array_leardes[$ind]['last_name']?></td>
                                        <td class="col-md-6"><?=$array_leardes[$ind]['title']?></td>
                                    </tr>
                                
                               
                                <?php }?>
                                </table>
                                <?php }?> 
                            </td>
                        </tr>
                        <?php
                        $array_contacts = array();
                        if($seller['authorized_contact']!=""){
                        $array_contacts = json_decode($seller['authorized_contact'],true);
                        }
                        
                        ?>
                        <?php 
                        if(!empty($array_contacts)) {
                        ?>
                        <tr>
                            <td><?=$ms_contact_title?></td>
                            <td>
                                <table class="" style="width: 100%;">
                                    <tr>
                                        <td class="" style="width: 25%;"><?=$ms_lp_name?></td>
                                        <td class="" style="width: 25%;"><?=$ms_contact_position?></td>
                                        <td class="" style="width: 25%;"><?=$ms_lp_phone?></td>
                                        <td class="" style="width: 25%;"><?=$ms_entry_email?></td>
                                    </tr>
                                    <?php 
                                    for($ind = 0; $ind<count($array_contacts); $ind++) {
                                    ?>
                                     <tr>
                                        <td class=""><?=$array_contacts[$ind]['name']?></td>
                                        <td class=""><?=$array_contacts[$ind]['position']?></td>
                                        <td class=""><?=$array_contacts[$ind]['phone']?></td>
                                        <td class=""><?=$array_contacts[$ind]['email']?></td>
                                    </tr>
                                     <?php }?>
                                 </table>   
                                </td>
                        </tr>
                        <?php } ?>
                        <tr>
                            <td><?=$ms_category_title?></td>
                            <td><?=$seller['category']?></td>
                        </tr>

                        <tr>
                            <td><?=$ms_org_title?></td>
                            <td><?=$seller['organization_type']?></td>
                        </tr>
                        <tr>
                            <td><?=$ms_revenue?></td>
                            <td><p> <?=$seller['revenue']?></p>
                        </tr>
                        <tr>
                            <td><?=$ms_countries?></td>
                            <td><?=$seller['countries']?></td>
                        </tr>
                        <tr>
                            <td><?=$ms_ship_title?></td>
                            <td><?=$seller['shipping_type']?></td>
                        </tr>


                        <tr>
                            <td><?=$ms_membership_title?></td>
                            <td><?=$seller['membership_type']?> </td>
                        </tr>
                        <tr>
                            <td><?=str_replace(', if applicable','',$ms_refrences_title)?></td>
                            <td><?=($seller['dunn_number']!="")?$ms_refrences_dunn.' : '.$seller['dunn_number'] :''?>
                                <?=($seller['eid']!="")?'<br/>'.$ms_refrences_employee.' : '.$seller['eid'] :''?> </td>
                        </tr>
                        
                        <?php 
                        if($seller['moq']!="") {
                        ?>
                        <tr>
                            <td><span data-toggle="tooltip"  data-original-title="<?=$ms_moq_title?>" ><?=$ms_moq?></span></td>
                            <td><?=$seller['moq']?> </td>
                        </tr>
                        <?php } ?>
                        
                         <?php 
                        if($seller['moq']!="") {
                        ?>
                        <tr>
                            <td><?=$ms_factory_time?></td>
                            <td><?=$seller['factory_lead_time']?> <?=($seller['factory_lead_time']>9)?'Days':'Day'?> </td>
                        </tr>
                        <?php } ?>
                        
                         <?php 
                        if($seller['warranty_option']=="Yes") {
                        ?>
                        <tr>
                            <td><?=$ms_warranty?></td>
                            <td><?=$seller['warranty_des']?> </td>
                        </tr>
                        <?php } ?>
                        
                        
                        <?php
                        $avg = 0;
                        $total = count($seller['products']);
                        $sum = 0;
                        if(!empty($seller['products'])){
                        foreach ($seller['products'] as $products) {
                        $sum = $sum +  $products['rating'];

                        }
                        }
                        if($total>0){
                        $avg = intval($sum/$total);
                        }else {
                        $avg = 0;
                        }
                        ?>
                        <tr >
                            <td><?=$ms_rating?></td>
                            <td><?php for ($i = 1; $i <= 5; $i++) { ?>
                                <?php if ($avg < $i) { ?>
                                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                                <?php } else { ?>
                                <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                                <?php } ?>
                                <?php } ?></td>
                        </tr>

                    </tbody>
                </table>

                <br /> 
                <?php
                $geocode=file_get_contents('http://maps.google.com/maps/api/geocode/json?address=United+States&sensor=false');
                $output= json_decode($geocode);
                $lat = $output->results[0]->geometry->location->lat;
                $long = $output->results[0]->geometry->location->lng;

                $all_countries = array();
                $map_array = '';
                if(!empty($seller['countries'])){
                $all_countries = explode(',',$seller['countries']);
                }
                if(!empty($all_countries)) {
                foreach ($all_countries as $k=>$v) {
                $address = str_replace(' ','+',$v);	
                $geocode=file_get_contents('http://maps.google.com/maps/api/geocode/json?address='.$address.'&sensor=false');
                $output= json_decode($geocode);
                $lat = $output->results[0]->geometry->location->lat;
                $long = $output->results[0]->geometry->location->lng;	

                $map_array .= "['<h4>".$v."</h4>', ".$lat.", ".$long."],";
                }
                }

                ?>
                <div>
                    <div id="map_canvas" style="width: 70%; height:316px;margin:auto "></div>
                </div> 
                <br /> 
                <div class='col-md-12' style="text-align: center">
                    <?php  if ($this->customer->getId()) { ?>
                    <a href="<?=$this->url->link('product/product/quote')?>"><input class="btn btn-primary" type="button" value="<?=$this->config->get('config_btn_supplier_enq')?>"></a>
                    <?php } else { ?>
                    <a href="javascript:void(0)" onclick="javascript:alert('<?=$alert_login?>')" ><input class="btn btn-primary" type="button" value="<?=$this->config->get('config_btn_supplier_enq')?>"></a>
                    <?php } ?>
                    <a href="<?php echo $seller['href']; ?>" class="">
                        <input class="btn btn-primary" type="button" value="<?php echo $ms_catalog_seller_profile_view_products; ?>">
                    </a>
                </div>

            </div>
        </div>
    </div>
    </div>
    </div>
    </div>


<script src="http://maps.google.com/maps/api/js?sensor=false"></script>

<script type="text/javascript">
            // Define your locations: HTML content for the info window, latitude, longitude
            var locations = [
                    <?=$map_array?>
            ];
            // Setup the different icons and shadows
            var iconURLPrefix = 'http://maps.google.com/mapfiles/ms/icons/';
            var icons = [
                    iconURLPrefix + 'red-dot.png',
            ]
            var icons_length = icons.length;
            var shadow = {
            anchor: new google.maps.Point(15, 33),
                    url: iconURLPrefix + 'msmarker.shadow.png'
            };
            var map = new google.maps.Map(document.getElementById('map_canvas'), {
            zoom: 0,
                    center: new google.maps.LatLng( <?=$lat?> , <?=$long?> ),
                    mapTypeControl: false,
                    streetViewControl: false,
                    panControl: false,
                    zoomControlOptions: {
                    position: google.maps.ControlPosition.LEFT_BOTTOM
                    }
            });
            var infowindow = new google.maps.InfoWindow({
            maxWidth: 460
            });
            var marker;
            var markers = new Array();
            var iconCounter = 0;
            // Add the markers and infowindows to the map
            for (var i = 0; i < locations.length; i++) {
    marker = new google.maps.Marker({
    position: new google.maps.LatLng(locations[i][1], locations[i][2]),
            map: map,
            icon : icons[iconCounter],
            shadow: shadow
    });
            markers.push(marker);
            google.maps.event.addListener(marker, 'click', (function(marker, i) {
            return function() {
            infowindow.setContent(locations[i][0]);
                    infowindow.open(map, marker);
            }
            })(marker, i));
            iconCounter++;
            // We only have a limited number of possible icon colors, so we may have to restart the counter
            if (iconCounter >= icons_length){
    iconCounter = 0;
    }
    }

    function AutoCenter() {
    //  Create a new viewpoint bound
    var bounds = new google.maps.LatLngBounds();
            //  Go through each...
            $.each(markers, function (index, marker) {
            bounds.extend(marker.position);
            });
            //  Fit these bounds to the map
            map.fitBounds(bounds);
    }
    AutoCenter();
</script>
<?php echo $footer; ?>
