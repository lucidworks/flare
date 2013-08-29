function addDropdownSelectionBehavior() {
  $('.dropdown-menu.select li a').click(function() {
    var selText = $(this).text();
    $(this).parents('.btn-group').find('.dropdown-toggle').html(selText+'<span class="caret"></span>');
  });
}

function addToggleButtonBehavior() {
  $('.btn-toggle').click(function(e) {
    e.preventDefault();
  });
}

function addViewSelectionBehavior() {
  var currentView = localStorage.getItem('view');
  
  $("#view-tabs > li").each(function() {
    if ($(this).find(".btn-view").attr("data-view") == currentView) {
      $('#view-tabs a[href="#view-' + currentView + '"]').tab('show')
    } 
  });
  
  $('.btn-view').click(function(e) {
    var view = $(this).attr("data-view");
    localStorage.setItem('view', view);
    
    e.preventDefault();
  });
}

function addCollapseBehavior() {
  $('.accordion').on('show', function (e) { 
    $(e.target).parent('.accordion-group').addClass('active');
    $(e.target).prev().find(".accordion-toggle").removeClass('collapsed'); // fix bootstrap 2.3.2 bug
  });

  $('.accordion').on('hide', function (e) {
    $(this).find('.accordion-group').removeClass('active');
    $(this).find('.accordion-toggle').addClass('collapsed'); // fix bootstrap 2.3.2 bug
  });
}
  
(function($) {
  $(document).ready(function() {
    addDropdownSelectionBehavior();
    addToggleButtonBehavior();
    addViewSelectionBehavior();
    addCollapseBehavior();
  });
})(jQuery); 