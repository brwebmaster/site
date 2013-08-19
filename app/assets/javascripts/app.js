angular.module('usersbr', []).
  config(['$routeProvider', function($routeProvider) {
  $routeProvider.
      when('/users', {templateUrl: '/assets/user-list.html',   controller: UserListCtrl}).
      when('/users/:userId', {templateUrl: '/assets/user-detail.html', controller: UserDetailCtrl}).
      otherwise({redirectTo: '/users'});
}]);