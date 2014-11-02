'use strict';

app.factory('APITesterService', function($http) {
    var APIRequest = function(baseURL) {
        this.baseURL = baseURL;
        this.requestType = 'GET';
        this.resource = {};
        this.key = null;
        this.subResource = null;
        this.params = [];
        this.auth = {
            username: '',
            password: ''
        };
    };

    APIRequest.prototype = {
        getParam: function(name) {
            return _.findWhere(this.params, {name:name});
        },
        addParam: function(param) {
            this.params.push(param || {});
            return param;
        },
        removeParam: function(param) {
            this.params = _.without(this.params, param);
            return param;
        },
        setUsername: function(username) {
            this.auth.username = username;
        },
        setPassword: function(pw) {
            this.auth.password = pw;
        },
        getUrl: function() {
            var url = this.baseURL + '/';
            if (this.resource.name) {
                url += this.resource.name.toLowerCase() + '/';
                url += this.key ? this.key + '/' : '';
                url += this.subResource ? this.subResource.toLowerCase() + '/' : '';
            }

            if (this.requestType == 'GET') {
                url += '?';

                var data = this.getDataObject();
                var delim = '';

                for (var param in data) {
                    url += delim + param + '=' + data[param];
                    delim = '&';
                }
            }

            return url;
        },
        getBodyText: function() {
            var body = '';

            if (this.requestType != 'GET') {
                var data = this.getDataObject();

                for (var param in data) {
                    body += param + '=' + data[param] + '\n';
                }
            }

            return body;
        },
        getDataObject: function() {
            var data = {};

            _.each(this.params, function(param) {
                if (param.name) {
                    data[param.name] = param.value;
                }
            });

            data.auth_username = this.auth.username;
            data.auth_password = this.auth.password;

            return data;
        },
        submit: function(successCallback, errorCallback) {
            var rqMethod;
            switch (this.requestType) {
                case 'GET':
                    rqMethod = $http.get;
                    break;
                case 'POST':
                    rqMethod = $http.post;
                    break;
                case 'PUT':
                    rqMethod = $http.put;
                    break;
                case 'PATCH':
                    rqMethod = $http.patch;
                    break;
                case 'DELETE':
                    rqMethod = $http.delete;
                    break;
                default:
                    rqMethod = $http.get;
                    break;
            }

            rqMethod(this.getUrl(), this.getDataObject()).success(successCallback).error(errorCallback);
        }
    };

    var resources = [
        {
            name: "User",
            fields: [
                'userID',
                'username',
                'password',
                'email',
                'role'
            ],
            subResources: [
                'Portfolio'
            ]
        },
        {
            name: "SkillCategory",
            fields: [
                'skillCategoryID',
                'name',
                'type'
            ],
            subResources: [
                'Skill'
            ]
        },
        {
            name: "Portfolio",
            fields: [
                'portfolioID',
                'userID',
                'name',
                'createdDate',
                'modifiedDate'
            ],
            subResources: [
                'Skill',
                'Contact',
                'Profile',
                'Work',
                'Education',
                'Project'
            ]
        },
        {
            name: "Profile",
            fields: [
                'portfolioID',
                'firstName',
                'middleName',
                'lastName',
                'title',
                'location',
                'statement'
            ]
        },
        {
            name: "Contact",
            fields: [
                'contactID',
                'portfolioID',
                'type',
                'subType',
                'contact',
                'label'
            ]
        },
        {
            name: "Skill",
            fields: [
                'skillID',
                'portfolioID',
                'skillCategoryID',
                'seq',
                'name'
            ],
            subResources: [
                'Education',
                'Work',
                'Project'
            ]
        },
        {
            name: "Education",
            fields: [
                'educationID',
                'portfolioID',
                'name',
                'location',
                'startDate',
                'endDate',
                'program',
                'gpa',
                'honors'
            ],
            subResources: [
                'Skill',
                'Project'
            ]
        },
        {
            name: "Work",
            fields: [
                'workID',
                'portfolioID',
                'name',
                'location',
                'startDate',
                'endDate',
                'title'
            ],
            subResources: [
                'Task',
                'Skill',
                'Project'
            ]
        },
        {
            name: "Project",
            fields: [
                'projectID',
                'portfolioID',
                'educationID',
                'workID',
                'display',
                'seq',
                'active',
                'name',
                'summary',
                'description'
            ],
            subResources: [
                'Example',
                'Education',
                'Work',
                'Skill'
            ]
        },
        {
            name: "Example",
            fields: [
                'exampleID',
                'projectID',
                'type',
                'seq',
                'link',
                'description'
            ],
            subResources: [
                'Project'
            ]
        },
        {
            name: "Task",
            fields: [
                'taskID',
                'workID',
                'seq',
                'description'
            ],
            subResources: [
                'Work'
            ]
        },
        {
            name: "EducationSkill",
            fields: [
                'educationSkillID',
                'educationID',
                'skillID',
                'seq'
            ],
            subResources: [
                'Skill',
                'Education'
            ]
        },
        {
            name: "WorkSkill",
            fields: [
                'workSkillID',
                'workID',
                'skillID',
                'seq'
            ],
            subResources: [
                'Skill',
                'Work'
            ]
        },
        {
            name: "ProjectSkill",
            fields: [
                'projectSkillID',
                'projectID',
                'skillID',
                'seq'
            ],
            subResources: [
                'Skill',
                'Project'
            ]
        }
    ];

    var requestTypes = [
        {
            "method": 'GET',
            "descriptor": 'Read'
        },
        {
            "method": 'POST',
            "descriptor": 'Create'
        },
        {
            "method": 'PUT',
            "descriptor": 'Update'
        },
        {
            "method": 'PATCH',
            "descriptor": 'Partial Update'
        },
        {
            "method": 'DELETE',
            "descriptor": 'Delete'
        }
    ];

    function getRequestTypes() {
        return requestTypes;
    }

    function getRequestType(name) {
        return _.findWhere(requestTypes, {name: name});
    }

    function getResourceList() {
        return _.pluck(resources, 'name');
    }

    function getResources() {
        return resources;
    }

    function getResource(name) {
        return _.findWhere(resources, {name: name});
    }

    return {
        APIRequest: APIRequest,
        getRequestTypes: getRequestTypes,
        getRequestType: getRequestType,
        getResourceList: getResourceList,
        getResources: getResources,
        getResource: getResource
    };
});