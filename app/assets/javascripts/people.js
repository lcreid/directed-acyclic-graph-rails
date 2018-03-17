// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('turbolinks:load', function() {
  // console.log('about to register handlers');
  $('form').on('click', '.remove_fields', function(event) {
    // console.log('start removing fields');
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('fieldset').hide();
    event.preventDefault();
    // console.log('done removing fields');
  });

  $('form').on('click', '.add_fields', function(event) {
    // console.log('start adding fields');
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    event.preventDefault();
    // console.log('done adding fields');
  });

  // $('form').on('click', '.clicker', function(event) {
    // console.log('Click');
    // event.preventDefault();
  // });

  // console.log('done registering handlers');
  // console.log('Print nodes');
  // $.each($('.add_fields'), function(i, v) { console.log(v); });
  // $.each($('a'), function(i, v) { console.log(v); });
  // console.log('Did I print any nodes?');
  // console.log('do some clicks');
  // $('.add_fields').click();
  // $('.remove_fields').click();
});
