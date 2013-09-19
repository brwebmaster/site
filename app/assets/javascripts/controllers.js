/* Controllers */

var UserListCtrl = function($scope, $http, $filter) {
  $scope.users = [];
  $scope.alumni = [];
  $scope.groupedUsers = [];
  $scope.groupedAlumni = [];
  $scope.showSearch = false;
  $scope.showAlumni = false;
  $scope.usersPerRow = 4;
  $scope.orderProp = 'gender';
  $scope.query = '';

  $http.get('/users.json?is_alumni=0').success(function(data) {
    $scope.users = data;
    $scope.getRows();
  });

  $scope.toggleSearch = function() {    
    $scope.showSearch = !$scope.showSearch;
  };

  $scope.toggleAlumni = function() {
    $scope.showAlumni = !$scope.showAlumni;
    if ($scope.showAlumni) {
      $http.get('/users.json?is_alumni=1').success(function(data) {
        $scope.alumni = data;
        $scope.groupedAlumni = $scope.groupArray($scope.query, $scope.orderProp, $scope.alumni);
      });
    }
  };

  // Return array of arrays grouping the data 4 at a time
  $scope.getRows = function(query, orderProp) {
    $scope.groupedUsers = $scope.groupArray(query, orderProp, $scope.users);
    $scope.groupedAlumni = $scope.groupArray(query, orderProp, $scope.alumni);
  };

  // private method
  $scope.groupArray = function(query, orderProp, arr) {
    if (orderProp == undefined) {
      orderProp = $scope.orderProp;
    }
    var filtered = $filter('filter')(arr, $scope.userFilter(query));
    filtered = $filter('orderBy')(filtered, orderProp);
    var numRows = Math.ceil(filtered.length / $scope.usersPerRow);
    var grouped = [];
    for (var i = 0; i < numRows; i++) {
      grouped.push([]);
      var numCols = $scope.usersPerRow;
      if (i == numRows - 1) {
        if (filtered.length % $scope.usersPerRow != 0) {
          numCols = filtered.length % $scope.usersPerRow
        } else {
          numCols = $scope.usersPerRow;
        }
      }
      for (var j = 0; j < numCols; j++) {
        grouped[i][j] = filtered[$scope.usersPerRow * i + j];
      }
    }
    return grouped;
  };

  $scope.userFilter = function(query) {    
    if (query == undefined) {
      query = $scope.query;
    }
    query = query.toLowerCase();
    return function(user) {
      return user.first_name.toLowerCase().indexOf(query) != -1
      || user.last_name.toLowerCase().indexOf(query) != -1; 
    }
  };
}

UserListCtrl.$inject = ['$scope', '$http', '$filter'];

var UserDetailCtrl = function($scope, $routeParams, $http, $location) {
  $scope.userId = $routeParams.userId;
  $scope.users = [];
  $scope.canEdit = false;
  $scope.curIndex = 1;
  $scope.user = {
    "id": 0,
    "first_name": " ",
    "last_name": " ",
    "year": " ",
    "bio": "I am a member of Basmati Raas",
    "avatar_url": "/assets/defaultRaas.jpg",
    "gender": "M"
  };

  $http.get('/users/' + $scope.userId + '.json').success(function(data) {
    $scope.user = data;
    $http.get('/users/can_edit.json?sunet=' + $scope.user.sunet).success(function(data) {
      if (data.can_edit) {
        $scope.canEdit = true;
      }
    });
    $http.get('/users.json').success(function(data) {
      $scope.users = data;
      // indexOf compares using strict equality, so we need to do manual comparison 
      // $scope.curIndex = $scope.users.indexOf($scope.user); //always returns -1
      for (var i = 0; i < $scope.users.length; i++) {
        if ($scope.user.id === $scope.users[i].id) {
          $scope.curIndex = i;
          break;
        }
      }
    });
  }).error(function(data) {
    console.log("Failed to get user data, trying to fetch all users", data);
    $http.get('/users.json').success(function(data) {
      $scope.users = data;
    });
  });

  

  $scope.open = function(u, index) {
    $scope.curIndex = index;
    $scope.updateLocation(u.id);
    $scope.user = u;
  };

  $scope.updateLocation = function(id) {
    $location.path('/users/' + id);
  };

  $scope.getFullName = function(u) {
    return u.first_name + " " + u.last_name;
  };

  $scope.prevMember = function() {
    $scope.user = $scope.users[--$scope.curIndex];
  };

  $scope.nextMember = function() {
    $scope.user = $scope.users[++$scope.curIndex];
  };
}

UserDetailCtrl.$inject = ['$scope', '$routeParams', '$http', '$location'];

var VideoCtrl = function($scope, $http, $filter) {
  $scope.videos = [];
  $scope.link = '';
  $scope.description = '';
  $scope.successStatus = '';
  $scope.errorStatus = '';
  $scope.isUploadable = false;
  $scope.sendEmail = false;
  $scope.itemsPerPage = 3;
  $scope.pagedItems = [];
  $scope.currentPage = 0;

  // Map video id to its comments
  $scope.videoComments = {};
  // Map video id to boolean whether we display comments or not
  $scope.shownComments = {};
  $scope.form = {
    'comment' : ''
  };

  $http.get('/videos.json').success(function(data) {
    $scope.videos = data;
    for (var i = 0; i < data.length; i++) {
      $scope.fetchComments(data[i].id);
    }
    $scope.groupToPages();
  });

  // Source: http://jsfiddle.net/SAWsA/11/
  $scope.groupToPages = function() {
    $scope.pagedItems = [];
    for (var i = 0; i < $scope.videos.length; i++) {
      var ind = Math.floor(i / $scope.itemsPerPage);
      if (i % $scope.itemsPerPage === 0) {
        $scope.pagedItems[ind] = [ $scope.videos[i] ]
      } else {
        $scope.pagedItems[ind].push($scope.videos[i]);
      }
    }
  };

  $scope.range = function(len) {
    return _.range(len);
  };

  $scope.prevPage = function() {
    if ($scope.currentPage > 0) {
      $scope.currentPage--;
    }
  };

  $scope.nextPage = function() {
    if ($scope.currentPage < $scope.pagedItems.length - 1) {
      $scope.currentPage++;
    }
  };

  $scope.setPage = function() {
    $scope.currentPage = this.n;
  };

  $scope.click = function() {
    var videoData = {
      'description': $scope.description,
      'link': $scope.link,
      'sendEmail': $scope.sendEmail
    };
    $scope.link = '';
    $scope.description = '';
    $scope.successStatus = '';
    $scope.errorStatus = '';

    $http.post('/videos.json', videoData).success(function(data) {
      $scope.successStatus = 'Added video successfully!';
      $scope.videos.unshift(data);
      $scope.fetchComments(data.id)
      $scope.groupToPages();
    }).error(function(data) {
      $scope.errorStatus = 'Could not add the video. Please check that the youtube link is correct.';
    });
  };

  $scope.deleteVid = function(id) {
    var r = confirm("Are you sure you want to remove this video?");
    if (r) {
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
  };

  $scope.showUploadForm = function() {
    $scope.isUploadable = !$scope.isUploadable;
  };

  $scope.isAddDisabled = function() {
    return $scope.form.comment == undefined || $scope.form.comment === '';
  };

  $scope.save = function(vid) {
    params = {
      video_id: vid,
      comment: $scope.form.comment
    };
    $http.post('/videos/' + vid + '/video_comments.json', params).success(function(data) {
      $scope.successStatus = 'Added your comment!';
      $scope.videoComments[vid].push(data);
      $scope.form.comment = '';
    }).error(function(data) {
      $scope.errorStatus = 'Could not add the comment.';
    });
  };

  $scope.fetchComments = function(vid) {
    $http.get('/videos/' + vid + '/video_comments.json').success(function(data) {
      $scope.videoComments[vid] = data;      
    });
  };

  $scope.markCommentsShown = function(vid) {
    $scope.shownComments[vid] = true;
  };

  $scope.areCommentsShown = function(vid) {
    return vid in $scope.shownComments;
  };
}

VideoCtrl.$inject = ['$scope', '$http', '$filter'];

var PerformanceCtrl = function($scope, $http, $filter, authService) {
  $scope.performances = [];
  $scope.user = false;
  $scope.createNew = false;
  $scope.allowCreate = false;
  $scope.curPerformance = null;
  $scope.successStatus = '';
  $scope.errorStatus = '';
  // These should match db columns
  $scope.form = {
    'event' : '',
    'time' : '',
    'place' : '',
    'description' : ''
  };

  $http.get('/performances.json').success(function(data) {
    $scope.performances = data;
    var promise = authService.curUser;
    promise.then(function(data) {
      $scope.user = (data === 'null') ? false : data;
      $scope.allowCreate = $scope.user;
    });
  });

  $scope.showPerfCreation = function() {
    $scope.createNew = true;
    $scope.allowCreate = false;
  };

  $scope.save = function() {
    $scope.allowCreate = true;
    $scope.createNew = false;
    if ($scope.curPerformance) {
      var index = $scope.performances.indexOf($scope.curPerformance);
      $http.put('/performances/' + $scope.curPerformance.id + '.json', $scope.form).success(function(data) {
        $scope.successStatus = 'Edited performance successfully!';
        $scope.performances.splice(index, 1, data);
      }).error(function(data) {
        $scope.errorStatus = 'Could not edit the performance.';
      });
    } else {
      $http.post('/performances.json', $scope.form).success(function(data) {
        $scope.successStatus = 'Added performance successfully! (Refresh the page if things look weird)';
        // TODO: insert in correct place in order
        $scope.performances.unshift(data);
      }).error(function(data) {
        $scope.errorStatus = 'Could not add the performance.';
      });  
    }
  };

  $scope.cancel = function() {
    $scope.allowCreate = true;
    $scope.createNew = false; 
    $scope.curPerformance = null;
  };

  // Source: http://docs.angularjs.org/cookbook/advancedform
  $scope.isSaveDisabled = function() {
    return $scope.perfForm.$invalid;
  };

  $scope.edit = function(performance) {
    $scope.curPerformance = performance;
    $scope.showPerfCreation();
    $scope.form.event = performance.event;
    $scope.form.time = performance.time;
    $scope.form.place = performance.place;
    $scope.form.description = performance.description;
  };

  $scope.isActivePerf = function(performance) {
    return performance == $scope.curPerformance;
  };

  $scope.deletePerf = function(id) {
    var r = confirm("Are you sure you want to remove this performance?");
    if (r == true){
      $http.delete('/performances/' + id).success(function() {
        $scope.successStatus = 'Deleted video.';
        for (var i = 0; i < $scope.performances.length; i++) {
          if ($scope.performances[i].id == id) {
            // remove element from array
            $scope.performances.splice(i, 1);
          }
        }
      });
    }    
  };
}

PerformanceCtrl.$inject = ['$scope', '$http', '$filter', 'authService'];