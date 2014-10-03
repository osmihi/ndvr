'use strict';

app.controller('PortfolioController', function($scope, $routeParams, DataService) {
    $scope.portfolio = {};

    DataService.getFirstPortfolio($routeParams.username, function(data) {
        $scope.portfolio = data;

        console.log($scope.portfolio);
    });

});