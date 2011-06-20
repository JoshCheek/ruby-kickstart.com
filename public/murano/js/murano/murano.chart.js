murano.chart = function ()
{
	var pub = {};
	var self = {};
	
	pub.draw = function ()
	{
		self.drawChart ();
		self.tooltip ();
			
		return false;
	}
	self.drawChart = function ()
	{
		var visitor = [];
	    visitor.push([1, 3500]);
	    visitor.push([2, 3000]);
	    visitor.push([3, 5000]);
	    visitor.push([4, 8200]);
	    visitor.push([5, 6700]);
	    visitor.push([6, 7100]);
	    visitor.push([7, 7800]);
	    visitor.push([8, 5700]);
	    visitor.push([9, 7000]);
	    visitor.push([10, 6200]);
	    visitor.push([11, 7000]);
	    visitor.push([12, 9100]);
	    var plot = $.plot($("#placeholder"), [{
	        data: visitor,
	        label: "Visitors"
	    }], {
	        series: {
	            lines: {
	                show: true
	            },
	            points: {
	                show: true
	            }
	        },
	        grid: {
	            hoverable: true,
	            clickable: true
	        },
	        yaxis: {
	            min: 500,
	            max: 12000
	        },
	        legend: {
	            show: false
	        },
	        xaxis: {
	            mode: null,
	            ticks: [
	                [1, "Jan"],
	                [2, "Feb"],
	                [3, "Mar"],
	                [4, "Apr"],
	                [5, "May"],
	                [6, "Jun"],
	                [7, "Jul"],
	                [8, "Aug"],
	                [9, "Sep"],
	                [10, "Oct"],
	                [11, "Nov"],
	                [12, "Dec"]
	            ]
	        },
	        lines: {
	            show: true,
	            fill: 0.5
	        }
	    });		
		return false;	
	}
	
	self.tooltip = function ()
	{
	    function showTooltip(x, y, contents) {
	        $('<div id="tooltip">' + contents + '</div>').css({
	            position: 'absolute',
	            display: 'none',
	            top: y - 30,
	            left: x - 50,
	            border: '1px solid #999',
	            padding: '2px',
	            'background-color': '#EEE',
	            opacity: 0.80
	        }).appendTo("body").fadeIn(200)
	    }
	    var previousPoint = null;
	    $("#placeholder").bind("plothover", function (event, pos, item) {
	        $("#x").text(pos.x.toFixed(2));
	        $("#y").text(pos.y.toFixed(2));
	        if (item) {
	            if (previousPoint != item.datapoint) {
	                previousPoint = item.datapoint;
	                $("#tooltip").remove();
	                var x = item.datapoint[0].toFixed(2),
	                    y = item.datapoint[1].toFixed(2);
	                showTooltip(item.pageX, item.pageY, "&bull; " + y + " " + item.series.label + " &bull;")
	            }
	        } else {
	            $("#tooltip").remove();
	            previousPoint = null
	        }
	    });			
	}
	
	return pub;	
}();


function drawChart ()
{
	


}
