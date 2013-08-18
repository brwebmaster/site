/* Controllers */

function UserListCtrl($scope, $http) {
  $scope.users = [];
  $scope.groupedUsers = [];
  $scope.usersPerRow = 4;
  $scope.orderProp = 'first_name';
  $scope.query = '';

  $http.get('/users.json').success(function(data) {
    $scope.users = data;
    count = 0;
    copyArr = $scope.users.slice(0);
    $scope.groupedUsers = []
    while (copyArr.length > 0) {
      $scope.groupedUsers[count] = copyArr.splice(0, $scope.usersPerRow);
      count++;
    }
    console.log($scope.users);
  });

  // Return array of arrays splitting the data in itemsPerRow per array
  $scope.getRows = function(orderedUsers) {
		// groupedUsers = [];
  //   count = 0;
  //   while (orderedUsers.length > 0) {
  //     groupedUsers[count] = orderedUsers.splice(0, $scope.usersPerRow);
  //     count++;
  //   }
  //   return groupedUsers;
    return $scope.groupedUsers;
  }

  $scope.userFilter = function(query) {    
    query = query.toLowerCase();
    return function(user) {
      return user.first_name.toLowerCase().indexOf(query) != -1
      || user.last_name.toLowerCase().indexOf(query) != -1; 
    }
  }

  $scope.getOrderedUsers = function() {
    
  }
}

function UserDetailCtrl($scope, $routeParams, $http) {
  $scope.userId = $routeParams.userId;
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
    console.log(data);
    $scope.user = data; 
  })
}