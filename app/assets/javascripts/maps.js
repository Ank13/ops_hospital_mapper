$(document).ready(function(){
  
  function initialize() {
    var mapOptions = {
      center: new google.maps.LatLng(41.8500, -87.8500),
      zoom: 11,
      mapTypeId: google.maps.MapTypeId.TERRAIN
    };
    var map = new google.maps.Map(document.getElementById("map-canvas"),
        mapOptions);
    };

  google.maps.event.addDomListener(window, 'load', initialize);

});
