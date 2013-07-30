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
	$('#content').children().each(function(){
		$(this).css('display', 'none');
	});
};

function display_tab(node) {
	var open_tab = $(node).attr('class');
	$('#'+open_tab).css('display','');
}


(function($) {

	$(document).ready(function() {
	add_tab_action();
});

})(jQuery);