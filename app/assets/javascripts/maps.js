$(document).ready(function(){
  google.maps.visualRefresh = true;

  var hospitals = $("#hospitals").data("hospitals");

  function initialize() {
    var mapOptions = {
      center: new google.maps.LatLng(41.8500, -87.8500),
      zoom: 11,
      mapTypeId: google.maps.MapTypeId.TERRAIN,
      panControl: false,
      zoomControl: true,
      zoomControlOptions: {
      style: google.maps.ZoomControlStyle.SMALL,
      position: google.maps.ControlPosition.BOTTOM_RIGHT
      },
      scaleControl: true,
      scaleControlOptions: {
      position: google.maps.ControlPosition.BOTTOM_RIGHT
      }
    };

    var map = new google.maps.Map(document.getElementById("map-canvas"),
        mapOptions);

    setMarkers(map, hospitals)

  };

    function setMarkers(map, locations){
      
      var iconBase = 'https://googledrive.com/host/0B9bg70URlInBR00zUW9PYnBWLWM/';

      var shape = {
      coord: [1, 1, 1, 20, 18, 20, 18 , 1],
      type: 'poly'
      };

      for (var i = 0; i < locations.length; i++) {
        var hospital = locations[i];
        var myLatLng = new google.maps.LatLng(hospital["latitude"], hospital["longitude"]);
        var marker = new google.maps.Marker({
          position: myLatLng,
          map: map,
          icon: iconBase + 'h_sign_32x32.png',
          shape: shape,
          title: hospital["provider_name"],
          zIndex: i
        });
         marker.html = hospital["infobox_html"];

        var infowindow = new google.maps.InfoWindow({
          maxWidth: 400 
        });
   
        google.maps.event.addListener(marker, 'click', function() {
          infowindow.setContent(this.html);
          infowindow.open(map, this);
        });
      };
    };
  google.maps.event.addDomListener(window, 'load', initialize);

});
