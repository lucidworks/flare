function add_ajax_action() {
$('#AJAX-info').click(function(e) {
	ajax_query(e.target);
});
}


function ajax_query(node) {
	var query = getQuery();
	$.getJSON("http://localhost:8888/solr/lucid/?q=" + query + "&wt=json&json.wrf=?&indent=true&mlt=true&mlt.fl=id,keywords", function(result) {
		callGraph(result, node);
	})
};


function getQuery() {
	var fullURL = window.location.href.toString();
	var qIndexStart = fullURL.search("q=") + 2;
	var qIndexEnd = fullURL.substring(qIndexStart, fullURL.length).search("&");
	if (qIndexEnd == -1)
		qIndexEnd = fullURL.length;
	var query = fullURL.substring(qIndexStart, qIndexEnd);
	query = query.replace("+", " ");
	return query;
}


function callGraph(jsonObj, node) {
	$('#ajax-div').append(jsonObj.response.numFound);
	$('#ajax-div').append(jsonObj.moreLikeThis.result.numFound)
}


(function($) {

	$(document).ready(function() {
	add_ajax_action();
});

})(jQuery);