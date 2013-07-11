$(document).ready(function() {
	for(var i=0; i < collection.length; i++) {
		changeColorWhenHover(collection[i]['div'], collection[i]['icon'], collection[i]['color']);
	}
});

function changeColorWhenHover(div, icon, color) {
	$(div).mouseover(function() {
		$(icon).css('color', color);
	});
	$(div).mouseout(function() {
		$(icon).css('color', '#183152');
	});
}

var collection = [
		{div: '.acc', icon: '.icon-tag', color: '#236905'},
		{div: '.th-up', icon: '.icon-thumbs-up', color: '#EEF000'},
		{div: '.th-down', icon: '.icon-thumbs-down', color: '#F04400'},
		{div: '.amb', icon: '.icon-ambulance', color: '#70070A'},
		{div: '.ghost', icon: '.icon-frown', color: '#515151'},
		{div: '.clearAll', icon: '.icon-ban-circle', color: '#375D81'}
];