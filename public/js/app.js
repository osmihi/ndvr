'use strict';

var app = angular.module('ndvr', ['ui.bootstrap', 'ngResource', 'ngRoute'])
    .config(function ($routeProvider) {

        $routeProvider.when('/:username',
            {
                templateUrl: 'templates/portfolio.html',
                controller: 'PortfolioController'
            }
        );
		
		$routeProvider.when('/',
			{
				templateUrl: 'templates/home.html',
				controller: 'HomeController'
			}
		);

        $routeProvider.otherwise(
            {
                redirectTo: '/'
            }
        );
    });
