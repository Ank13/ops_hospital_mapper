$(document).ready(function(){


  google.maps.visualRefresh = true;

  var hospitals = $("#hospitals").data("hospitals");
  var map 

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

    map = new google.maps.Map(document.getElementById("map-canvas"),
        mapOptions);

    setMarkers(map, hospitals);
  };

    function setMarkers(map, locations){

      for (var i = 0; i < locations.length; i++) {   
        var hospital = locations[i];
        var iconBase = 'https://googledrive.com/host/0B9bg70URlInBR00zUW9PYnBWLWM/';
        var myLatLng = new google.maps.LatLng(hospital["latitude"], hospital["longitude"]);
        
        var marker = new google.maps.Marker({
          position: myLatLng,
          map: map,
          icon: iconBase + 'h_sign_32x32.png',
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

    function getCircle(size) {
      var circle = {
        path: google.maps.SymbolPath.CIRCLE,
        fillColor: 'red',
        fillOpacity: .4,
        scale: size,
        strokeColor: 'white',
        strokeWeight: .5
      };
      return circle;
    };

    var bubbles = [];

    function setACC(map, locations){
      for (var i = 0; i < locations.length; i++) {   
        var hospital = locations[i];
        var myLatLng = new google.maps.LatLng(hospital["latitude"], hospital["longitude"]);
        var size = hospital["acc"];

        var bubble = new google.maps.Marker({
          position: myLatLng,
          map: map,
          icon: getCircle(size),
          title: hospital["provider_name"],
          zIndex: i
        });
        bubbles.push(bubble);
      };
    };

    function clearOverlays() {
      for (var i = 0; i < bubbles.length; i++ ) {
        bubbles[i].setMap(null);
      }
      bubbles = [];
    };

  $("#acc").on('click', function(){
    var icon = 'ACC'
    setACC(map, hospitals);
  });

  $("#clear").on('click', function(){
    clearOverlays();
  });

  google.maps.event.addDomListener(window, 'load', initialize);


// NAVBAR jQUERY by DANIEL SONG -> NEED TO PUT IN BIGGER FUNCTION 
  $('.about').hide();
  $('.datasets').hide();
  $('.wtfacts').hide();

  $('#about').click(function(e){
    $('.about').slideToggle('400');
    e.stopPropagation();
  });

  $('#datasets').click(function(e){
    $('.datasets').slideToggle('400');
    e.stopPropagation();
  });

  $('#wtfacts').click(function(e){
    $('.wtfacts').slideToggle('400');
    e.stopPropagation();
  });


  $(document).click(function(e){
    $('.about').fadeOut('400');
    $('.datasets').fadeOut('400');
    $('.wtfacts').fadeOut('400');
  });
  

});
