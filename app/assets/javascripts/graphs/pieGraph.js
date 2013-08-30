function renderPieGraph(dataObject) {
  var data = JSON.parse(dataObject);
  
  var width = 400,
      height = 350,
      radius = Math.min(width, height) / 2;
  
  var color = d3.scale.category20c();
  
  var arc = d3.svg.arc()
    .outerRadius(radius - 10)
    .innerRadius(0);
  
  var pie = d3.layout.pie()
    .sort(null)
    .value(function(d) { return d.hits; });
      
  var div = d3.select("#graph").append("div")
    .attr("class", "d3pie")
  
  var svg = d3.select(".d3pie").append("svg")
      .attr("width", width)
      .attr("height", height)
    .append("g")
      .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");
  
  data.forEach(function(d) {
    d.hits = +d.hits;
  });
  
  var g = svg.selectAll(".arc")
      .data(pie(data))
    .enter().append("svg:a")
      .attr("xlink:href", function(d) { return d.data.assetLink; })
      .attr("title", function(d) { return d.data.assetName; })
      .append("svg:g")
        .attr("class", "arc")
        .attr("d", arc);
  
  g.append("path")
    .attr("d", arc)
    .style("fill", function(d) { return color(d.data.assetName); });
    
  var legend = d3.select(".d3pie").append("svg")
      .attr("class", "legend")
      .attr("width", 200)
      .attr("height", radius * 2)
      .style("right", width * 3)
    .selectAll("g") 
      .data(data, function(d) { return d.assetName; })
    .enter().append("g")
      .attr("transform", function(d, i) { return "translate(0," + i * 22 + ")"; });

  legend.append("rect")
    .attr("class", "d3legend-key")
    .attr("width", 18)
    .attr("height", 18)
    .on("click", function(d) { window.location.href = d.assetLink; })
    .style('fill', function(d) { return color(d.assetName); });

  legend.append("text")
    .attr("x", 24)
    .attr("y", 9)
    .attr("dy", ".35em")
    .style("font", "normal 12px Arial")
    .text(function(d) { return d.assetName; }); 
}