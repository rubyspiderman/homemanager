homebinderControllers.controller('NewTransferCtrl', ['$scope', '$injector', 'Session', 'Intercom',
	function($scope, $injector, Session, Intercom){
		var $routeParams = $injector.get('$routeParams');
		var binderId = $routeParams['binderId'];
		$scope.data = {};
		$scope.data.invalid = true;
		$scope.data.binder_url = "#/binders/" + binderId;
		$scope.data.transferType = 'ownership';
		
		$scope.transfer = function() {
            var data = {
				binder_id: binderId,
				transfer_to: $scope.data.transferTo,
				transfer_type: $scope.data.transferType
			};
			
			var Transfer = $injector.get('Transfer');
			Transfer.create(data).success(function(result) {
					$scope.$emit('global.showModal', {
						title: 'Transfer Successful',
						minorMessage: 'Your binder has been transfered to ' + data.transfer_to,
						buttons: [
							{
								label: 'OK',
								isPrimary: true,
								action: 'close',
								result: 'ok',
							}
						],
						confirm: function(){
							var $location = $injector.get('$location');
							if (data.transfer_type == 'ownership') {
								$location.path('/binders/');
							} else {
								$location.path('/binders/' + binderId);
							}
						}
					});

                    // notify new event to intercom
                    Intercom.trackEvent("binder-transferred", {
                        event_name: "binder-transferred",
                        email: Session.getUser().email,
                        created_at: new Date().getTime()
                    });
				}).error(function(error) {
					$scope.data.error = error;
				});
        }
	}]);