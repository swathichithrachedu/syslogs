/**
 * Created by bhanu.mokkala on 1/19/2017.
 */
fs = require('fs');
http = require('http');
request = require('request');

exports.getlist = function(req1, res1) {
    var options = {
        "method": "GET",
        "hostname": "110.110.110.192",
        "port": "9000",
        "path": "/errorhandler",
        "headers": {
            "cache-control": "no-cache"
        }
    };

    var req = http.request(options, function (res) {
        var chunks = [];

        res.on("data", function (chunk) {
            chunks.push(chunk);
        });

        res.on("end", function () {
            var body = Buffer.concat(chunks);
            //console.log(body.toString());
            res1.send(body.toString());
        });
    });

    req.end();
};

exports.readfile = function(req1, res1) {
//console.log(req1.query.key + "/" + req1.query.value);
    var options = {
        "method": "GET",
        "hostname": "110.110.110.192",
        "port": "9000",
        "path": "/errorhandler/" + req1.query.key + "/" + req1.query.value,
        "headers": {
            "cache-control": "no-cache"
        }
    };

    var req = http.request(options, function (res) {
        var chunks = [];

        res.on("data", function (chunk) {
            chunks.push(chunk);
        });

        res.on("end", function () {
            var body = Buffer.concat(chunks);
            //console.log(body.toString());
            res1.send(body.toString());
        });
    });

    req.end();

};

exports.writefile = function(req1, res1) {
    //console.log(req1.query.group1);
    //console.log(req1.query.key1);
    var options = { method: 'POST',
        url: 'http://110.110.110.192:9000/errorhandler/'+req1.query.key1+'/'+req1.query.group1,
        headers:
            { 'postman-token': 'd2036c33-54bd-79e5-584b-13b154d78660',
                'cache-control': 'no-cache' },
        //body: '\r\n#!/usr/bin/expect -f\r\n\r\n# connect via scp\r\nspawn scp "wsadmin@10.20.48.121:/home/wsadmin/" /home/wsdamin/wslog-1383150043-278464-pid-495.log\r\n#######################1\r\nexpect {\r\n-re ".*es.*o.*" {\r\nexp_send "yes\\r"\r\nexp_continue\r\n}\r\n-re ".*sword.*" {\r\nexp_send "m@gicnoodl3s\\r"\r\n}\r\n}\r\ninteract\r\n' };
        body: req1.query.ftext};
    request(options, function (error, response, body) {
        if (error) throw new Error(error);

       // console.log(body);
        res1.send(body);
    });
};

exports.newwritefile = function(req1, res1) {
    //console.log(req1.query.group1);
    //console.log(req1.query.key1);
    var options = { method: 'POST',
        url: 'http://110.110.110.192:9000/errorhandler/'+req1.query.key1+'/'+req1.query.group1,
        headers:
            { 'postman-token': 'd2036c33-54bd-79e5-584b-13b154d78660',
                'cache-control': 'no-cache' },
        //body: '\r\n#!/usr/bin/expect -f\r\n\r\n# connect via scp\r\nspawn scp "wsadmin@10.20.48.121:/home/wsadmin/" /home/wsdamin/wslog-1383150043-278464-pid-495.log\r\n#######################1\r\nexpect {\r\n-re ".*es.*o.*" {\r\nexp_send "yes\\r"\r\nexp_continue\r\n}\r\n-re ".*sword.*" {\r\nexp_send "m@gicnoodl3s\\r"\r\n}\r\n}\r\ninteract\r\n' };
        body: req1.query.ftext};
    request(options, function (error, response, body) {
        if (error) throw new Error(error);

        //console.log(body);
        res1.send(body);
    });
};