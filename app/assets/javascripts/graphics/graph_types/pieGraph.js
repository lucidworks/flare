function pieGraph(dataObject)
{

  var width = 480,
      height = 250,
      radius = Math.min(width, height) / 2;

  var color = d3.scale.ordinal()
      .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

  var arc = d3.svg.arc()
      .outerRadius(radius - 10)
      .innerRadius(0);

  var pie = d3.layout.pie()
      .sort(null)
      .value(function(d) { return d.hits; });

  var div = d3.select("#d3charts").append("div")
      .attr("id", "d3pie")

  var svg = d3.select("#d3pie").append("svg")
      .attr("width", width/2)
      .attr("height", height)
    .append("g")
      .attr("transform", "translate(" + width / 4 + "," + height / 2 + ")");
      //THIS CALL SHOULD TAKE THE JAVASCRIPT DATA ARRAY AND MAKE THE GRAPH
      //NO .csv SHOULD NEED TO BE CALLED

 // d3.json(dataObject, function(error, data) {

  data = JSON.parse(dataObject);

    data.forEach(function(d) {
      d.hits = +d.hits;
    });

    var g = svg.selectAll(".arc")
        .data(pie(data))
      .enter().append("g")
        .attr("class", "arc");

    g.append("path")
        .attr("d", arc)
        .style("fill", function(d) { return color(d.data.facetName); });

    g.append("text")
        .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
        .attr("dy", ".35em")
        .style("text-anchor", "middle")
        .text(function(d) { return d.data.facetName; });
}