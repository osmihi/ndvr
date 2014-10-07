'use strict';

/**
 *  Until I write the backend of this app, this service (and the *.json files in the data folder) will serve as a placeholder
 */
app.factory('DataService', function($http) {
    var tables = ['Contact', 'Education', 'Example', 'Portfolio', 'Project', 'Skill', 'Task', 'User', 'Work'];

    /**
     * Get the user object for the user with the specified name.
     *
     * @param username  The username of the user to retrieve.
     * @param callback  Function to execute when the user has been retrieved. The object is passed as a parameter to this function.
     */
    function getUser(username, callback) {
        $http.get('data/User.json').success(function(data) {
            var user = _.find(data.User, function(u) {
                return u.username == username;
            });

            callback(user);
        });
    }

    /**
     * This function will retrieve the first portfolio for a given username. Normally we would expect our API to return the data in our desired format,
     * rather than using nested calls on the client side to fill in child data as we do here.
     *
     * @param username  The username of the user for whom portfolios should be looked up
     * @param callback  Code to execute when the portfolio has been retrieved (the object is passed as a parameter to this function)
     */
    function getFirstPortfolio(username, callback) {
        getUser(username, function(user) {
            $http.get('data/Portfolio.json').success(function(data) {

                var portfolio = _.find(data.Portfolio, function(pf) {
                    return pf.userID = user.userID;
                });

                getList('Skill', portfolio.Skill, function(skills) {
                    portfolio.Skill = skills;
                });

                getList('Project', portfolio.Project, function(projects) {
                    _.each(projects, function(project) {
                        getList('Skill', project.Skill, function(skills) {
                            project.Skill = skills;
                            getList('Example', project.Example, function(examples) {
                                project.Example = examples;
                            });
                            portfolio.Project = projects;
                        });
                    });
                });

                getList('Work', portfolio.Work, function(works) {
                    _.each(works, function(work) {
                       getList('Task', work.Task, function(tasks) {
                           work.Task = tasks;
                           portfolio.Work = works;
                       })
                    });
                });

                getList('Education', portfolio.Education, function(educations) {
                    portfolio.Education = educations;
                });

                getList('Contact', portfolio.Contact, function(contacts) {
                    portfolio.Contact = contacts;
                });

                callback(portfolio);
            });
        });
    }

    /**
     * This function will retrieve a list of items in a table matching one of the ids provided and execute the callback on the resulting list.
     *
     * @param table     Name of the table to be searched
     * @param ids       An ID or list of IDs to match to the primary key of the table
     * @param callback  Function to execute on the list once retrieved
     */
    function getList(table, ids, callback) {
        if (!angular.isArray(ids)) {
            ids = [ids];
        }

        $http.get('data/' + table + '.json').success(function(data) {
            var tableKey = table.toLowerCase() + 'ID';  // We used this convention in our data model for primary keys

            var list = _.map(ids, function(id) {
                return _.find(data[table], function(item) {
                    return item[tableKey] == id;
                });
            });

            callback(list);
        });
    }

    return {
        getUser: getUser,
        getFirstPortfolio: getFirstPortfolio
    };
});