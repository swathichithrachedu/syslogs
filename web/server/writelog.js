/**
 * Created by bhanu.mokkala on 1/18/2017.
 */
var http = require('http');
var https = require('https');
var fs = require('fs');
var request = require("request");
var ipadd = require('./ipaddr');

exports.postlog = function(req1, res1) {
//console.log(req1.query.log);
    var options = { method: 'POST',
      //  url: 'http://110.110.110.192:9000/writelog',
        url: 'http://' + ipadd.logip + ':9000/writelog',
        headers:
            { 'cache-control': 'no-cache' },
        body: req1.query.log };

    request(options, function (error, response, body) {
        if (error) throw new Error(error);

       // console.log(body);
    });
};

exports.readlog = function(req1, res1) {
    var options = { method: 'GET',
        url: 'http://' + ipadd.logip +':9001/readlog',
        headers:
            { 'cache-control': 'no-cache' },
        body: 'testing' };

    request(options, function (error, response, body) {
        if (error) throw new Error(error);
        var logarray = body.split(",");
        //console.log(logarray);
        res1.send(logarray);
    });

};

exports.createevent = function(req1, res1) {
    var options = { method: 'GET',
        url: 'http://' + ipadd.logip + ':9000/createevent',
        headers:
            { 'cache-control': 'no-cache' },
        body: 'testing' };

    request(options, function (error, response, body) {
        if (error) throw new Error(error);
//console.log(body);
        res1.send(body);
    });

};
