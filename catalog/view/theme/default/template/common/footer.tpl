<div id="footer">
      	<div class="container">
        	<div class="row">
            	<div class="col-md-12">
                    <div class="col-md-6 socialicons">
                        <?php echo $powered; ?> <?php if($config_footer_tag!="") { ?> <?=$config_footer_tag?> <?php } ?>
                        <?php if($config_social_facebook!=""){ ?> 
                        <a href="<?=$config_social_facebook?>" target="_blank"  class="fa fa-facebook"></a>
                        <?php } ?>
                        <?php if($config_social_twitter!=""){ ?>
                        <a href="<?=$config_social_twitter?>" target="_blank" class="fa fa-twitter"></a>
                        <?php } ?>
                         <?php if($config_social_linkedin!=""){ ?>
                        <a href="<?=$config_social_linkedin?>" target="_blank" class="fa fa-linkedin"></a>
                        <?php } ?>
                        <?php if($config_social_wordpress!=""){ ?>
                        <a href="<?=$config_social_wordpress?>" target="_blank" class="fa fa-wordpress"></a>
                        <?php } ?>
                    </div>
                    <div class="col-md-6 text-right linksurl">
                        
                        <a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a> |
                        <?php
                        $footer_cms = '';
                        foreach ($informations as $info) {
                            $footer_cms .= '<a href="'.$info['href'].'">'.$info['title'].'</a> | ';
                        }
                        $footer_cms .= '<a href="'.$this->url->link('information/promote').'">List your products on TLM</a> | ';
                        $footer_cms  = rtrim($footer_cms,'| ');
                        echo $footer_cms;
                        ?>
                        
                        
                    </div>
                </div>
            </div>
        </div>
      </div>

<script type="text/javascript" src="http://assets.freshdesk.com/widget/freshwidget.js"></script>
<script type="text/javascript">
	FreshWidget.init("", {"queryString": "&widgetType=popup", "utf8": "✓", "widgetType": "popup", "buttonType": "text", "buttonText": "Support", "buttonColor": "white", "buttonBg": "#2A3E51", "alignment": "2", "offset": "300px", "formHeight": "500px", "url": "https://thelevelmarket.freshdesk.com"} );
</script>


<!-- Scripts --> 

<script src="catalog/view/javascript/option_selection.js" type="text/javascript"></script> 
<script src="catalog/view/javascript/plugins.js" type="text/javascript"></script> 
<script src="catalog/view/javascript/theme.js" type="text/javascript"></script>
<script>
    function set_session_custome(flag,link){
        $.post("index.php?route=module/newslettersubscribe/setsession", {flag: flag}, function (data) {
                    var obj = eval(data);
                    if (obj.status == 'success') {
                        window.location = link;
                    }
                }, "json");
        
    }
    $('#btn_submit').click(function (e) {
        

            var flg = 0;
            filter = /^.+@.+\..{2,15}$/;
            if (!(filter.test($.trim($("#newsletter").val())))) {
                alert('Invalid email address');
                if (flg == 0) {
                    $("#newsletter").focus();
                    flg = flg + 1;
                }
            }

            if (flg==0) {
                $.post("index.php?route=module/newslettersubscribe/index", {email: $('#newsletter').val()}, function (data) {
                    var obj = eval(data);
                    if (obj.status == 'success') {
                        alert('You have successfully subscribed');
                        $('#newsletter').val('');
                    }
                }, "json");
            }

        
    });

</script>
</body>
</html>