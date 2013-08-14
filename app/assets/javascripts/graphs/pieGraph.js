function drawPieGraph(dataObject) {
  var width = 480,
      height = 250,
      radius = Math.min(width, height) / 2,
      outerRadius = 100;

  var color = d3.scale.category20();

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
      .attr("class", "pie-graph")
    .append("g")
      .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

  data = JSON.parse(dataObject);
  data.forEach(function(d) {
    d.hits = +d.hits;
  }); 
    
  var g = svg.selectAll(".arc")
        .data(pie(data))
      .enter().append("svg:a")
        .attr("xlink:href", function(d) { return d.data.assetLink; })
        .append("svg:g")
          .attr("class", "arc")  
          .attr("d", arc);
  
  g.append("path")
    .attr("d", arc)
    .style("fill", function(d) { return color(d.data.assetName); });   
    
  var pos = d3.svg.arc().innerRadius(radius + 2).outerRadius(radius + 2); 
  var getAngle = function (d) {
      return (180 / Math.PI * (d.startAngle + d.endAngle) / 2 - 90);
  };
  
  g.append("text")
    .attr("transform", function(d) {  return "translate(" + arc.centroid(d) + ")"; })
    /*.attr("transform", function(d) { 
            return "translate(" + pos.centroid(d) + ") " +
                    "rotate(" + getAngle(d) + ")"; }) */
    .attr("dy", 5) 
    .style("text-anchor", "start")
    .style("font", "normal 12px Arial")
    .text(function(d) { return d.data.assetName; });
};