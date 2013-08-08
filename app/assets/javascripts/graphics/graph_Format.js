function formatJSON(uJSON) {
	var JsonObj = new Object();
	JsonObj = [];
	var mlt = uJSON.facet_counts.facet_fields;
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
	graphRoute(JsonObj);
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
	graphRoute(JsonObj);
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
	graphRoute(JsonObj);
};