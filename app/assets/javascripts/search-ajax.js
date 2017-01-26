var searchFunction = function (htmlElement, tableBody, existingFilters, existingFilterDisplay) {
  $('body').css('cursor', 'progress');
  var htmlElement = $(htmlElement);
  var input = {};
  var existingFilterDisplay = $(existingFilterDisplay);
  var existingFilters = $(existingFilters);
  existingFilters.each(function(index) {
    if ($(this).data("filter") == "resource_type") {
      input[$(this).data("filter")] = $(this).text();
    } else {
      if (input[$(this).data("filter")] == null) {
        input[$(this).data("filter")] = [];
      } else {
        input[$(this).data("filter")].push($(this).text());
      }
    }
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
      if (resources.length > 0) {
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
          if (resources[i]["author"]) {
            newHtml += resources[i]["author"];
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
      } else {
        newHtml += "<h2 style='margin-bottom: 400px;'>";
        newHtml += "No Results!";
        newHtml += "</h2>";
      }
      tableBody.html(newHtml);
      var newFilters = "";
      if (params["resource_type"]) {
        newFilters += "<li class='existing-filters' data-filter='resource_type'>";
        newFilters += params["resource_type"];
        newFilters += "</li>";
      }
      for (var i = 0; i < params["building_block"].length; i ++) {
        newFilters += "<li class='existing-filters' data-filter='building_block'>";
        newFilters += params["building_block"][i];
        newFilters += "</li>";
      }
      for (var i = 0; i < params["building_block_substep"].length; i ++) {
        newFilters += "<li class='existing-filters' data-filter='building_block_substep'>";
        newFilters += params["building_block_substep"][i];
        newFilters += "</li>";
      }
      for (var i = 0; i < params["cognitive_bium"].length; i ++) {
        newFilters += "<li class='existing-filters' data-filter='cognitive_bium'>";
        newFilters += params["cognitive_bium"][i];
        newFilters += "</li>";
      }
      for (var i = 0; i < params["environmental_tag"].length; i ++) {
        newFilters += "<li class='existing-filters' data-filter='environmental_tag'>";
        newFilters += params["environmental_tag"][i];
        newFilters += "</li>";
      }
      for (var i = 0; i < params["environmental_subtag"].length; i ++) {
        newFilters += "<li class='existing-filters' data-filter='environmental_subtag'>";
        newFilters += params["environmental_subtag"][i];
        newFilters += "</li>";
      }
      for (var i = 0; i < params["world_region"].length; i ++) {
        newFilters += "<li class='existing-filters' data-filter='world_region'>";
        newFilters += params["world_region"][i];
        newFilters += "</li>";
      }
      existingFilterDisplay.html(newFilters);
    },
    error: function(data) {

    },
    complete: function(data) {
      $('body').css('cursor', 'default');
    }
  });
};