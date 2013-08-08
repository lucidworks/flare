//This should re-draw the graph if there is one displayed
//But should do nothing if the graph is not present

function update_Graph() {
	return true;
}


//Graph type is assigned here
//	To add new graphs, add the appropriate d3 graph in the graphics folder
//	And add a new item to the drop down menu, following this format
function graphRoute(jsonObj) {
	var graphType = $("#graphTypeDD").value;
	if (graphType == "bar")
		drawBarGraph(jsonObj);
	else (graphType == "pie")
		drawPieGraph(jsonObj);
};