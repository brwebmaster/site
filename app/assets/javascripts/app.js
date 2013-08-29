angular.module('AuthModule', []).
 	factory('authService', ['$q', '$http', function($q, $http) {
	 	var currentUser = $q.defer();
	 	$http.get('users/get_cur_user.json').success(function(data) {
	  	currentUser.resolve(data);
	  });
	  return {
	  	curUser: currentUser.promise
	  }

	  return {
	    isLoggedIn: function(callback) {  
	    	$http.get('users/get_cur_user.json').success(function(data) {
			    callback(data);
			  });
	    },
	    // currentUser: function() { return currentUser; }
	  };
	}]);

angular.module('usersbr', ['AuthModule']).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/users', {templateUrl: '/assets/user-list.html',   controller: UserListCtrl}).
      when('/users/:userId', {templateUrl: '/assets/user-detail.html', controller: UserDetailCtrl}).
      otherwise({redirectTo: '/users'});
}]);

angular.module('videosbr', ['AuthModule']).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/videos', {templateUrl: '/assets/video.html', controller: VideoCtrl}).
      otherwise({redirectTo: '/videos'});
}]).config(["$httpProvider", function(provider) {
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]).filter('fromNow', function() {
  return function(date) {
    return moment(date).fromNow();
  }
});

var perfApp = angular.module('performancesbr', ['AuthModule']).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/performances', {templateUrl: '/assets/performance.html', controller: PerformanceCtrl}).
      otherwise({redirectTo: '/performances'});
}]).config(["$httpProvider", function(provider) {
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]).filter('fromNow', function() {
  return function(date) {
    return moment(date).fromNow();
  }
});
