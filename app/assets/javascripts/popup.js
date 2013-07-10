$(document).ready(function(){
  
  var url = '/maps/popup'
  $.get(url, function(response){
    $('#popup').append(response);
  });



});
