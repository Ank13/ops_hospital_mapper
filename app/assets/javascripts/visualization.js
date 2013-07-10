$(document).ready(function() {
	changeColorWhenHover('.acc', '.icon-tag', '#236905');
	changeColorWhenHover('.th-up', '.icon-thumbs-up', '#EEF000')
	changeColorWhenHover('.th-down', '.icon-thumbs-down', '#F04400')
	changeColorWhenHover('.amb', '.icon-ambulance', '#70070A')
	changeColorWhenHover('.ghost', '.icon-frown', 'purple')
	changeColorWhenHover('.clearAll', '.icon-ban-circle', '#444')
});

function changeColorWhenHover(div, icon, color) {
	$(div).mouseover(function() {
		$(icon).css('color', color);
	});
	$(div).mouseout(function() {
		$(icon).css('color', '#183152');
	});
}