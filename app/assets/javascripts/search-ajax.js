var searchFunction = function (htmlElement, tableBody) {
  $('body').css('cursor', 'progress');
  var htmlElement = $(htmlElement);
  var filterType = htmlElement.data("filter");
  var input = { filters: [ [filterType, htmlElement.text()]] };
  // data[:filters].concat([filterType, htmlElement]);
  var tableBody = tableBody;
  $.ajax({
    type: "GET",
    url: "/search_filter",
    data: input,
    success: function(data) {
      var resources = data["resources"];
      var newHtml = "";
      debugger;
      for(var i = 0; i < resources.length; i++) {
        newHtml += "<tr>";
        newHtml += "<a href='/resources/" + resources[i]["id"] +"'>";
        newHtml += "<td>" + resources[i]["title"] + "</td>";
        newHtml += "</a>";
        if (resources["world_region"]) {
          newHtml += "<td>";
          newHtml += resource["world_region"];
          newHtml += "</td>";
        }
        newHtml += "</tr>";
      }
    },
    error: function(data) {

    },
    complete: function(data) {
      $('body').css('cursor', 'default');
    }
  });
};