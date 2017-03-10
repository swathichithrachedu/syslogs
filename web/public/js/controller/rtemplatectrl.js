/**
 * Created by bhanu.mokkala on 1/19/2017.
 */
angular.module('seal')
    .controller('rtemplatectrl', function($scope, $http) {
        $scope.loading = true;
        $scope.results = true;
        $scope.updateresults = false;
        $scope.insertresults = false;
        $scope.newclick = true;
        $http.get('/remotegetfiles')
            .then(function (data) {
                //console.log(data.data);
                $scope.loading = false;
                $scope.files = data.data;
                // console.log(filt);
            }, function (error) {
                console.log('Error: ' + error);
            });


        $scope.getfiletext = function(key, value){
             var data = $.param({
                key: key,
                value: value
            });
            $scope.key = key;
            $scope.value = value;
            $http.get('/remotereadfile?' + data)
                .then(function (data) {
                    //console.log(data);
                    // console.log(filt);
                    $scope.results = false;
                    $scope.selectedIndex = 2;
                    $scope.updateresults = false;
                    $scope.filetext = data.data;
                }, function (error) {
                    console.log('Error: ' + error);
                });
        };

        $scope.writefiletext = function(group, key, ftext){
            console.log(key);
            var data = $.param({
                group1: group,
                key1: key,
                ftext: ftext
            });
            $scope.key = key;
            $http.post('/remotewritefile?' + data)
                .then(function (data) {
                    console.log(data);
                    // console.log(filt);
                    //$scope.results = false;
                    $scope.updateresults = true;
                    $scope.updatemsg = data.data;
                }, function (error) {
                    console.log('Error: ' + error);
                });
        };
        $scope.newscript = function () {
            $scope.newclick = false;
            $scope.selectedIndex = 3;
        }
        $scope.newwritefiletext = function(group, key, ftext){
            console.log(key);
            var data = $.param({
                group1: group,
                key1: key,
                ftext: ftext
            });
            $scope.key = key;
            $http.post('/newremotewritefile?' + data)
                .then(function (data) {
                    console.log(data);
                    // console.log(filt);
                    //$scope.results = false;
                    $scope.insertresults = true;
                    $scope.insertmsg = data.data;
                }, function (error) {
                    console.log('Error: ' + error);
                });
        };
    });