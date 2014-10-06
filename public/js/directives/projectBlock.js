"use strict";

app.directive('projectBlock', function() {
    function link(scope, element, attrs, controller) {
        scope.projectCollapsed = true;
    }

    return {
        restrict: 'EA',
        templateUrl: '/templates/directives/projectBlock.html',
        scope: {
            project: '='
        },
        replace: true,
        link: link
    };
});