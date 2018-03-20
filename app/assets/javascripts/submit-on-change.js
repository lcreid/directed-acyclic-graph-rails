$(document).on('turbolinks:load', function(e) {
  console.log('turbolinks:load');
  $('form.js-submit-on-change').change(function(event) {
    console.log('Form auto-submitting');
    // $("body").prepend('<div class="spinner"></div>');
    // console.log('Spinner shown');
    // $(document).ajaxComplete(function(e){
      // console.log('Complete');
      // $(".spinner").remove();
    // });
    $(this).submit();
  });
});
