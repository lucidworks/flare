//add onclick functionality to the facet bar
function add_facet_click_action() {
$(".twiddle").click(function(e) {
	toggle_chart(e.target);
});

};

//Draw or close the charts when toggled
function toggle_chart(node) {
	//If the facet was opened, draw the piechart
	if ($(node).hasClass("twiddle-open")) {
		var parent = $(node).parent();
		var JsonObj = formatForPieGraph(parent);
		pieGraph(JsonObj);
	}
	//If the facet was closed, clear the graph
	else {
		clearCharts();
	}
};

//This is the area to change how the information is fed into the graph
//This is where you will customize/build off from
function formatForPieGraph(node) {

	var facetName = ($(node).children().first().text());

	var JsonObj = new Object();
	JsonObj = [];
	var dataParent = $(node).children().last();

	dataParent.children('li').each(function() {
		var facet_name = $(this).children().first().text();
		var facet_value = $(this).children().last().text();
		var x = {}
		x.assetName = facet_name;
		x.hits = facet_value;
		JsonObj.push(x);
	})
	JsonObj = JSON.stringify(JsonObj);
	return JsonObj;
};

//deletes all charts in #d3charts
//Ideally this should take in a node and delete just the chart associated
//with that node
function clearCharts() {
	$("#d3charts").empty();
};

(function($) {

$(document).ready(function() {
add_facet_click_action();
});
})(jQuery); 