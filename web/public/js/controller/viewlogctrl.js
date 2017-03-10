/**
 * Created by bhanu.mokkala on 1/24/2017.
 */
angular.module('seal')
    .controller('viewlogctrl', function($scope, $http, $timeout) {
    $scope.loading = true;
       (function tick() {
            $http.get('/logread')
                .then(function (data) {
                    var logdata = [];
                    var str;
                    for(var i=0; i<data.data.length;i++){
                        str = str + data.data[i] + "<br>";
                    }
                    logdata.push({'text':str});
                   // console.log(logdata);
                    $scope.loading = false;
                    $scope.filetext = logdata;
                }, function (error) {
                    console.log('Error: ' + error);
                });
            $timeout(tick, 5000);
        })();
    })
    .filter('highlight', function($sce) {
        return function(text, phrase) {
            if (phrase) text = text.replace(new RegExp('('+phrase+')', 'gi'),
                '<span class="highlighted">$1</span>')

            return $sce.trustAsHtml(text)
        }
    });