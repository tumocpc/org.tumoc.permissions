var exec = require('cordova/exec');

exports.get = function(requestedPermissions, success, error) {
    if (requestedPermissions && Object.prototype.toString.call(requestedPermissions) === '[object Array]') {
        exec(success, error, 'CordovaPermissions', 'get', [ requestedPermissions ]);
    }  
};
