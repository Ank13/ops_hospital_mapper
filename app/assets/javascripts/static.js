$(document).ready(function(){
	
	$('.about').hide();
  $('.datasets').hide();
  $('.wtfacts').hide();

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

  $('#about').click(function(e){
  	$('.slidepanel').empty();
  	$($('.about').html()).appendTo('.static');
  	$('.slidepanel').css('z-index', '3').fadeIn(300);
  	e.stopPropagation();
  });

});


  // $('#about').click(function(e){
  // 	$('.static').empty();
  //   $($('.about').html()).appendTo('.static');
  //   $('.static').css('z-index', '3').fadeIn(300);;
  //   e.stopPropagation();
  // });

  // $('#datasets').click(function(e){
  //   $('.static').empty();
  //   $($('.datasets').html()).appendTo('.static');
  //   $('.static').css('z-index', '3').fadeIn(300);;
  //   e.stopPropagation();
  // });

  // $('#wtfacts').click(function(e){
  // 	$('.static').empty();
  //   $($('.wtfacts').html()).appendTo('.static');
  //   $('.static').css('z-index', '3').fadeIn(300);;
  //   e.stopPropagation();
  // });

  // $(document).click(function(e){
  //   $('.static').fadeOut(200);
  // });
