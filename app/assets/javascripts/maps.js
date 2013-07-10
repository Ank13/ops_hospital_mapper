$(document).ready(function(){
  google.maps.visualRefresh = true;

  var map;
  var existingHospitals = $.parseJSON($("#hospitals").attr('data-hospitals'));

  function initialize() {

    map = createMap();

    var input = (document.getElementById('target'));
    var searchBox = new google.maps.places.SearchBox(input);
    var markers = [];

    google.maps.event.addListener(searchBox, 'places_changed', placeChanged);
    google.maps.event.addListener(map, 'bounds_changed', scheduleDelayedCallback);

    function fireIfLastEvent()
     {
      if (lastEvent.getTime() + 500 <= new Date().getTime()) {
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

    function placeChanged() {
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
    }
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
    };
  };

  var infowindow = null;

  function clickMarker(hospital, marker){

    google.maps.event.addListener(marker, 'click', function() {
      if (infowindow) {
        infowindow.close();
      }
      infowindow = new google.maps.InfoWindow({
        maxWidth: 500,
        Height: 600
      });

      hospitalID = hospital['provider_id'];
      var url =  '/hospitals/'+hospitalID; 
      $.get(url, function(response){
        infowindow.setContent(response);
      });
      infowindow.open(map, this);
    });
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
  var readmission = [];
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
          "http://chart.googleapis.com/chart?chst=d_text_outline&chld=FFF|22|h|8C0800|b|$"+price+" k",
          null, null, new google.maps.Point(-17, 42))
      });
      priceTags.push(marker);
      bubbles.push(marker);
    }
  };

  function setIcons(map, locations, icon, fill_color, stroke_color, iconArray) {
    for (var i = 0; i < locations.length; i++) {
      var hospital = locations[i];
      var size = hospital[icon];
      var bubble = new Bubble(hospital["latitude"],hospital["longitude"], fill_color, stroke_color, size+' score for '+icon+' at '+ hospital["provider_name"], size);
      var marker = bubble.addToMap(map);
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

        setIcons(map, existingHospitals, type, color, strokecolor, givenArray);
      }
      else {
        clearIcons(givenArray);
      }
    });
  };

  toggleIcons('a#acc', 'acc', '#236905', acc);
  toggleIcons('a#thumbs_up', 'thumbs_up', '#EEF000', thumbsUp);
  toggleIcons('a#thumbs_down', 'thumbs_down', '#F04400', thumbsDown);
  toggleIcons('a#readmission', 'readmission', '#50F0F2', readmission);
  toggleIcons('a#mortality', 'mortality', '#515151', mortality);

  $("a#clear").on('click', function(){
    $('a#acc i').removeClass('active');
    $('a#thumbs_up i').removeClass('active');
    $('a#thumbs_down i').removeClass('active');
    $('a#readmission i').removeClass('active');
    $('a#mortality i').removeClass('active');
    clearOverlays();
  });

  google.maps.event.addDomListener(window, 'load', initialize);

});

