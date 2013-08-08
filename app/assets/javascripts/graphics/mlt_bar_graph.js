
//Add onclick function for the AJAX link
function addBarToggle() {
$('#AJAX-info').click(function(e) {
	drawBarGraph(e.target);
});
};

//This calls the bar graph function
//Ideally node should be where you want to draw the graph
//    but right now graph defaults to #d3charts
function drawBarGraph(node) {
	
	var jsonObj = ajax_query();
};


(function($) {

	$(document).ready(function() {
	addBarToggle();
});

})(jQuery);