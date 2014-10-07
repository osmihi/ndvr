"use strict";

app.directive('projectBlock', function() {
    function link(scope, element, attrs, controller) {
        scope.projectCollapsed = true;

        //scope.image = scope.project.Example.length > 0 ? scope.project.Example[0] : null;

        scope.getImage = function() {
            return _.findWhere(scope.project.Example, {type:'image'});
        };
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