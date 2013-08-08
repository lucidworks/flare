/* Functionality to be built... right now just calls the one ajax
query already built.  Should call a specific ajax call based on the
value of the drop down selected */

function ajax_route(node) {
	var ajax_Type = $("#active_graph_info").text();
	/*
	Some logic/routing here
	*/
	ajax_Facet_Count(node);
};




//Performs an ajax call with the current query with moreLikeThis tags on
//This query should be really customizable/extensible to
//	build custom calls
function ajax_Facet_Count(node) {
	var query = getQuery();
	var queryString = "http://localhost:8888/solr/lucid/?q=" + query + "&wt=json&json.wrf=?&indent=true";
	return $.getJSON(queryString, function(result) {
		var facet_Name = $(node).parent().attr('class').split(/\s+/)[2];
		var facet_Name = facet_Name.substring(11);
		var facet_Count = result.face_counts.$(facet_Name)
		formatJSON(facet_Count);
	});		//TODO: Test this!!!
};
//Known issue: This performs all the action in the anonymous function
//Ideally this would just return the jquery object from the ajax call
//And be manipulatable


//Pulls URL and finds a substring from 'q=' to a & or end of string
//Also will take off a '#' if it is on the end of a string
//	This should really get the query term from w/in the ruby/internal code
function getQuery() {
	var fullURL = window.location.href.toString();

	//finds where query starts
	var qIndexStart = fullURL.search("q=") + 2;

	//finds where query ends, either at a '&' or end of url
	var qIndexEnd = fullURL.substring(qIndexStart, fullURL.length).search("&");
	if (qIndexEnd == -1)
		qIndexEnd = fullURL.length;

	//Pulls off a # from the end of the query string
	if (fullURL.match("#$"))
		qIndexEnd = qIndexEnd - 1;
	var query = fullURL.substring(qIndexStart, qIndexEnd);

	//replaces +'s with spaces for multi-word queries
	query = query.replace("+", " ");
	return query;
};