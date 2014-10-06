'use strict';

app.controller('HeadController', function($scope) {
    $scope.themes = [
        {name:'Amelia', url: '//maxcdn.bootstrapcdn.com/bootswatch/3.2.0/amelia/bootstrap.min.css'},
        {name:'Cosmo', url: '//maxcdn.bootstrapcdn.com/bootswatch/3.2.0/cosmo/bootstrap.min.css'},
        {name:'Cyborg', url: '//maxcdn.bootstrapcdn.com/bootswatch/3.2.0/cyborg/bootstrap.min.css'},
        {name:'Darkly', url: '//maxcdn.bootstrapcdn.com/bootswatch/3.2.0/darkly/bootstrap.min.css'},
        {name:'Default', url: '//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css'},
        {name:'Flatly', url: '//maxcdn.bootstrapcdn.com/bootswatch/3.2.0/flatly/bootstrap.min.css'},
        {name:'Journal', url: '//maxcdn.bootstrapcdn.com/bootswatch/3.2.0/journal/bootstrap.min.css'},
        {name:'Lumen', url: '//maxcdn.bootstrapcdn.com/bootswatch/3.2.0/lumen/bootstrap.min.css'},
        {name:'Readable', url: '//maxcdn.bootstrapcdn.com/bootswatch/3.2.0/readable/bootstrap.min.css'},
        {name:'Sandstone', url: '//maxcdn.bootstrapcdn.com/bootswatch/3.2.0/sandstone/bootstrap.min.css'},
        {name:'Simplex', url: '//maxcdn.bootstrapcdn.com/bootswatch/3.2.0/simplex/bootstrap.min.css'},
        {name:'Superhero', url: '//maxcdn.bootstrapcdn.com/bootswatch/3.2.0/superhero/bootstrap.min.css'},
        {name:'United', url: '//maxcdn.bootstrapcdn.com/bootswatch/3.2.0/united/bootstrap.min.css'},
        {name:'Yeti', url: '//maxcdn.bootstrapcdn.com/bootswatch/3.2.0/yeti/bootstrap.min.css'}
    ];

    $scope.theme = $scope.themes[8]; // Default CSS theme

    $scope.setTheme = function(theme) {
        $scope.theme = theme;
    };

});
