/**
 * Created by bhanu.mokkala on 1/19/2017.
 */
fs = require('fs');

exports.getlist = function(req, res) {
   // console.log("here");
    //var files = fs.readdirSync('./Nagios');
    fs.readdir('./server/Nagios', function (err, files) {
        // "files" is an Array with files names
       // console.log(files);
       // console.log(err);
        res.send(files);
    });
};

exports.readfile = function(req, res) {

    fs.readFile('./server/Nagios/' + req.query.fname, 'utf8', function(err, fileContents) {
        if (err) throw err;
        res.send(fileContents);
    });

};

exports.writefile = function(req, res) {
/*
    fs.readFile('./server/Nagios/' + req.query.fname, 'utf8', function(err, fileContents) {
        if (err) throw err;
        res.send(fileContents);
    });*/
    fs.writeFile('./server/Nagios/' + req.query.fname, req.query.ftext, function(err) {
        if (err) throw err;
        res.send("Successfully updated file "+ req.query.fname);
    })

};