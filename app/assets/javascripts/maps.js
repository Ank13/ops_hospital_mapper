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
      if (lastEvent.getTime() + 300 <= new Date().getTime()) {
        var bounds = map.getBounds();
        // TODO: Length of a degree of longitude = cos(latitude) * 111.325 kilometers
        var width = (bounds.getNorthEast().kb - bounds.getSouthWest().kb) * 50;
        searchBox.setBounds(bounds);
        var lng = map.getCenter().lng();
        var lat = map.getCenter().lat();
        loadMoreMarkers(lat, lng, width);
      }
    };

    function scheduleDelayedCallback() {
      lastEvent = new Date();
      setTimeout(fireIfLastEvent, 500);
    };    
  };
   
  function loadMoreMarkers(lat, lng, width) {
    var data = {'lat' : lat, 'lng' : lng, 'distance' : width};
    var url =  '/maps/more_markers';
    var moreHospitals = [];

    $.get(url, data, function(response) {
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

        if (!(h.provider_id in hospital_hash_table)) {
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
        zIndex: 100
      });
      
      clickMarker(hospital, marker);

      var infowindow = new google.maps.InfoWindow({
        maxWidth: 500,
      });
    };
  };

  function clickMarker(hospital, marker){
    var infowindow = new google.maps.InfoWindow({
      maxWidth: 500,
      Height: 600
    });
    
    google.maps.event.addListener(marker, 'click', function() {
      hospitalID = hospital['provider_id'];
      var url =  '/hospitals/'+hospitalID; 
      $.get(url, function(response){
        infowindow.setContent(response);
      });
      infowindow.open(map, this);
    });
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

  $('#procdropdown').change(function(event){
    drgDescription = $('#procdropdown').val();
    
    var loadedIDs = []
    for (var i = 0; i < existingHospitals.length; i++) {
      loadedIDs.push(existingHospitals[i].provider_id)
    };

    var data = {'drg' : drgDescription, 'loadedIDs' : loadedIDs };
    var urlPricing = 'procedures/prices'

    $.post(urlPricing, data, function(response){
      setPriceTags(map, response);
    });
  });

  var bubbles = [];
  var acc = [];
  var thumbsUp = [];
  var thumbsDown = [];
  var mortality = [];
  var priceTags = [];

  function setPriceTags(map, locations){
    for (var i=0; i< priceTags.length; i++ ) {
      priceTags[i].setMap(null);
    }

    for (var i = 0; i < locations.length; i++) { 
      var hospital = $.parseJSON(locations[i]);
      var latLng = new google.maps.LatLng(hospital.latitude, hospital.longitude);
      var price = hospital.avg_cost
      var marker = new google.maps.Marker({
        position: latLng,
        map: map,
        icon: new google.maps.MarkerImage(
          "http://chart.googleapis.com/chart?chst=d_text_outline&chld=46E01B|14|h|000000|b|$"+price+" k",
          null, null, new google.maps.Point(0, 42))
      });
      priceTags.push(marker);
      bubbles.push(marker);
    }
  };

  function setIcon(map, locations, icon, color, strokeColor, iconArray) {
    for (var i = 0; i < locations.length; i++) {
      var hospital = locations[i];
      var myLatLng = new google.maps.LatLng(hospital["latitude"], hospital["longitude"]);
      var size = hospital[icon];

      var marker = new google.maps.Marker({
        position: myLatLng,
        map: map,
        icon: getCircle(size, color, strokeColor),
        title: hospital["provider_name"],
        zIndex: 3
      });
      bubbles.push(marker);
      iconArray.push(marker);
      clickMarker(hospital, marker);
    };  
  };

  function clearIcons(markerset) {
    for (var i=0; i<markerset.length; i++) {
      markerset[i].setMap(null);
    }
    markerset = [];
  };

  function clearOverlays() {
    for (var i = 0; i < bubbles.length; i++ ) {
      bubbles[i].setMap(null);
    }
    bubbles = [];
  };

  function toggleIcons(cssSelector, givenType, givenColor, givenArray) {  
    $(cssSelector).on('click', function() {
      $(this).toggleClass('active');
      if($(this).hasClass('active')) {
        var type = givenType;
        var color = strokecolor = givenColor;
        setIcon(map, existingHospitals, type, color, strokecolor, givenArray);
      }
      else {
        clearIcons(givenArray);
      }
    });
  };

  toggleIcons('a#acc i', 'acc', '#236905', acc);
  toggleIcons('a#thumbs_up i', 'thumbs_up', '#EEF000', thumbsUp);
  toggleIcons('a#thumbs_down i', 'thumbs_down', '#F04400', thumbsDown);
  toggleIcons('a#mortality i', 'mortality', '#515151', mortality);

  $("a#clear").on('click', function(){
    $('a#acc i').removeClass('active');
    $('a#thumbs_up i').removeClass('active');
    $('a#thumbs_down i').removeClass('active');
    $('a#mortality i').removeClass('active');
    clearOverlays();
  });

  google.maps.event.addDomListener(window, 'load', initialize);

});

