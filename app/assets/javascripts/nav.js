$(document).ready(function() {

	$('.static').hide();
  $('.about').hide();
  $('.datasets').hide();
  $('.wtfacts').hide();

  $('#about').click(function(e){
  	$('.static').empty();
    $($('.about').html()).appendTo('.static');
    $('.static').css('z-index', '3').fadeIn(300);;
    e.stopPropagation();
  });

  $('#datasets').click(function(e){
    $('.static').empty();
    $($('.datasets').html()).appendTo('.static');
    $('.static').css('z-index', '3').fadeIn(300);;
    e.stopPropagation();
  });

  $('#wtfacts').click(function(e){
  	$('.static').empty();
    $($('.wtfacts').html()).appendTo('.static');
    $('.static').css('z-index', '3').fadeIn(300);;
    e.stopPropagation();
  });

  $(document).click(function(e){
    $('.static').fadeOut(200);
  });
});
