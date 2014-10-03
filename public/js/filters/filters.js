'use strict';

/**
 * Filter to return the set of unique values for a given property in an array of objects
 */
app.filter('uniqueByProperty', function() {
   return function(input, prop) {
       return _.pluck(
           _.uniq(input, false, function(obj) {
               return obj[prop];
           }),
           prop
       );
   };

});

/**
 * Filter which adds a property to each object in an array containing the milliseconds time value of a date object created from the content of the property with the given name.
 * Example: An array of objects like {date:'10/3/2014'} will be returned as an array of objects like {date:'10/3/2014', dateTime: 1412312400000}
 * This is useful for ordering by date when the date has been stored as a string
 */
app.filter('dateToTime', function() {
    return function(input, prop) {
        _.each(input, function(obj) {
            obj[prop + 'Time'] = (new Date(obj[prop])).getTime();
        });

        return input;
    };
});

/**
 * This filter takes a Contact object and returns a url. It supports phone, email, and web.
 */
app.filter('contactUrl', function() {
    return function(input) {
        switch(input.type) {
            case "web":
                return input.contact;
                break;
            case "phone":
                return 'tel:' + input.contact;
                break;
            case "email":
                return 'mailto:' + input.contact;
                break;
            default:
                return;
        }
    };
});