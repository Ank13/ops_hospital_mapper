function createMap() {
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
	return map;
}