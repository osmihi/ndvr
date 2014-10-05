'use strict';

app.directive('contactLink', function() {
    var socialButtons = [
        'adn',
        'bitbucket',
        'dropbox',
        'facebook',
        'flickr',
        'foursquare',
        'github',
        'google-plus',
        'instagram',
        'linkedin',
        'microsoft',
        'openid',
        'pinterest',
        'reddit',
        'soundcloud',
        'tumblr',
        'twitter',
        'vimeo',
        'vk',
        'yahoo'
    ];

    function link(scope, element, attrs, controller) {
        $scope.linkType;

        // does it have a social icon?
        _.contains(socialButtons, $scope.contact.subType);

        _.contains(socialButtons, $scope.contact.subType);

        // is it in the glyphs list

        // default

    }

    return {
        restrict: 'EA',
        scope: {
            contact: '='
        },
        templateUrl: '/templates/directives/contactLink.html',
        link: link
    };
});