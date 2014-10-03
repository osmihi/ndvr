'use strict';

app.controller('PortfolioController', function($scope, $routeParams) {
	$scope.portfolioText = 'Portfolio for ' + $routeParams.portfolio;
});