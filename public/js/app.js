'use strict';

var app = angular.module('ndvr', ['ui.bootstrap', 'ngResource', 'ngRoute', 'ngSanitize'])
    .config(function ($routeProvider) {

        $routeProvider.when('/apiTester',
            {
                templateUrl: 'templates/apiTester.html',
                controller: 'APITesterController'
            }
        ).when('/:username',
            {
                templateUrl: 'templates/portfolio.html',
                controller: 'PortfolioController'
            }
        ).when('/',
			{
				templateUrl: 'templates/home.html',
				controller: 'HomeController'
			}
        ).otherwise(
            {
                redirectTo: '/'
            }
        );
    });
