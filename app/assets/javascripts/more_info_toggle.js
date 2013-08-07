function add_info_toggle() {
$('.link-expand').click(function(e) {
	toggle_info(e.target);
});

};


function toggle_info(node) {
	var parent = $(node).parent();
	parent.children(":last").children(":first").toggleClass("hide");

	if ($(node).text() == "Less")
    	$(node).text("More");
    else
    	$(node).text("Less");
};


(function($) {

	$(document).ready(function() {
	add_info_toggle();
});

})(jQuery);