function add_tab_action() {
$('.tab').click(function(e) {
	tab_view(e.target);
});

};


function tab_view(node) {
	display_off();
	display_tab(node);

};

function display_off() {
	$('#right-bar').children().each(function(){
		$(this).addClass("hide");
	});
};

function display_tab(node) {
	var open_tab = $(node).attr('class');
	$('#'+open_tab).toggleClass("hide");
}


(function($) {

	$(document).ready(function() {
	add_tab_action();
});

})(jQuery);