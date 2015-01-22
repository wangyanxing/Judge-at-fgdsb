'use strict';

/* Services */

var fgdsbServices = angular.module('fgdsbServices', ['ngResource']);

fgdsbServices.factory('Problem', ['$resource',
  function($resource){
    return $resource('problems/:problemId.json', {}, {
      query: {method:'GET', params:{problemId:'problems', 'foo':new Date().getTime()}, isArray:true}
    });
  }]);
