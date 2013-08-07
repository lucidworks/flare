//Takes in a JSON object and 
function barGraph(dataObject) {

var margin = {top: 20, right: 20, bottom: 30, left: 40},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

var formatPercent = d3.format(".0%");

var x = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1)
    .domain(function(d) {return d.assetName});

var y = d3.scale.linear()
    .range([height, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom")

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");
   // .tickFormat(formatPercent);

    var div = d3.select("#d3container").append("div")
      .attr("id", "d3bar")

var svg = d3.select("#d3bar").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

//d3.tsv("data.tsv", type, function(error, data) {

  data = JSON.parse(dataObject);

//letter and frequency should be changed to the key and 
//value pair names of the json obj
  x.domain(data.map(function(d) { return d.assetName; }));
  y.domain([0, d3.max(data, function(d) { return d.hits; })]);

  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis)
 /*   .append("text")
      .attr("x", 6)
      .attr("transform", "rotate(-90)")
      .text(function(d) { return xValueName(d); })*/

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      //.attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dy", "-1em")
      //.style("text-anchor", "end")
      .text("Document Relevancy");

  svg.selectAll(".bar")
      .data(data)
    .enter().append("rect")
      .attr("class", "bar")
      .attr("x", function(d) { return x(d.assetName); })
      .attr("width", x.rangeBand())
      .attr("y", function(d) { return y(d.hits); })
      .attr("height", function(d) { return height - y(d.hits); });
}

function type(d) {
  d.hits = +d.hits;
  return d;
}

function xValueName(uName) {
  //Format the name here somehow
  var textVal = "";
  textVal = uName;
  textVal = textVal.substr(10,20);
  return textVal;
}



