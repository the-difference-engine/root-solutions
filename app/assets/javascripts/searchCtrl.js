(function(){
  "use Strict"
  angular.module("adminpanel-app").controller("searchCtrl",
  function($scope, $http, $location){

    $scope.searchCtrl = [];
    $scope.search_setup = function(){
      $http.get("api/v1/resources.json").then(function(response){
        $scope.resources = response.data;
      });
    }
    $scope.search = function(){
      $http.get("/search.json?q=" + $scope.search_term).then(function(response){
        $scope.search_results = response.data;
      });
    }
    window.$scope = $scope;
  });
})();
