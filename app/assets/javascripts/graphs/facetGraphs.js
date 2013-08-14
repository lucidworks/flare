// add onclick functionality to the facet menu
function addFacetSelectionBehavior() {
  $(".twiddle").click(function(e) {
    setFacetFieldName(e.target);
  	drawFacetGraph();
  });
}

function setFacetFieldName(node) {
	var fieldName = $(node).parent().attr("class").match(/(blacklight-.+)/)[1];
	$("#graph").attr("data-fieldname", fieldName);
};

function setGraphType() {
  $(".graphtype").click(function(e) {
  	e.preventDefault();
  	$("#graph").attr("data-graphtype", $(this).attr("data-graphtype"));
  	
  	drawFacetGraph();
  });
};

function drawFacetGraph() {
	clearGraph();
	
	var graphType = $("#graph").attr("data-graphtype");
	var fieldName = $("#graph").attr("data-fieldname");
	var field = $("#facets").find("." + fieldName);
	
	if (field.find('ul').is(":visible")) { 
    switch(graphType) {
      case 'pie': 
        var JsonObj = buildFacetData(field);
        drawPieGraph(JsonObj);
        break;
      case 'bar': 
        var JsonObj = buildFacetData(field);
        drawBarGraph(JsonObj);
        break;
      default: 
        var JsonObj = buildFacetData(field);
        drawPieGraph(JsonObj);
        break;
    }
	} 
};

// build facet data from left sidebar facet list
function buildFacetData(node) {  
	var facetName = ($(node).children().first().text());

	var JsonObj = new Object();
	JsonObj = [];
	var facetList = $(node).find('ul');

	facetList.children('li').each(function() {
		var facet_name = $(this).find('.facet_select').text();
		var facet_link = $(this).find('.facet_select').attr('href');
		var facet_value = $(this).find('.count').text();
		
		var x = {}
		x.assetName = facet_name;
		x.assetLink = facet_link;
		x.hits = facet_value;
		JsonObj.push(x);
	});
	
	JsonObj = JSON.stringify(JsonObj);
	return JsonObj;
};

// delete graphs
function clearGraph() {
	$("#graph").empty();
};

(function($) {
  $(document).ready(function() {
    addFacetSelectionBehavior();
    setGraphType();
  });
})(jQuery); 