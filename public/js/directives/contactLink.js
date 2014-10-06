'use strict';

app.directive('contactList', function() {
    return {
      restrict: 'EA',
        scope: {
            contacts: '=',
            heading: '@'
        },
        templateUrl: '/templates/directives/contactList.html',
        replace: true
    };
}).directive('contactLink', function() {
    var iconOptions = [
        {type:'social', name:'adn', icon:'', text:'App.net'},
        {type:'social', name:'bitbucket', icon:'bitbucket', text:'Bitbucket'},
        {type:'social', name:'dropbox', icon:'dropbox', text:'Dropbox'},
        {type:'social', name:'facebook', icon:'facebook', text:'Facebook'},
        {type:'social', name:'flickr', icon:'flickr', text:'Flickr'},
        {type:'social', name:'foursquare', icon:'foursquare', text:'Foursqaure'},
        {type:'social', name:'github', icon:'github', text:'GitHub'},
        {type:'social', name:'google', icon:'google-plus', text:'Google+'},
        {type:'social', name:'instagram', icon:'instagram', text:'Instagram'},
        {type:'social', name:'linkedin', icon:'linkedin', text:'LinkedIn'},
        {type:'social', name:'microsoft', icon:'microsoft', text:'Microsoft'},
        {type:'social', name:'reddit', icon:'reddit', text:'Reddit'},
        {type:'social', name:'soundcloud', icon:'soundcloud', text:'SoundCloud'},
        {type:'social', name:'tumblr', icon:'tumblr', text:'Tumblr'},
        {type:'social', name:'twitter', icon:'twitter', text:'Twitter'},
        {type:'social', name:'vimeo', icon:'vimeo', text:'Vimeo'},

        {type:'glyphicon', name: 'email', icon:'envelope', text:'Email', linkPrefix:'mailto:'},
        {type:'glyphicon', name: 'phone', icon:'phone', text:'Phone', linkPrefix:'tel:'},
        {type:'glyphicon', name: 'web', icon:'globe', text:'Web site'},

        {type:'glyphicon', name: 'other', icon:'asterisk', text: 'Link'}
    ];


    function link(scope, element, attrs, controller) {
        scope.iconData = _.findWhere(iconOptions, {name:scope.contact.subType}) || _.findWhere(iconOptions, {name:scope.contact.type}) || _.findWhere(iconOptions, {name:'other'});
    }

    return {
        restrict: 'EA',
        scope: {
            contact: '='
        },
        templateUrl: '/templates/directives/contactLink.html',
        replace:true,
        link: link
    };
});