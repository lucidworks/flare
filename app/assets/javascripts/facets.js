function addFacetSelectionBehavior() {
  $('.facets-toggle').click(function(e) {
    if ($(this).hasClass('collapsed')) {
      setFacetFieldName(e.target);
      renderFacetGraph(); 
      localStorage.setItem('facets-group', $(this).attr('href')); 
    } else {
      $('#graph-msg').show(); 
    	clearGraph();
    	$('#graph').attr("data-fieldname", '');
    	localStorage.setItem('facets-group', '');
    }
  });
}

function setFacetGroupActive() {
  var activeFacetGroup = localStorage.getItem('facets-group');
  
  if (activeFacetGroup) {
    $(activeFacetGroup).addClass('in');
    $(activeFacetGroup).prev().find('.accordion-toggle').removeClass('collapsed');
    $(activeFacetGroup).parents('.facets-group').addClass('active');
    setFacetFieldName($(activeFacetGroup).prev().find('.accordion-toggle'));
    renderFacetGraph();
  }
}

function setFacetFieldName(node) {
	var fieldName = $(node).attr('href').match(/^#(.+)/)[1];
	$('#graph').attr('data-fieldname', fieldName);
}

function setGraphType() {
  $('.graphtype').click(function(e) {
    var graphType = $(this).attr('data-graphtype');
  	$('#graph').attr('data-graphtype', graphType);
  	e.preventDefault();
  	renderFacetGraph();
  });
}

function renderFacetGraph() {
	var graphType = $('#graph').attr('data-graphtype');
	var fieldName = $('#graph').attr('data-fieldname');
	var fieldList = $('#facets').find('#' + fieldName).find('.list-facets');
	var JsonObj = buildFacetData(fieldList);
	
	if ($.isEmptyObject(JsonObj)) { 
	  $('#graph-msg').removeClass('alert-info').text('No graph data available');
	} else if (fieldName) {
	  $('#graph-msg').hide();
  	clearGraph();
  	
  	if (fieldList.is(':visible')) { 
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
  }
}

// build facet data from left sidebar facet list
function buildFacetData(node) {  
	var JsonObj = new Object();
	JsonObj = [];

	$(node).children('li').each(function() {
	  var x = {}, facetName, facetValue, facetLink;
	  
	  if ($(this).hasClass('selected')) {
	    facetName  = $(this).children().first().contents().filter(function() {
	      return this.nodeType == 3;
	    }).text();
	    facetLink  = $(this).find('.remove').attr('href');
	    facetValue = $(this).find('.count').text();
	  } else {
  		facetName  = $(this).find('.facet_select').text();
  		facetLink  = $(this).find('.facet_select').attr('href');
  		facetValue = $(this).find('.count').text();
  	}
		
		x.assetName  = facetName;
		x.assetLink  = facetLink;
		x.hits = facetValue;
		JsonObj.push(x);
	});
	
	JsonObj = JSON.stringify(JsonObj);
	return JsonObj;
}

// delete graphs
function clearGraph() {
	$('#graph').empty();
}

(function($) {
  $(document).ready(function() {
    addFacetSelectionBehavior();
    setFacetGroupActive();
    setGraphType();
  });
})(jQuery); 