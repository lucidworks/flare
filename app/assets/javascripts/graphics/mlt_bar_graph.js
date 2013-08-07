
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


//takes in unformatted JSON and extracts the info you want to graph
//This will be the part you want to customize/build off of
function formatForBarGraph(uJSON) {

	var JsonObj = new Object();
	JsonObj = [];
	var mlt = uJSON.moreLikeThis;
	var keyName, numHits = "";

	for( var key in mlt) {
		keyName = key;
		numHits = mlt[key].numFound;
		var x = {};
		x.assetName = keyName;
		x.hits = numHits;
		JsonObj.push(x);
	}

	JsonObj = JSON.stringify(JsonObj);
	barGraph(JsonObj);
};

	//for (var key in mlt) {
	//	var valueTest = jsonObj.moreLikeThis[key].numFound;
	//	$('#ajax-div').append(valueTest + " ");


(function($) {

	$(document).ready(function() {
	addBarToggle();
});

})(jQuery);