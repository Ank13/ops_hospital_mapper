$(document).ready(function() {
	for(var i=0; i < collection.length; i++) {
		changeColorWhenMouse(collection[i]['div'], collection[i]['icon'], collection[i]['color']);
	}
	changeClearIconColorOnHover();

	function changeColorWhenMouse(div, icon, color) {
		$(div).on("click", function() {
			$(this).toggleClass('active');
			if($(this).hasClass('active')) {
				$(icon).css('color', color);
			}
			else {
				$(icon).css('color', '#183152');
			}
		});
		$('.clearAll').click(function() {
			$(div).removeClass('active');
			$(icon).css('color', '#183152');
		});
	};

	function changeClearIconColorOnHover() {
		$('.clearAll').mouseover(function() {
			$('.icon-ban-circle').css('color', '#444');
		});
		$('.clearAll').mouseout(function() {
			$('.icon-ban-circle').css('color', '#183152');
		});
	};
});

var collection = [
	{div: '.acc', icon: '.icon-tag', color: '#236905'},
	{div: '.th-up', icon: '.icon-thumbs-up', color: '#EEF000'},
	{div: '.th-down', icon: '.icon-thumbs-down', color: '#F04400'},
	{div: '.amb', icon: '.icon-ambulance', color: '#70070A'},
	{div: '.ghost', icon: '.icon-frown', color: 'purple'},
];
