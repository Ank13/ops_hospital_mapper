$(document).ready(function(){
  google.maps.visualRefresh = true;

  var map;
  var existingHospitals = $.parseJSON($("#hospitals").attr('data-hospitals'));

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

    map.mapTypes.set('map_style', styledMap);
    map.setMapTypeId('map_style');

    var defaultBounds = new google.maps.LatLngBounds(
        new google.maps.LatLng(41.7700, -87.9000),
        new google.maps.LatLng(41.9900, -87.5500));
    map.fitBounds(defaultBounds);

    var input = (document.getElementById('target'));
    var searchBox = new google.maps.places.SearchBox(input);
    var markers = [];

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

    google.maps.event.addListener(map, 'bounds_changed', scheduleDelayedCallback);

    function fireIfLastEvent()
     {
      if (lastEvent.getTime() + 300 <= new Date().getTime())
        {
          var bounds = map.getBounds();
          // TODO: Length of a degree of longitude = cos(latitude) * 111.325 kilometers
          var width = (bounds.getNorthEast().kb - bounds.getSouthWest().kb) * 50;
          searchBox.setBounds(bounds);
          var lng = map.getCenter().lng();
          var lat = map.getCenter().lat();
          loadMoreMarkers(lat, lng, width);
        }
    };
    function scheduleDelayedCallback()
      {
        lastEvent = new Date();
        setTimeout(fireIfLastEvent, 500);
      };    
  };
   
    function loadMoreMarkers(lat, lng, width){
      var data = {'lat' : lat, 'lng' : lng, 'distance' : width};
      var url =  '/maps/more_markers';
      var moreHospitals = [];

      $.get(url, data, function(response){
        for (var i = 0; i < response.length; i++) {
          moreHospitals.push(response[i]);
        };
        setMarkers(map, moreHospitals);

        existingHospitals = $.parseJSON($("#hospitals").attr('data-hospitals'));
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
          zIndex: 9
        });
        
        marker.html = hospital["infobox_html"];

        var infowindow = new google.maps.InfoWindow({
          maxWidth: 500,
          Height: 600
        });
   
        google.maps.event.addListener(marker, 'click', function() {
          infowindow.setContent(this.html);
          infowindow.open(map, this);
        });

      };
    };

    function getCircle(size, color, stroke_color) {
      var circle = {
        path: google.maps.SymbolPath.CIRCLE,
        fillColor: color,
        fillOpacity: .4,
        scale: size,
        strokeColor: stroke_color,
        strokeWeight: 1
      };
      return circle;
    };

    var bubbles = [];

    function setACC(map, locations){

      for (var i = 0; i < locations.length; i++) {   
        var hospital = locations[i];
        var myLatLng = new google.maps.LatLng(hospital["latitude"], hospital["longitude"]);
        var size = hospital["acc"];
        var color = '#236905';
        var stroke_color = '#236905';

        var bubble = new google.maps.Marker({
          position: myLatLng,
          map: map,
          icon: getCircle(size, color, stroke_color),
          title: hospital["provider_name"],
          zIndex: 3
        });
        bubbles.push(bubble);
      };
    };

    function setThumbsUp(map, locations){
      for (var i = 0; i < locations.length; i++) {   
        var hospital = locations[i];
        var myLatLng = new google.maps.LatLng(hospital["latitude"], hospital["longitude"]);
        var size = hospital["thumbs_up"];
        var color = '#EEF000';
        var stroke_color = '#EEF000'

        var bubble = new google.maps.Marker({
          position: myLatLng,
          map: map,
          icon: getCircle(size, color, stroke_color),
          title: hospital["provider_name"],
          zIndex: 2
        });
        bubbles.push(bubble);
      };
    };

    function setThumbsDown(map, locations){
      for (var i = 0; i < locations.length; i++) {   
        var hospital = locations[i];
        var myLatLng = new google.maps.LatLng(hospital["latitude"], hospital["longitude"]);
        var size = hospital["thumbs_down"];
        var color = '#F04400';
        var stroke_color = '#F04400'

        var bubble = new google.maps.Marker({
          position: myLatLng,
          map: map,
          icon: getCircle(size, color, stroke_color),
          title: hospital["provider_name"],
          zIndex: 4
        });
        bubbles.push(bubble);
      };
    };

    function setMortality(map, locations){
      for (var i = 0; i < locations.length; i++) {   
        var hospital = locations[i];
        var myLatLng = new google.maps.LatLng(hospital["latitude"], hospital["longitude"]);
        var size = hospital["mortality"];
        var color = '#515151';
        var stroke_color = '#515151'

        var bubble = new google.maps.Marker({
          position: myLatLng,
          map: map,
          icon: getCircle(size, color, stroke_color),
          title: hospital["provider_name"],
          zIndex: 5
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

  $("a#acc i").on('click', function(){
    $(this).toggleClass('active');
    if($(this).hasClass('active')) {
      var icon = 'ACC';
      setACC(map, existingHospitals);
    }
    else {
      clearOverlays();
    }
  });

  $("a#thumbs_up i").on('click', function(){
    $(this).toggleClass('active');
    if($(this).hasClass('active')) {
      var icon = 'TH';
      setThumbsUp(map, existingHospitals);
    }
    else {
      clearOverlays();
    }
  });

  $("a#thumbs_down i").on('click', function(){
    $(this).toggleClass('active');
    if($(this).hasClass('active')) {
      var icon = 'th-down';
      setThumbsDown(map, existingHospitals);
    }
    else {
      clearOverlays();
    }
  });

  $("a#mortality i").on('click', function(){
    $(this).toggleClass('active');
    if($(this).hasClass('active')) {
      var icon = 'frown';
      setMortality(map, existingHospitals);
    }
    else {
      clearOverlays();
    }
  });

  google.maps.event.addDomListener(window, 'load', initialize);

});

