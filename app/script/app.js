'use strict';

/* App Module */

var fgdsbApp = angular.module('fgdsbApp', [
    'ngRoute',
    'fgdsbControllers',
    'fgdsbServices'
]);

fgdsbApp.config(['$routeProvider',
    function($routeProvider) {
        $routeProvider.
            when('/problems', {
                templateUrl: 'partials/problems.html',
                controller: 'ProblemListCtrl'
            }).
            when('/problems/:problemId', {
                templateUrl: 'partials/problem-detail.html',
                controller: 'ProblemDetailCtrl'
            }).
            otherwise({
                redirectTo: '/problems'
            });
    }]);