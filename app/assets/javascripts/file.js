$(document).ready(function() {
    $('#file').change(function(evt) {
      var fileName = $(this).val().replace(/\\/g, '/').replace(/.*\//, '');
      $('#chosen-file').val(fileName);
    });
});
