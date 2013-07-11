function Bubble(lat,lng, fill_color, stroke_color, title, size){
  this.latlng = new google.maps.LatLng(lat, lng);
  this.fill_color = fill_color;
  this.stroke_color = stroke_color;
  this.title = title;
  this.size = size;
}

Bubble.prototype = {
	addToMap: function(map){
     var marker = new google.maps.Marker({
     	 position: this.latlng,
     	 map: map,
     	 icon: this.makeCircle(this.size, this.fill_color, this.stroke_color),
     	 title: this.title,
     	 zIndex: 100
     });
	  return marker;
	},
	makeCircle: function(size, fill_color, stroke_color){
    var circle = {
        path: google.maps.SymbolPath.CIRCLE,
        fillColor: fill_color,
        fillOpacity: 0.4 * size/30,
        scale: size,
        strokeColor: stroke_color,
        strokeWeight: 1
      };
      return circle;
	  },
  };




