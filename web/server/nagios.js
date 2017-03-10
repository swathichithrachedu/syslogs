/**
 * Created by bhanu.mokkala on 1/18/2017.
 */
var http = require('http');
var https = require('https');
var querystring = require('querystring');
var fs = require('fs');
var request = require("request");
var ipadd = require('./ipaddr');
exports.getlist = function(req, res) {

    var options = {
        "method": "GET",
     //   "hostname": "110.110.110.236",
        "hostname": ipadd.ip,
        "port": "5000",
        "path": "/service",
        "headers": {
            "authorization": "Basic YWRtaW46cGFzc3dvcmQ=",
            "cache-control": "no-cache"
        }
    };

    http.get(options, function(res1) {
        //console.log("Got response: " + res.statusCode);
        var results = "";
        res1.on("data", function(chunk) {
            //console.log("BODY: " + chunk);
            results += chunk;
        });
        res1.on('end', function(){
            //console.log(results);
            res.send(results);
        });
    }).on('error', function(e) {
        console.log("Got error: " + e.message);
    });

};

exports.postparam = function(req1, res1) {
    var options = {
        method: 'POST',
   //     url: 'http://110.110.110.236:5000/service',
        url: 'http://' + ipadd.ip +':5000/service',
        headers: {
            'cache-control': 'no-cache',
            authorization: 'Basic YWRtaW46cGFzc3dvcmQ=',
            'content-type': 'application/json'
        },
        body: [{
            service_description: req1.query.ngs_ser_des,
            use: req1.query.ngs_use,
            check_command: req1.query.ngs_check_command,
            host_name: req1.query.ngs_host_name
        }],
        json: true
    };

    request(options, function (error, response, body) {
        if (error) throw new Error(error);
            reloadnagios();
            res1.send(body);
        //console.log(body);
    });
};

exports.postbody = function(req1, res1) {
    //console.log(req1.query.whole1);
    var options = {
        method: 'POST',
        url: 'http://' + ipadd.ip +':5000/service',
        headers: {
            'cache-control': 'no-cache',
            authorization: 'Basic YWRtaW46cGFzc3dvcmQ=',
            'content-type': 'application/json'
        },
        body: req1.query.whole1,
        json: true
    };

    request(options, function (error, response, body) {
        if (error) throw new Error(error);
        reloadnagios();
        res1.send(body);
        //console.log(body);
    });
};

function reloadnagios(){
    var options = {
        method: 'POST',
      //  url: 'http://110.110.110.236:5000/control?restart',
        url: 'http://' + ipadd.ip +':5000/control?restart',
        headers: {
            'cache-control': 'no-cache',
            authorization: 'Basic YWRtaW46cGFzc3dvcmQ=',
            'content-type': 'application/json'
        },
        json: true
    };

    request(options, function (error, response, body) {
        if (error) throw new Error(error);
        //console.log(body);
    });
}