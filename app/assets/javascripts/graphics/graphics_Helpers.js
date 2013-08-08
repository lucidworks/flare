//Draw or close the charts when toggled
function toggle_graph(node) {
	/*If the facet was clicked on, clear all other charts and
	close other	open facets */
	clearCharts();
	var tab_container = $(".facet_limit");
	$.each( tab_container, function() {
		if ($(this).children(":first") != $(node))
			$(this).children(":first").removeClass("twiddle-open");
	});

	/* If the facet was opened, call the appropriate AJAX call */

	if ($(node).hasClass("twiddle-open")) {
		ajax_route(node);
	};
};


//Graph type is assigned here
//	To add new graphs, add the appropriate d3 graph in the graphics folder
//	And add a new item to the drop down menu, following this format
function graphRoute(jsonObj) {
	var graphType = $("#active_graph_type").child().value;
	if (graphType == "bar")
		drawBarGraph(jsonObj);
	else (graphType == "pie")
		drawPieGraph(jsonObj);
};


//deletes all charts in #d3charts
//Ideally this should take in a node and delete just the chart associated
//with that node
function clearCharts() {
	$("#d3charts").empty();
};


//This should re-draw the graph if there is one displayed
//But should do nothing if the graph is not present

function update_Graph() {
	return true;
}


