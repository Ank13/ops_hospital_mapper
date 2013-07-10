$(document).ready(function(){
	
	$('.about').hide();
  $('.datasets').hide();
  $('.wtfacts').hide();

  $(document).on('click', '.trigger', function(){
    $(".panel").slideToggle(240); 
    $(this).toggleClass("active");
    if($(this).hasClass("active")) {
      $(this).animate({left: '-=290'}, 240);
      if($('.trigger2').hasClass('active')) {
        $('.trigger2').animate({left: '-=240'}, 240).removeClass('active');
      }
      $('#analytics').hide(240);
      $('.slidepanel').empty().hide(240);
    }
    else {
      $(this).animate({left: '+=290'}, 240);
      $('#analytics').fadeIn(240);
      $('.slidepanel').css('z-index', '1');
    }
    return false;
  });

  function secondTab() {
    $('.trigger2').toggleClass("active");
    if($('.trigger2').hasClass("active")) {
      $('#analytics').animate({left: '+=250'}, 240);
      $('.trigger2').animate({left: '+=240'}, 240);
      $(".slidepanel").css('z-index', '3').show(240);
    } 
    else {
      $('#analytics').animate({left: '-=250'}, 240);
      $('.trigger2').animate({left: '-=240'}, 240);
      $(".slidepanel").hide(240);
    }
    return false;
  };

  function triggerStaticPages(link, page) {
    $(link).click(function(e) {
      if($(".trigger2").hasClass("active")) {
        $('.slidepanel').empty();
        $($(page).html()).appendTo('.slidepanel');
        $('.slidepanel').css('z-index', '3').show(240);
        e.stopPropagation();
      }
      else {
        $('.slidepanel').empty();
        $($(page).html()).appendTo('.slidepanel');
        if(!$('.slidepanel').hasClass('active')) {
          $('#analytics').animate({left: '+=250'}, 240);
          $('.trigger2').addClass('active').animate({left: '+=240'}, 240);
        }
        $('.slidepanel').css('z-index', '3').show(240);
        e.stopPropagation();
      }
    });
  }

  triggerStaticPages('#wtfacts', '.wtfacts');
  triggerStaticPages('#datasets', '.datasets');
  triggerStaticPages('#about', '.about');

  $(document).bind('click', function() {
    if($('.trigger2').hasClass('active')) {
      $('.trigger2').removeClass('active').animate({
        left: "-=240"
      }, 240);
      $('.slidepanel').removeClass('active').empty().hide(240);
    }
  });
});


