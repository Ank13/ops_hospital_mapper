$(document).ready(function(){
  google.maps.visualRefresh = true;

  // var hospitals = $("#hospitals").data("hospitals");
  var map;

  function initialize() {
    var styles = [
        {
          stylers: [
            { hue: "#375D81" }
          ]
        },{
          featureType: "road",
          elementType: "geometry",
          stylers: [
            { lightness: 100 },
            { visibility: "simplified" }
          ]
        },{
          featureType: "road",
          elementType: "labels",
          stylers: [
            { visibility: "off" }
          ]
        },{
          featureType: "administrative.neighborhood",
          elementType: "labels",
          stylers: [
            {visibility: "simplified"}
          ]
        },{
          featureType: "landscape",
          elementType: "all",
          stylers: [
            { visibility: "simplified" }
          ]
        },{
          featureType: "poi",
          elementType: "all",
          stylers: [
            { visibility: "off" }
          ]
        },{
          featureType: "transit",
          elementType: "all",
          stylers: [
            { visibility: "simplified" }
          ]
        }
      ];

      var styledMap = new google.maps.StyledMapType(styles,
        {name: "Styled Map"});

    var mapOptions = {
      // center: new google.maps.LatLng(41.8500, -87.8500),
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

    // setMarkers(map, hospitals);

    map.mapTypes.set('map_style', styledMap);
    map.setMapTypeId('map_style');

    var defaultBounds = new google.maps.LatLngBounds(
        new google.maps.LatLng(41.7700, -87.9000),
        new google.maps.LatLng(41.9900, -87.5500));
    map.fitBounds(defaultBounds);

    var input = (document.getElementById('target'));
    var searchBox = new google.maps.places.SearchBox(input);
    // var markers = [];

    google.maps.event.addListener(searchBox, 'places_changed', function() {
      var places = searchBox.getPlaces();

      for (var i = 0, marker; marker = markers[i]; i++) {
        marker.setMap(null);
      };

      markers = [];
      var bounds = new google.maps.LatLngBounds();
      for (var i = 0, place; place = places[i]; i++) {
        var image = {
          url: place.icon,
          size: new google.maps.Size(71, 71),
          origin: new google.maps.Point(0, 0),
          anchor: new google.maps.Point(17, 34),
          scaledSize: new google.maps.Size(25, 25)
        };

        var gMarker = new google.maps.Marker({
          map: map,
          icon: image,
          title: place.name,
          position: place.geometry.location
        });

        markers.push(gMarker);

        bounds.extend(place.geometry.location);
      }

      map.fitBounds(bounds);
    });

    google.maps.event.addListener(map, 'bounds_changed', function() {
      var bounds = map.getBounds();
      searchBox.setBounds(bounds);
      var lng = map.getCenter().lng();
      var lat = map.getCenter().lat();
      loadMoreMarkers(lat, lng);
    });
  };
  
  requestcount = 0;
  responsecount = 0;
   
    function loadMoreMarkers(lat, lng){
      var data = {'lat' : lat, 'lng' : lng, 'distance' : 5};
      var url =  '/maps/more_markers';
      var moreHospitals = [];

      $.get(url, data, function(response){
        for (var i = 0; i < response.length; i++) {
          moreHospitals.push(response[i]);
        };
        setMarkers(map, moreHospitals);

        var existingHospitals = $.parseJSON($("#hospitals").attr('data-hospitals'));
        var hospital_hash_table = {};
        var allHospitals = existingHospitals;

        for (var i = 0; i < existingHospitals.length; i++) {
          hospital_hash_table[existingHospitals[i].provider_id] = true;
        }

        for (var i = 0; i < moreHospitals.length; i++) {
          var h = moreHospitals[i];

          if ( ! (h.provider_id in hospital_hash_table)) {
            allHospitals.push(h);
          }
        }
        $("#hospitals").attr('data-hospitals', JSON.stringify(allHospitals));
      });
    };

    function setMarkers(map, locations){

      var iconBase = 'https://googledrive.com/host/0B9bg70URlInBR00zUW9PYnBWLWM/';
        
      for (var i = 0; i < locations.length; i++) {   
        var hospital = locations[i];
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

});

