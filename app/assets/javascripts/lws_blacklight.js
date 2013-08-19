function addDropdownSelectedBehavior() {
  $(".dropdown-menu li a").click(function() {
    var selText = $(this).text();
    $(this).parents('.btn-group').find('.dropdown-toggle').html(selText+'<span class="caret"></span>');
  });
}

function addToggleButtonBehavior() {
  $(".btn-toggle").click(function(e) {
    e.preventDefault();
  });
}
  
(function($) {
  $(document).ready(function() {
    addDropdownSelectedBehavior();
    addToggleButtonBehavior();
  });
})(jQuery); 