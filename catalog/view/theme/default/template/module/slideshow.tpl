<div class="home-slideshow">  
<div id="slideshow<?php echo $module; ?>" class="owl-carousel slide-image" style="opacity: 1;">
  <?php foreach ($banners as $banner) { ?>
  <div class="item">
    <?php if ($banner['link']) { ?>
    <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a>
    <?php } else { ?>
    <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" />
    <?php } ?>
  </div>
  <?php } ?>
</div>
</div>   
<?php
if(count($banners)>1) {
?>
<script type="text/javascript">
/*$('#slideshow<?php echo $module; ?>').owlCarousel({
	autoPlay: 5000,
        transitionStyle:"fade",
	singleItem: true,
	navigation: false,
	navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],
	pagination: false
         var time = 7; // time in seconds */
    
var time = 7; // time in seconds 
var $progressBar,
$bar,
$elem,
isPause,
tick,
percentTime;
 
//Init the carousel
$("#slideshow<?php echo $module; ?>").owlCarousel({
slideSpeed : 500,
paginationSpeed : 500,
transitionStyle:"fade",
singleItem : true,
pagination: false,
afterInit : progressBar,
afterMove : moved,
startDragging : pauseOnDragging
});
 
//Init progressBar where elem is $("#owl-demo")
function progressBar(elem){
$elem = elem;
//build progress bar elements
buildProgressBar();
//start counting
start();
}
 
//create div#progressBar and div#bar then prepend to $("#owl-demo")
function buildProgressBar(){
$progressBar = $("<div>",{
id:"progressBar"
});
$bar = $("<div>",{
id:"bar"
});
$progressBar.append($bar).prependTo($elem);
}
 
function start() {
//reset timer
percentTime = 0;
isPause = false;
//run interval every 0.01 second
tick = setInterval(interval, 10);
};
 
function interval() {
if(isPause === false){
percentTime += 1 / time;
$bar.css({
width: percentTime+"%"
});
//if percentTime is equal or greater than 100
if(percentTime >= 100){
//slide to next item
$elem.trigger('owl.next')
}
}
}
 
//pause while dragging
function pauseOnDragging(){
isPause = true;
}
 
//moved callback
function moved(){
//clear interval
clearTimeout(tick);
//start again
start();
}
        

</script>
<?php } ?>