$(document).on('turbolinks:load', function(e) {
  $('form.js-submit-on-change').change(function(event) {
    $(this).submit();
  });
});
