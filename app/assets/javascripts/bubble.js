function Bubble(lat,lng, fill_color, stroke_color, hospital_name, size){
  this.latlng = new google.maps.LatLng(lat, lng);
  this.fill_color = fill_color;
  this.stroke_color = stroke_color;
  this.hospital_name = hospital_name;
  this.size = size;
}

Bubble.prototype = {
	addToMap: function(map){
     var marker = new google.maps.Marker({
     	 position: this.latlng,
     	 map: map,
     	 icon: this.makeCircle(this.size, this.fill_color, this.stroke_color),
     	 title: this.hospital_name,
     	 zIndex: 100
     });
	  return marker;
	},
	makeCircle: function(size, fill_color, stroke_color){
    var circle = {
        path: google.maps.SymbolPath.CIRCLE,
        fillColor: fill_color,
        fillOpacity: 0.4,
        scale: size,
        strokeColor: stroke_color,
        strokeWeight: 1
      };
      return circle;
	  },
  };




