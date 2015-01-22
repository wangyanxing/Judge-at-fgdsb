'use strict';

/* Controllers */

var fgdsbControllers = angular.module('fgdsbControllers', []);

fgdsbControllers.controller('ProblemListCtrl', ['$scope', 'Problem',
    function($scope, Problem) {
        $scope.problems = Problem.query();
        $scope.orderProp = 'age';
    }]);

fgdsbControllers.controller('ProblemDetailCtrl', ['$scope', '$routeParams', 'Problem',
    function($scope, $routeParams, Problem) {
        $scope.problem = Problem.get({problemId: $routeParams.problemId, 'foo':new Date().getTime()}, function(problem) {
            //$scope.mainImageUrl = problem.images[0];
        });

        /*
        $scope.setImage = function(imageUrl) {
            $scope.mainImageUrl = imageUrl;
        }*/
    }]);