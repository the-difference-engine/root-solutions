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
      }
      input[$(this).data("filter")].push($(this).text());
    }
  });
  if (htmlElement.data("filter") == "resource_type") {
    input[htmlElement.data("filter")] = htmlElement.text();
  } else {
    if (input[htmlElement.data("filter")] == null) {
      input[htmlElement.data("filter")] = [];
    }
    input[htmlElement.data("filter")].push(htmlElement.text());
  }
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
      if (input["resource_type"]) {
        newFilters += "<li class='existing-filters' data-filter='resource_type'>";
        newFilters += input["resource_type"];
        newFilters += "</li>";
      }
      if (input["building_block"]) {
        for (var i = 0; i < input["building_block"].length; i ++) {
          newFilters += "<li class='existing-filters' data-filter='building_block'>";
          newFilters += input["building_block"][i];
          newFilters += "</li>";
        }
      }
      if (input["building_block_substep"]) {
        for (var i = 0; i < input["building_block_substep"].length; i ++) {
          newFilters += "<li class='existing-filters' data-filter='building_block_substep'>";
          newFilters += input["building_block_substep"][i];
          newFilters += "</li>";
        }
      }
      if (input["cognitive_bium"]) {
        for (var i = 0; i < input["cognitive_bium"].length; i ++) {
          newFilters += "<li class='existing-filters' data-filter='cognitive_bium'>";
          newFilters += input["cognitive_bium"][i];
          newFilters += "</li>";
        }
      }
      if (input["environmental_tag"]) {
        for (var i = 0; i < input["environmental_tag"].length; i ++) {
          newFilters += "<li class='existing-filters' data-filter='environmental_tag'>";
          newFilters += input["environmental_tag"][i];
          newFilters += "</li>";
        }
      }
      if (input["environmental_subtag"]) {
        for (var i = 0; i < input["environmental_subtag"].length; i ++) {
          newFilters += "<li class='existing-filters' data-filter='environmental_subtag'>";
          newFilters += input["environmental_subtag"][i];
          newFilters += "</li>";
        }
      }
      if (input["world_region"]) {
        for (var i = 0; i < input["world_region"].length; i ++) {
          newFilters += "<li class='existing-filters' data-filter='world_region'>";
          newFilters += input["world_region"][i];
          newFilters += "</li>";
        }
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