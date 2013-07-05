$(document).ready(function(){

  function initialize() {
    var mapOptions = {
      center: new google.maps.LatLng(41.8500, -87.8500),
      zoom: 11,
      mapTypeId: google.maps.MapTypeId.TERRAIN
    };

    var map = new google.maps.Map(document.getElementById("map-canvas"),
        mapOptions);

    setMarkers(map, hospitals)

  };

  // TODO: Read this in from database
    var hospitals = [
      ['DBC', 41.889911, -87.637657, 3, "DBC content"],
      ["Children's", 41.874186, -87.668502, 1, "Children's content"],
      ['Northwestern', 41.908165, -87.648534, 2, "Northwestern content"]
    ];

    function setMarkers(map, locations){
      
      var iconBase = 'https://maps.google.com/mapfiles/kml/shapes/';

      var shape = {
      coord: [1, 1, 1, 20, 18, 20, 18 , 1],
      type: 'poly'
      };

      for (var i = 0; i < locations.length; i++) {
        var hospital = locations[i];
        var myLatLng = new google.maps.LatLng(hospital[1], hospital[2]);
        var marker = new google.maps.Marker({
          position: myLatLng,
          map: map,
          icon: iconBase + 'hospitals_maps.png',
          shape: shape,
          title: hospital[0],
          zIndex: hospital[3]
        });
         marker.html = hospital[4];

        var infowindow = new google.maps.InfoWindow({
          maxWidth: 200 
        });
   
        google.maps.event.addListener(marker, 'click', function() {
          infowindow.setContent(this.html);
          infowindow.open(map, this);
        });
      };
    };
  google.maps.event.addDomListener(window, 'load', initialize);

});
