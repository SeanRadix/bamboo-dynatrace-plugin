<head>
    <meta name="tab" content="DTTestAutomationOverview"/>
</head>
<body>
<script src="${req.contextPath}/download/resources/be.sofico.bamboo.plugins.bamboo-dynatrace-plugin:bamboo-dynatrace-plugin-resources/d3.v3.js"></script>
<h1>Test Automation</h1>
<div id="chartContainer">

</div>

    <script type="text/javascript">
        (function(){

var data = [{build:"43", Degrading:"5", Volatile:"25", Improved:"10", Passing:"59", Invalidated:"1"}, 
            {build:"44", Degrading:"10", Volatile:"30", Improved:"0", Passing:"60", Invalidated:"0"}, 
            {build:"45", Degrading:"15", Volatile:"15", Improved:"20", Passing:"50", Invalidated:"0"},
            {build:"46", Degrading:"15", Volatile:"15", Improved:"20", Passing:"50", Invalidated:"0"},
            {build:"47", Degrading:"5", Volatile:"25", Improved:"10", Passing:"59", Invalidated:"1"},
            {build:"48", Degrading:"10", Volatile:"30", Improved:"0", Passing:"60", Invalidated:"0"}
            ];
            
// Width of the svg canvas
var canvasWidth = AJS.$("#chartContainer").width();

var margin = {top: 20, right: 20, bottom: 30, left: 50};
var width = canvasWidth*0.8;
var height = 400 - margin.top - margin.bottom;

var formatPercent = d3.format(".0%");
var formatBuild = d3.format("9999");

var x = d3.time.scale()
    .range([0, width]);

var y = d3.scale.linear()
    .range([height, 0]);

var color = d3.scale.category20();

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom")
    .tickFormat(formatBuild);

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left")
    .tickFormat(formatPercent);

var area = d3.svg.area()
    .x(function(d) { return x(d.build); })
    .y0(function(d) { return y(d.y0); })
    .y1(function(d) { return y(d.y0 + d.y); });

var stack = d3.layout.stack()
    .values(function(d) { return d.values; });
    
drawLegend();

var svg = d3.select("#chartContainer").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
    
	

/* d3.tsv("data.csv", function(error, data) {
  color.domain(d3.keys(data[0]).filter(function(key) { return key !== "date"; }));

  data.forEach(function(d) {
    d.date = parseDate(d.date);
  }); */
  
  color.domain(d3.keys(data[0]).filter(function(key) { return key !== "build"; })).range(["orange","yellow","lightgreen", "green", "gainsboro"]);

  var browsers = stack(color.domain().map(function(name) {
    return {
      name: name,
      values: data.map(function(d) {
        return {build: d.build, y: d[name] / 100};
      })
    };
  }));

  x.domain(d3.extent(data, function(d) { return d.build; }));

  var browser = svg.selectAll(".browser")
      .data(browsers)
    .enter().append("g")
      .attr("class", "browser");

  browser.append("path")
      .attr("class", "area")
      .attr("d", function(d) { return area(d.values); })
      .style("fill", function(d) { return color(d.name); });

  browser.append("text")
      .datum(function(d) { return {name: d.name, value: d.values[d.values.length - 1]}; })
      .attr("transform", function(d) { return "translate(" + x(d.value.build) + "," + y(d.value.y0 + d.value.y / 2) + ")"; })
      .attr("x", -6)
      .attr("dy", ".35em");

  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis);

        })();
        
  function drawLegend() {
  
  	var margin = {top: 20, right: 20, bottom: 30, left: 50};
  	var height = 500 - margin.top - margin.bottom;
  	var legendHeight = 50;
	var legendWidth = 200;
  	var canvasWidth = AJS.$("#chartContainer").width();
  	
        var legend = d3.select("#chartContainer").append("svg")
                .attr("class", "chart")
                .attr("id", "legend")
                .attr("width", canvasWidth)
                .attr("height", legendHeight)
                .attr("style", "padding-top: 35px; padding-left: 35px; padding-bottom: 15px");

        var styles = ["orange", "yellow", "lightgreen", "green", "gainsboro"]
        var labels = {"orange":"Degrading", "yellow":"Volatile", "lightgreen": "Improved", "green":"Passing", "gainsboro":"Invalidated"};

        //Draw Legend
        legend.append("rect")
                .attr("y", 0)
                .attr("x", 0)
                .attr("width", 1310)
                .attr("height", legendHeight)
                .attr("style", "fill:#fff; stroke:#000");

        legend.selectAll("rect.legend")
                .data(styles)
                .enter().append("rect")
                .attr("y", 10)
                .attr("width", 60)
                .attr("height", 30)
                .attr("style", function(d,i){return "fill:" + styles[i];})
                .attr("x", function(d,i) {return 10 + 260*i});

        legend.selectAll("text.legend")
                .data(styles)
                .enter().append("text")
                .attr("y", 10 + 20)
                .attr("x", function(d,i) {return 75 + 260*i})
                .attr("text-anchor", "start")
                .text(function(d,i) {return labels[d];});




    }

    </script>

</body>