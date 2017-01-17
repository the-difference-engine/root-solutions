var search = function (filter, div) {
  $('body').css('cursor', 'progress');
  var div = div;
  var data = {resource_type: filter};
  $.ajax({
    type: "GET",
    url: "/search_filter",
    data: data,
    success: function(data) {
      var resources = data["resources"];
      for(var i = 0; i < resources.length; i++) {
        //insert formated html in a loop here when format exists
      }
    },
    error: function(data) {

    },
    complete: function(data) {
      $('body').css('cursor', 'default');
    }
  });
};