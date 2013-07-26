//add onclick functionality to the facet bar
function add_facet_click_action() {
$(".twiddle").click(function(e) {
	toggle_chart(e.target);
});

};

function toggle_chart(node) {
	//If the facet was opened, draw the piechart
	if ($(node).hasClass("twiddle-open")) {
		var parent = $(node).parent();
		var JsonObj = formatForGraph(parent);
		piechart(JsonObj);
	}
	//If the facet was closed, clear the graph
	else {
		clearCharts();
	}
};


function formatForGraph(node) {

	var facetName = ($(node).children().first().text());

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


function clearCharts() {
	$("#d3charts").empty();
};

(function($) {

$(document).ready(function() {
add_facet_click_action();
});
})(jQuery); 