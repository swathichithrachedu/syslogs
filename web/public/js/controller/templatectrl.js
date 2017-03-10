/**
 * Created by bhanu.mokkala on 1/19/2017.
 */
angular.module('seal')
    .controller('templatectrl', function($scope, $http) {
        $scope.loading = true;
        $scope.results = true;
        $scope.updateresults = false;
        $http.get('/getfiles')
            .then(function (data) {
               // console.log(data.data);
                $scope.loading = false;
                $scope.files = data.data;
                // console.log(filt);
            }, function (error) {
                console.log('Error: ' + error);
            });


        $scope.getfiletext = function(fname){
            var data = $.param({
                fname: fname
            });
            $scope.fname = fname;
            $http.get('/readfile?' + data)
                .then(function (data) {
                    console.log(data);
                    // console.log(filt);
                    $scope.results = false;
                    $scope.filetext = data.data;
                }, function (error) {
                    console.log('Error: ' + error);
                });
        };

        $scope.writefiletext = function(fname, ftext){
            console.log(fname + ftext);
            var data = $.param({
                fname: fname,
                ftext: ftext
            });
            $scope.fname = fname;
            $http.post('/writefile?' + data)
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
    });