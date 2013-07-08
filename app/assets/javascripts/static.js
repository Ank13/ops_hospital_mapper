$(document).ready(function(){
	
	$('.about').hide();
  $('.datasets').hide();
  $('.wtfacts').hide();
  
	$(".slidepanel").css('z-index', '1');

  $(document).on('click', '.trigger', function(){
    $(".panel").slideToggle("fast"); 
    $(this).toggleClass("active");
    if($(this).hasClass("active")) {
      $('#searchby').animate({
          left: '-=6%'
      }, 300);
      $('#analytics').css({top: '21.3%', left : '12.1%'});
      $('#analytics').hide();
      $('.slidepanel').empty().hide();
    }
    else {
      $('.searchby').animate({
        left: '+=6%'
      }, 300);
      $('#analytics').fadeIn(500);
      $('.slidepanel').css('z-index', '1').show();
    }
    return false;
  });

  $(".trigger2").click(function(){
    $(this).toggleClass("active");
    if($(this).hasClass("active")) {
      $('.analytics').animate({left: '+=14%'}, 300);
      $(this).animate({left: '+=13%'}, 300);
      $(".slidepanel").css('z-index', '3').show("fast");
    } 
    else {
      $('.analytics').animate({left: '-=14%'}, 300);
      $(this).animate({left: '-=13%'}, 300);
      $(".slidepanel").hide("fast");
    }
    return false;
  });

  $('#about').click(function(e){
    if($(".trigger2").hasClass("active")) {
      $('.slidepanel').empty();
      $($('.about').html()).appendTo('.slidepanel');
      $('.slidepanel').css('z-index', '3').show("fast");
      e.stopPropagation();
    }
    else {
      $($('.about').html()).appendTo('.slidepanel');
      $('.analytics').animate({left: '+=14%'}, 300);
      $('.trigger2').addClass('active').animate({left: '+=13%'}, 300);
      $('.slidepanel').css('z-index', '3').show("fast");
      e.stopPropagation();
    }
  });

  $('#datasets').click(function(e){
    if($(".trigger2").hasClass("active")) {
      $('.slidepanel').empty();
      $($('.datasets').html()).appendTo('.slidepanel');
      $('.slidepanel').css('z-index', '3').show("fast");
      e.stopPropagation();
    }  
    else {
      $($('.datasets').html()).appendTo('.slidepanel');
      $('.analytics').animate({left: '+=14%'}, 300);
      $('.trigger2').addClass('active').animate({left: '+=13%'}, 300);
      $('.slidepanel').css('z-index', '3').show("fast");
      e.stopPropagation();
    }
  });

  $('#wtfacts').click(function(e){
    if($(".trigger2").hasClass("active")) {
      $('.slidepanel').empty();
      $($('.wtfacts').html()).appendTo('.slidepanel');
      $('.slidepanel').css('z-index', '3').show("fast)");
      e.stopPropagation();
    }  
    else {
      $($('.wtfacts').html()).appendTo('.slidepanel');
      $('.analytics').animate({left: '+=14%'}, 300);
      $('.trigger2').addClass('active').animate({left: '+=13%'}, 300);
      $('.slidepanel').css('z-index', '3').show("fast");
      e.stopPropagation();
    }
  });
});


