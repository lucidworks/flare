// add onclick functionality to the facet menu
function addFacetSelectionBehavior() {
  $(".twiddle").click(function(e) {
    if ($(this).hasClass("twiddle-open")) {
      setFacetFieldName(e.target);
      renderFacetGraph();  
    } else { 
    	clearGraph();
    }
  });
}

function setFacetFieldName(node) {
	var fieldName = $(node).parent().attr("class").match(/(blacklight-.+)/)[1];
	$("#graph").attr("data-fieldname", fieldName);
};

function setGraphType() {
  $(".graphtype").click(function(e) {
    var graphType = $(this).attr("data-graphtype");
  	$("#graph").attr("data-graphtype", graphType);
  	e.preventDefault();
  	
  	renderFacetGraph();
  });
};

function renderFacetGraph() {
	var graphType = $("#graph").attr("data-graphtype");
	var fieldName = $("#graph").attr("data-fieldname");
	var field = $("#facets").find("." + fieldName);
	var JsonObj = buildFacetData(field);
	
	clearGraph();
	
	if (field.find('ul').is(":visible")) { 
    switch(graphType) {
      case 'pie': 
        renderPieGraph(JsonObj);
        break;
      case 'bar': 
        renderBarGraph(JsonObj);
        break;
      default: 
        renderPieGraph(JsonObj);
        break;
    }
	} 
};

// build facet data from left sidebar facet list
function buildFacetData(node) {  
	var JsonObj = new Object();
	JsonObj = [];
	var facetList = $(node).find('ul');

	facetList.children('li').each(function() {
	  var x = {}, facetName, facetValue, facetLink;
	  
	  if ($(this).children().first().hasClass("selected")) {
	    facetName  = $(this).find(".selected").contents().filter(function() {
	      return this.nodeType == 3;
	    }).text();
	    facetLink  = $(this).find(".remove").attr('href');
	    facetValue = $(this).find('.selected > .count').text();
	  } else {
  		facetName  = $(this).find(".facet_select").text();
  		facetLink  = $(this).find(".facet_select").attr('href');
  		facetValue = $(this).find('.count').text();
  	}
		
		x.assetName  = facetName;
		x.assetLink  = facetLink;
		x.hits = facetValue;
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