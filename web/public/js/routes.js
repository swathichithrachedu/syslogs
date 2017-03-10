/**
 * Created by bhanu.mokkala on 1/18/2017.
 */
'use strict';

angular.module("seal")
    .config(['$routeProvider', '$locationProvider', '$mdThemingProvider',function($routeProvider, $locationProvider, $mdThemingProvider) {
        $mdThemingProvider.theme('default')
            .primaryPalette('blue-grey')
            .accentPalette('green');
        $locationProvider
            .html5Mode(false)
            .hashPrefix('!');
        $routeProvider
            .when('/dashboard', {
                templateUrl : 'view/dashboard.html',
                controller : 'dbctrl'
            })
            .when('/', {
                templateUrl : 'view/dashboard.html',
                controller : 'dbctrl'
            })
            .when('/threshold', {
                templateUrl : 'view/threshold.html',
                controller : 'thresholdctrl'
            })
            .when('/rtemplate', {
                templateUrl : 'view/rtemplate.html',
                controller : 'rtemplatectrl'
            })
            .when('/viewlog', {
                templateUrl : 'view/viewlog.html',
                controller : 'viewlogctrl'
            })
            .when('/config', {
                templateUrl : 'view/config.html',
                controller : 'configctrl'
            });
    }]);