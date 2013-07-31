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
	var formattedJSON = formatForBarGraph(jsonObj)
	barGraph(jsonObj);
	};
};


//takes in unformatted JSON and extracts the info you want to graph
//This will be the part you want to customize/build off of
function formatForBarGraph(uJSON) {

	var JsonObj = new Object();
	JsonObj = [];
	var dataParent = $(node).children().last();

	dataParent.children('li').each(function() {
		var facet_name = $(this).children().first().text();
		var facet_value = $(this).children().last().text();
		var x = {}
		x.facetName = facet_name;
		x.hits = facet_value;
		JsonObj.push(x);
	})
	JsonObj = JSON.stringify(JsonObj);
	return JsonObj;
};

	//for (var key in mlt) {
	//	var valueTest = jsonObj.moreLikeThis[key].numFound;
	//	$('#ajax-div').append(valueTest + " ");


(function($) {

	$(document).ready(function() {
	addBarToggle();
});

})(jQuery);