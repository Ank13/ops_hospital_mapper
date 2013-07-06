$(document).ready(function(){
    $(".trigger").click(function(){
        $(".panel").toggle("fast");
        $(this).toggleClass("active");
        return false;
    });
});
