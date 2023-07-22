
$(function() {
    $('.menu-trigger').click(function(event) {
        $(this).toggleClass('active');
        $('#hamburger').fadeToggle();
        event.preventDefault();
  });
});