(function(cordova) {
    
    function CordovaPermissions() {}
    CordovaPermissions.prototype.set = function(requestedPermissions, success, error) {
        if (requestedPermissions && Object.prototype.toString.call(requestedPermissions) === '[object Array]') {
            cordova.exec(success, error, 'CordovaPermissions', 'get', [ requestedPermissions ]);
        } 
    };            
    cordova.addConstructor(function() {
                           if(!window.plugins) window.plugins = {};
                           window.plugins.CordovaPermissions = new CordovaPermissions();
                           });

})(window.cordova || window.Cordova);
               
               
/* DEBUG */ window.console.log('cordovapermission.js loaded...');
