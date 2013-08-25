angular.module('usersbr', []).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/users', {templateUrl: '/assets/user-list.html',   controller: UserListCtrl}).
      when('/users/:userId', {templateUrl: '/assets/user-detail.html', controller: UserDetailCtrl}).
      otherwise({redirectTo: '/users'});
}]);

angular.module('videosbr', []).
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
