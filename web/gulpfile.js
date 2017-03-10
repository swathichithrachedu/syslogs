/**
 * Created by bhanu.mokkala on 1/18/2017.
 */
'use strict';

var gulp = require('gulp');
var browserSync = require('browser-sync');
var nodemon = require('gulp-nodemon');
//var historyApiFallback = require('connect-history-api-fallback');

gulp.task('default', ['browser-sync'], function () {
});

gulp.task('browser-sync', ['nodemon'], function() {
    browserSync.init(null, {
        proxy: "http://localhost:3300",
        files: ["public/**/*.*"],
        browser: "google chrome",
        port: 3300
    });
});
gulp.task('nodemon', function (cb) {

    var started = false;

    return nodemon({
        script: 'index.js'
    }).on('start', function () {
        // to avoid nodemon being started multiple times
        // thanks @matthisk
        if (!started) {
            cb();
            started = true;
        }
    });
});