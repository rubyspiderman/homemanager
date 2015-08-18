homebinderControllers.controller('ShareFormCtrl', ['$scope', '$modalInstance', 'Binder', 'Share', 'Session', 'Intercom',
	function($scope, $modalInstance, Binder, Share, Session, Intercom) {
		$scope.form = {};
		$scope.form.role_name = 'reader';
		$scope.submit = function() {
			Share.create('binder', Binder.getCurrent().id, $scope.form).then(
				function(result) {
					$modalInstance.close();

                    // notify new event to intercom
                    Intercom.trackEvent("binder-shared", {
                        event_name: "binder-shared",
                        email: Session.getUser().email,
                        created_at: new Date().getTime()
                    });
				},
				function(error) {
					$scope.error = error.data;
				}
			);
		};
		$scope.cancel = function(){
			$modalInstance.dismiss('cancel');
		};
	}]);