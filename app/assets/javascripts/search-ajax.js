var search = function () {
  var data =

  $.ajax({
    type: "GET",
    url: "/search_filter",
    data: {

    },
    success: function(data) {

    },
    error: function(data) {

    },
    complete: function(data) {

    }
  });
};

//reference, must delete

script 

$(".my_class").click(function(e){
  var clickedElement = this;
  var resourceType = this.html;
  search(resourceType);
})

$("body").on("click", "my_class", function() {

})