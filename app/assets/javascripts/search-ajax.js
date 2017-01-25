var searchFunction = function (htmlElement, tableBody, existingFilters) {
  $('body').css('cursor', 'progress');
  var htmlElement = $(htmlElement);
  var input = {};
  var existingFilters = $(existingFilters);
  existingFilters.each(function(index) {
    input[$(this).data("filter")] = $(this).text();
  });
  input[htmlElement.data("filter")] = htmlElement.text();
  var tableBody = tableBody;
  $.ajax({
    type: "GET",
    url: "/search_filter",
    data: input,
    success: function(data) {
      console.log("ON SUCCESS PATH");
      var resources = data["resources"];
      var newHtml = "";
      for(var i = 0; i < resources.length; i++) {
        newHtml += "<tr>";
        newHtml += "<td>";
        newHtml += "<a href='/resources/" + resources[i]["id"] +"'>";
        if (resources[i]["title"]) {
          newHtml += resources[i]["title"];
        }
        newHtml += "</a>";
        newHtml += "</td>";
        newHtml += "<td>";
        if (resources[i]["world_region"]) {
          newHtml += resources[i]["world_region"];
        }
        newHtml += "</td>";
        newHtml += "<td>";
        if (resources[i]["author"]) {
          newHtml += resources[i]["author"];
        }
        newHtml += "</td>";
        newHtml += "<td>";
        if (resources[i]["news_source"]) {
          newHtml += resources[i]["news_source"];
        }
        newHtml += "</td>";
        newHtml += "<td>";
        if (resources[i]["date"]) {
          newHtml += resources[i]["date"];
        }
        newHtml += "</td>";
        newHtml += "<td>";
        if (resources[i]["description"]) {
          newHtml += resources[i]["description"];
        } else if (resources[i]["abstract"]) {
          newHtml += resources[i]["abstract"];
        }
        newHtml += "</td>";
        newHtml += "<td>";
        if (resources[i]["url"]) {
          newHtml += resources[i]["url"];
        }
        newHtml += "</td>";
        newHtml += "</tr>";
      }
      tableBody.html(newHtml);
    },
    error: function(data) {

    },
    complete: function(data) {
      $('body').css('cursor', 'default');
    }
  });
};