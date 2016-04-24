var gulp = require('gulp');
var watch = require('gulp-watch');
var browserSync = require('browser-sync');
var exec = require('child_process').exec;
var app = require('./app.js');

gulp.task('app', [], function(){
  app.init(function(opts){
    browserSync.init(null, {
      proxy: opts.url,
      files: [
        './public/views/**/*.hbs',
        './public/js/**/*.js'
      ],
      browser: opts.browser,
      port: opts.port
    });
    
    watch(
      [
        './public/tags/**/*.tag'
      ],
      {
        events: ['add', 'change'],
        name: '[Riot compile]'
      },
      function(file){
        app.util.compileRiotTags(function(){});
      }
    );
  });
});

gulp.task('default', [], function(){
  var cmds = "\n\n"
    +" Available commands:\n"
    +"\n"
    +" gulp app \n";
});