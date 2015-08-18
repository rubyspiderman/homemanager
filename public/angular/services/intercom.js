! function(module, angular, undefined) {
    'use strict';

    angular.module('ngIntercom', ['angular-intercom']);

    module.value('IntercomSettings', {});

    module.provider('IntercomService', function() {
        var _asyncLoading = false;
        var _scriptUrl = '//static.intercomcdn.com/intercom.v1.js';

        this.asyncLoading = function(config) {
            _asyncLoading = config || _asyncLoading;
            return this;
        };

        this.scriptUrl = function(url) {
            _scriptUrl = url || _scriptUrl;
            return this;
        };

        // Create a script tag with moment as the source
        // and call our onScriptLoad callback when it
        // has been loaded
        function createScript($document, callback) {
            var scriptTag = $document.createElement('script');
            scriptTag.type = 'text/javascript';
            scriptTag.async = true;
            scriptTag.src = _scriptUrl;
            scriptTag.onreadystatechange = function() {
                if (this.readyState === 'complete') {
                    callback();
                }
            };
            // Set the callback to be run
            // after the scriptTag has loaded
            scriptTag.onload = callback;
            // Attach the script tag to the document body
            var s = $document.getElementsByTagName('body')[0];
            s.appendChild(scriptTag);
        }

        this.$get = ['$document', '$timeout', '$q', '$window',
            function($document, $timeout, $q, $window) {
                var deferred = $q.defer();
                var _intercom = angular.isFunction($window.Intercom) ? $window.Intercom : angular.noop;

                if (_asyncLoading) {
                    // wait up to 3 sec before aborting
                    var _try = 10;
                    // Load client in the browser
                    var onScriptLoad = function tryF(callback) {
                        $timeout(function() {
                            if (_try === 0) {
                                return deferred.resolve($window.Intercom);
                            }

                            if ($window.Intercom) {
                                // Resolve the deferred promise
                                // as the Intercom object on the window
                                return deferred.resolve($window.Intercom);
                            }
                            _try--;
                            setTimeout(tryF.bind(null, callback), 1000); // wait 1000ms before next try
                        });
                    };
                    createScript($document[0], onScriptLoad);
                }

                return (_asyncLoading) ? deferred.promise : _intercom;
            }
        ];
    });

    module.provider('Intercom', function() {

        this.$get = ['IntercomService', 'IntercomSettings', '$q',
            function(IntercomService, IntercomSettings, $q) {
                var _options = {},
                    deferedBoot = $q.defer(),
                    iS;

                angular.extend(_options, IntercomSettings);

                function intercomInstance(arg1, arg2, arg3) {
                    return deferedBoot.promise.then(function(iS) {
                        iS(arg1, arg2, arg3);
                    });
                }

                return {
                    boot: function(options) {
                        if (IntercomService.then) {
                            IntercomService.then(function(loadedIntercom) {
                                loadedIntercom('boot', options || _options);
                                deferedBoot.resolve(loadedIntercom);
                            });
                        } else {
                            IntercomService('boot', options || _options);
                            deferedBoot.resolve(IntercomService);
                        }
                    },

                    update: function(data) {
                        if (data) {
                            intercomInstance('update', data);
                        } else {
                            intercomInstance('update');
                        }
                    },
                    trackEvent: function(eventName, data) {
                        intercomInstance('trackEvent', eventName, data);
                    },
                    shutdown: function() {
                        intercomInstance('shutdown');
                    },
                    hide: function() {
                        intercomInstance('hide');
                    },
                    show: function() {
                        intercomInstance('Show');
                    }
                }; // end return
            }
        ]; // end $get
    });

}(angular.module('angular-intercom', []), angular);