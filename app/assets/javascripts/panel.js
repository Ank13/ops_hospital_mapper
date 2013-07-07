$(document).ready(function(){
    $(".trigger").click(function(){
        $(".panel").toggle("fast");
        $(this).toggleClass("active");
        return false;
    });
});

 // $('.details').hide();

 // $(".trigger").click(function(){
 //     $(this).toggleClass("active");

 //     if($(this).class==="active") {
 //     $(".details").toggle("fast");
 //     $(this).animate({
 //       left: '+=150'
 //     });
 //   } else {
 //     $(".details").toggle("fast");
 //     $(this).animate({
 //       left: '-=150'
 //     })
 //   }

 //     return false;
 // });