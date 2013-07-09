$(document).ready(function(){
	
	$('.about').hide();
  $('.datasets').hide();
  $('.wtfacts').hide();

  $(document).on('click', '.trigger', function(){
    $(".panel").slideToggle("fast"); 
    $(this).toggleClass("active");
    if($(this).hasClass("active")) {
      $(this).animate({left: '-=290'}, 300);
      if($('.trigger2').hasClass('active')) {
        $('.trigger2').animate({left: '-=250'}, 300).removeClass('active');
      }
      $('#analytics').hide();
      $('.slidepanel').empty().hide();
    }
    else {
      $(this).animate({left: '+=290'}, 300);
      $('#analytics').fadeIn(500);
      $('.slidepanel').css('z-index', '1');
    }
    return false;
  });

  $(".trigger2").click(function(){
    $(this).toggleClass("active");
    if($(this).hasClass("active")) {
      $('#analytics').animate({left: '+=250'}, 300);
      $(this).animate({left: '+=250'}, 300);
      $(".slidepanel").css('z-index', '3').show("fast");
    } 
    else {
      $('#analytics').animate({left: '-=250'}, 300);
      $(this).animate({left: '-=250'}, 300);
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
      $('#analytics').animate({left: '+=250'}, 300);
      $('.trigger2').addClass('active').animate({left: '+=250'}, 300);
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
      $('#analytics').animate({left: '+=250'}, 300);
      $('.trigger2').addClass('active').animate({left: '+=250'}, 300);
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
      $('#analytics').animate({left: '+=250'}, 300);
      $('.trigger2').addClass('active').animate({left: '+=250'}, 300);
      $('.slidepanel').css('z-index', '3').show("fast");
      e.stopPropagation();
    }
    $(document).click(function() {
      if($('.trigger2').hasClass('active')) {
        $('.trigger2').removeClass('active').animate({
          left: "-=250"
        });
        $('.slidepanel').empty().hide();
      }
    });
  });
});


