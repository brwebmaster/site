angular.module('AuthModule', []).
 	factory('authService', ['$q', '$http', function($q, $http) {
	 	var currentUser = $q.defer();
	 	$http.get('users/get_cur_user.json').success(function(data) {
	  	currentUser.resolve(data);
	  });
	  return {
	  	curUser: currentUser.promise
	  }
	}]);

// Source for no auto-scrolling: http://stackoverflow.com/questions/14530572/angularjs-how-to-disable-auto-scroll-to-top-of-my-page/14534133#14534133
angular.module('usersbr', ['AuthModule']).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/users', {templateUrl: '/assets/user-list.html',   controller: UserListCtrl}).
      when('/users/:userId', {templateUrl: '/assets/user-detail.html', controller: UserDetailCtrl}).
      otherwise({redirectTo: '/users'});
}]).value('$anchorScroll', angular.noop);

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
