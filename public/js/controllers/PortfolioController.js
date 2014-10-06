'use strict';

app.controller('PortfolioController', function($scope, $routeParams, DataService) {
    $scope.portfolio = {};

    $scope.displayChoice = 'both';

    DataService.getFirstPortfolio($routeParams.username, function(data) {
        $scope.portfolio = data;
    });

});