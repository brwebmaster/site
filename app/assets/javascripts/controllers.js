/* Controllers */

var UserListCtrl = function($scope, $http, $filter) {
  $scope.users = [];
  $scope.groupedUsers = [];
  $scope.usersPerRow = 4;
  $scope.orderProp = 'first_name';
  $scope.query = '';

  $http.get('/users.json').success(function(data) {
    $scope.users = data;
    $scope.getRows();
  });

  // (users | filter:userFilter(query) | orderBy:orderProp) 
  // Return array of arrays splitting the data in itemsPerRow per array
  $scope.getRows = function(query, orderProp) {
    if (orderProp == undefined) {
      orderProp = $scope.orderProp;
    }
    var filtered = $filter('filter')($scope.users, $scope.userFilter(query));
    filtered = $filter('orderBy')(filtered, orderProp);
    var numRows = Math.ceil(filtered.length / $scope.usersPerRow);
    $scope.groupedUsers = [];
    for (var i = 0; i < numRows; i++) {
      $scope.groupedUsers.push([]);
      var numCols = (i == numRows - 1) ? 
        filtered.length % $scope.usersPerRow : $scope.usersPerRow;
      for (var j = 0; j < numCols; j++) {
        $scope.groupedUsers[i][j] = filtered[$scope.usersPerRow * i + j];
      }
    }
  }

  $scope.userFilter = function(query) {    
    if (query == undefined) {
      query = $scope.query;
    }
    query = query.toLowerCase();
    return function(user) {
      return user.first_name.toLowerCase().indexOf(query) != -1
      || user.last_name.toLowerCase().indexOf(query) != -1; 
    }
  }
}

UserListCtrl.$inject = ['$scope', '$http', '$filter'];

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

  $scope.open = function(u) {
    $location.path('/users/' + u.id);
    $scope.user = u;
  };

  $scope.getFullName = function(u) {
    return u.first_name + " " + u.last_name;
  }
}

UserDetailCtrl.$inject = ['$scope', '$routeParams', '$http', '$location'];

var VideoCtrl = function($scope, $http, $filter) {
  $scope.videos = [];
  $scope.link = '';
  $scope.description = '';
  $scope.successStatus = '';
  $scope.errorStatus = '';

  $http.get('/videos.json').success(function(data) {
    $scope.videos = data;
  });

  $scope.click = function() {
    var videoData = {
      'description': $scope.description,
      'link': $scope.link
    };
    $scope.link = '';
    $scope.description = '';
    $scope.successStatus = '';
    $scope.errorStatus = '';

    $http.post('/videos.json', videoData).success(function(data) {
      console.log(data);
      $scope.successStatus = 'Added video successfully!';
      $scope.videos.unshift(data);
    }).error(function(data) {
      $scope.errorStatus = 'Could not add the video. Please check that the youtube link is correct.';
      console.log('error in video adding');
    });
  }

  $scope.deleteVid = function(id) {
    var r = confirm("Are you sure you want to remove this video?");
    if (r == true){
      $http.delete('/videos/' + id).success(function() {
        $scope.successStatus = 'Deleted video.';
        for (var i = 0; i < $scope.videos.length; i++) {
          if ($scope.videos[i].id == id) {
            // remove element from array
            $scope.videos.splice(i, 1);
          }
        }
      });
    }    
  }
}

VideoCtrl.$inject = ['$scope', '$http', '$filter'];