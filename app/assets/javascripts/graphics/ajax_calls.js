//Performs an ajax call with the current query with moreLikeThis tags on
//This query should be really customizable/extensible to
//	build custom calls
function ajax_query() {
	var query = getQuery();
	var queryString = "http://localhost:8888/solr/lucid/?q=" + query + "&wt=json&json.wrf=?&indent=true&mlt=true&mlt.fl=id,keywords";
	return $.getJSON(queryString, function(result) {
		formatForBarGraph(result);
	});
};	//Known issue: This performs all the action in the anonymous function
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

//To add new graphs, 
function graphRoute(jsonObj) {
	var graphType = $("#graphTypeDD").value;
	if (graphType == "bar")
		formatForBarGraph(jsonObj);
	else (graphType == "pie")
		formatForPieGraph(jsonObj);
};
