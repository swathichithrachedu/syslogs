/**
 * Created by bhanu.mokkala on 1/18/2017.
 */
var express   = require("express");
//var mysql     = require('mysql');
var path      = require('path');

var app = express();
/*
 var server = require('http').Server(app);
 var io = require('socket.io')(server);
 */
//server.listen(80);

var bodyParser = require('body-parser');
var jsonParser = bodyParser.json();

var app = express();
clist = require('./server/nagios');
flist = require('./server/scripts');
rflist = require('./server/remotescripts');
wlog1 = require('./server/writelog');

app.get('/geth', clist.getlist);
app.post('/postparam', clist.postparam);
app.post('/postbody', clist.postbody);

app.get('/getfiles', flist.getlist);
app.get('/readfile', flist.readfile);
app.post('/writefile', flist.writefile);

app.get('/remotegetfiles', rflist.getlist);
app.get('/remotereadfile', rflist.readfile);
app.post('/remotewritefile', rflist.writefile);
app.post('/newremotewritefile', rflist.newwritefile);

app.post('/logpost', wlog1.postlog);
app.get('/logread', wlog1.readlog);
app.get('/cevent', wlog1.createevent);

app.use('/scripts', express.static(__dirname + '/node_modules/'));
app.use('/bower_components', express.static(__dirname + '/bower_components/'));

app.get("/",function(req,res){

    res.sendFile(path.join(__dirname + '/public/index.html'));
});

// Set port
port = process.env.PORT || 3300;

// Use public directory for static files
app.use(express.static(__dirname + '/public'));


// Include the routes module
//require('./app/routes')(app);

// Your code here
app.listen(port);



