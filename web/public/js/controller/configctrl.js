/**
 * Created by bhanu.mokkala on 1/18/2017.
 */

angular.module('seal')
    .controller('configctrl', function($scope, $http) {
        $scope.updateresults = false;
        $scope.createevent = function() {
            $scope.loading = true;
            $http.get('/cevent')
                .then(function (data) {
                    $scope.loading = false;
                    $scope.updateresults = true;
                    $scope.updatemsg = data.data;
                    // console.log(data);
                    // console.log(filt);
                }, function (error) {
                    console.log('Error: ' + error);
                });
        }
    });