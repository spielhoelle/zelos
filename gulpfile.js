'use strict';

const gulp = require('gulp');
const bs = require('browser-sync').create(); // create a browser sync instance.

var setupWatchers = function() {
  gulp.watch(['./app/views/**/*.haml',
    './app/assets/javascripts/**/*.js'], ['reload']);
  gulp.watch(['./app/assets/stylesheets/**/*.sass'], ['reloadCSS'])
};

gulp.task('reload', function(){
  return bs.reload();
});

gulp.task('reloadCSS', function() {
  return bs.reload('*.css');
});

gulp.task('init', function() {
  bs.init({
    proxy: {
      target: "localhost:3000",
      proxyReq: [
        function(proxyReq) {
          proxyReq.setHeader('X-Forwarded-Host', 'localhost:8000');
        }
      ],
    },
    port: 8000,
    open: false,
    ui: {
      port: 8001
    },
    snippetOptions: {
      rule: {
        match: /<\/head>/i,
        fn: function (snippet, match) {
          return snippet + match;
        }
      }
    },
  });

  setupWatchers();
});

gulp.task('bs', ['init']);
