$(document).ready(function(){
  $(".trigger").click(function(){
    $(".panel").toggle("fast");
    $(this).toggleClass("active");
    if($(this).hasClass("active")) {
    	$('.searchby').animate({
    		left: '-=14%'
    	}, 300);
    	$('.analytics').hide();
    }
    else {
    	$('.searchby').animate({
    		left: '+=14%'
    	}, 300);
    	$('.analytics').fadeIn(500);
  	}
    return false;
  });
});

