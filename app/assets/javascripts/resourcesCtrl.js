(function(){
  "use Strict"
  angular.module("adminpanel-app").controller("resourcesCtrl",
  function($scope, $http, $location){

    $scope.resourcesCtrl = [];
    $scope.resources_setup = function(){
      $http.get("api/v1/resources.json").then(function(response){
        $scope.resources = response.data;
      });
    }

    window.$scope = $scope;
  });
})();
