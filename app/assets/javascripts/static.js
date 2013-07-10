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
        $('.trigger2').animate({left: '-=240'}, 120).removeClass('active');
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

  $(".trigger2").click(secondTab());

  function secondTab() {
    $('.trigger2').toggleClass("active");
    if($('.trigger2').hasClass("active")) {
      $('#analytics').animate({left: '+=250'}, 120);
      $('.trigger2').animate({left: '+=240'}, 120);
      $(".slidepanel").css('z-index', '3').show("fast");
    } 
    else {
      $('#analytics').animate({left: '-=250'}, 120);
      $('.trigger2').animate({left: '-=240'}, 120);
      $(".slidepanel").hide("fast");
    }
    return false;
  };

  function triggerStaticPages(link, page) {
    $(link).click(function(e) {
      if($(".trigger2").hasClass("active")) {
        $('.slidepanel').empty();
        $($(page).html()).appendTo('.slidepanel');
        $('.slidepanel').css('z-index', '3').show("fast");
        e.stopPropagation();
      }
      else {
        $($(page).html()).appendTo('.slidepanel');
        $('#analytics').animate({left: '+=250'}, 120);
        $('.trigger2').addClass('active').animate({left: '+=240'}, 120);
        $('.slidepanel').css('z-index', '3').show("fast");
        e.stopPropagation();
      }
    });
  }

  triggerStaticPages('#wtfacts', '.wtfacts');
  triggerStaticPages('#datasets', '.datasets');
  triggerStaticPages('#about', '.about');

  $(document).click(function() {
    if($('.trigger2').hasClass('active')) {
      $('.trigger2').removeClass('active').animate({
        left: "-=240"
      }, 120);
      $('.slidepanel').empty().hide();
    }
  });

});


