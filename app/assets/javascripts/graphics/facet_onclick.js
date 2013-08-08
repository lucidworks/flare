//add onclick functionality to the facet bar
function add_facet_click_action() {
$(".twiddle").click(function(e) {
	toggle_graph(e.target);
});
};


(function($) {

$(document).ready(function() {
add_facet_click_action();
});
})(jQuery); 