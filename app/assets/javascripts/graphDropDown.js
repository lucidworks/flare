function graph_drop_down_toggle() {
$('.graph_drop_down_option').click(function(e) {
	update_drop_down(e);
	update_Graph();
});

};


function update_drop_down(e) {
	var node = e.target;
	var changeText = $("#active_graph_type").children(":first");
	$(changeText).text( $(node).text() );
	var parent = $(node).parent();
	e.stopPropagation();
};


(function($) {

	$(document).ready(function() {
	graph_drop_down_toggle();
});

})(jQuery);