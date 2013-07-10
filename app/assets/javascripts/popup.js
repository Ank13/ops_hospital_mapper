$(document).ready(function(){
  
  var url = '/maps/popup'
  $.get(url, function(response){
    $('#popup').append(response);
  });

  $(document).on('click', function(){
    $('#popup').text("");
  });

});
