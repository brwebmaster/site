function UsersdfCtrl($scope, $http) {
  $scope.user = 'smile';

  $scope.showUser = function(id) {
  	$http.get('/users/' + id + ".json").success(successCallback);
  }

  successCallback = function(data, status, headers, config) {
  	console.log(data);
  	$scope.user = data;
  }
}