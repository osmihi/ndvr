'use strict';

app.controller('APITesterController', function($scope, $location, APITesterService) {
    $scope.requestTypes = APITesterService.getRequestTypes();
    $scope.resources = APITesterService.getResources();

    $scope.request = newRequest();
    var response = '';

    function newRequest() {
        var rq = new APITesterService.APIRequest( $location.protocol() + '://' + 'api.' + $location.host() + ($location.port() != '' ? ':' + $location.port() : '') );

        rq.setUsername('osmihi');
        rq.setPassword('password');

        return rq;
    };

    $scope.reset = function() {
        $scope.request = newRequest();
        response = '';
    };

    $scope.submitRequest = function() {
        $scope.request.submit(
            function(data, status, errors) {
                response = data;
                console.log(data);
                console.log(status);
                console.log(errors);
            },
            function(data, status, errors) {
                response = data;
                console.log(data);
                console.log(status);
                console.log(errors);
            }
        );
    }

    $scope.getResponseText = function() {
        return JSON.stringify(response, null, '\t');
    };

    function getFieldsForTypeahead(rscName) {
        var rsc = APITesterService.getResource(rscName);

        if (typeof rsc !== 'undefined') {
            return rsc.fields;
        } else {
            return [];
        }
    }

    $scope.getSuggestedParameters = function() {
        return _.union(getFieldsForTypeahead($scope.request.resource.name), getFieldsForTypeahead($scope.request.subResource));
    };
});
