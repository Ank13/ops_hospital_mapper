$(document).ready(function(){
	
	$(".slidepanel").css('z-index', '2').toggle("0");

  $(".trigger2").click(function(){
    $(this).toggleClass("active");
    if($(this).hasClass("active")) {
      $('.analytics').animate({
      	left: '+=14%'
      }, 300);
    } 
    else {
    	$('.analytics').animate({
    		left: '-=14%'
    	}, 300);
    }
    $(".slidepanel").css('z-index', '3').toggle("fast");
    return false;
  });
});

