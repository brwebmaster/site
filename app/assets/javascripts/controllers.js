/* Controllers */

var UserListCtrl = function($scope, $http) {
  $scope.users = [];
  $scope.groupedUsers = [];
  $scope.usersPerRow = 4;
  $scope.orderProp = 'first_name';
  $scope.query = '';

  $http.get('/users.json').success(function(data) {
    $scope.users = data;
    count = 0;
    // apply filtering here?
    copyArr = $scope.users.slice(0);
    $scope.groupedUsers = []
    while (copyArr.length > 0) {
      $scope.groupedUsers[count] = copyArr.splice(0, $scope.usersPerRow);
      count++;
    }
    console.log($scope.users);
  });

  // (users | filter:userFilter(query) | orderBy:orderProp) 
  // Return array of arrays splitting the data in itemsPerRow per array
  $scope.getRows = function() {
    return $scope.groupedUsers;
  }

  $scope.userFilter = function(query) {    
    query = query.toLowerCase();
    return function(user) {
      return user.first_name.toLowerCase().indexOf(query) != -1
      || user.last_name.toLowerCase().indexOf(query) != -1; 
    }
  }
}

UserListCtrl.$inject = ['$scope', '$http'];

var UserDetailCtrl = function($scope, $routeParams, $http, $location) {
  $scope.userId = $routeParams.userId;
  $scope.users = [];
  $scope.user = {
    "id": 0,
    "first_name": "John",
    "last_name": "Bisbis",
    "sunet": "jbisbis",
    "year": "2015",
    "bio": "I am a member of Basmati Raas",
    "avatar_url": "/assets/defaultRaas.jpg"
  };

  $http.get('/users/' + $scope.userId + '.json').success(function(data) {
    $scope.user = data; 
  });

  $http.get('/users.json').success(function(data) {
    console.log(data);
    $scope.users = data; 
  });

  $scope.open = function(u){
    $location.path('/users/' + u.id);
    $scope.user = u;
  };

  $scope.getFullName = function(u) {
    return u.first_name + " " + u.last_name;
  }
}

UserDetailCtrl.$inject = ['$scope', '$routeParams', '$http', '$location'];

