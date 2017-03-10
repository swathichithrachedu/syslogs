/**
 * Created by bhanu.mokkala on 1/18/2017.
 */
angular.module('seal')
    .controller('thresholdctrl', function($scope, $http) {
        var whole = [];
        var currentvalue="";
        $scope.loading = true;
        $scope.results = false;
        $http.get('/geth')
            .then(function (data) {
               whole = data.data;
                var filt = data.data.filter(function (el) {
                    return el.host_name != undefined
                });
                $scope.loading = false;
                $scope.params = filt;
            }, function (error) {
                console.log('Error: ' + data);
            });
        $scope.selected = {};
        $scope.getTemplate = function (param) {
            if (param.host_name === $scope.selected.host_name && param.service_description === $scope.selected.service_description) return 'edit';
            else return 'display';
        };

        $scope.editparam = function (param) {
            $scope.selected = angular.copy(param);
            currentvalue = param.check_command;
        };

        $scope.saveparam = function (param) {
            delete param.$$hashKey;
            //console.log(param);
/*
            var data = $.param({
                ngs_host_name: param.host_name,
                ngs_ser_des: param.service_description,
                ngs_use: param.use,
                ngs_check_command:param.check_command
            });
*/
            //findAndReplace(whole,currentvalue,param.check_command);

            var data = $.param({
                whole1: param
            });

            //$scope.writelog("SEAL Web: Updated threshold value " + param.check_command);
            $http.post('/postbody?' + data)
                .then(function (result) {
                   // console.log(result.data.results[0]['200']);
                    $scope.results = true;
                    $scope.msg = result.data.results[0]['200'];

                });
            //console.log(whole);*/

            $scope.reset();
        };

        $scope.reset = function () {
            $scope.selected = {};
        };

        function findAndReplace(object,keyvalue, name) {
            /*
            object.map(function (a) {
                if (a.check_command == keyvalue) {
                    a.check_command = name
                }

            })*/
            for(var i = 0;i<object.length;i++)
            {
                Object.keys(object[i]).forEach(function(key){
                    if(keys.indexOf(key) == -1)
                    {
                        keys.push(key);
                    }
                });
                console.log(keys);
            }
        }

        $scope.writelog = function (wlog){
           // console.log("here");
            var data1 = $.param({
                log: wlog
            });
            $http.post('/logpost?' + data1)
                .then(function (result1) {
                    // console.log(result.data.results[0]['200']);
                    console.log(result1);
                });

        }
    });