var gulp = require('gulp'),
  uglify = require('gulp-uglify'),
  rename = require('gulp-rename'),
  concat = require('gulp-concat'),
  header = require('gulp-header'),
  sass = require('gulp-sass'),
  pkg = require('./package.json'),
  minifyCSS = require('gulp-clean-css'),
  watch = require('gulp-watch'),
  sourcemaps = require('gulp-sourcemaps'),
  autoprefix = require('gulp-autoprefixer'),
  plumber = require('gulp-plumber'),
  config = require('./config.json');
  Promise = require('es6-promise').Promise;

gulp.task('scripts', function() {
  gulp.src(config.js.src)
    .pipe(sourcemaps.init(config.sourcemaps))
    .pipe(plumber())
    .pipe(uglify())
    .pipe(rename({suffix: '.min'}))
    .pipe(header('/*! <%= pkg.name %> <%= pkg.version %> */\n', {pkg: pkg} ))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest(config.js.dest));
});

gulp.task('fonts', function() {
  gulp.src(config.fonts.src)
    .pipe(gulp.dest(config.fonts.dest));
});

gulp.task('images', function() {
  gulp.src(config.images.src)
    .pipe(gulp.dest(config.images.dest));
});

gulp.task('css', function() {
  gulp.src(config.css.src)
    .pipe(sourcemaps.init(config.sourcemaps))
    .pipe(sass(config.sass))
    .on("error", function(error) {
      console.log(error.formatted);
    })
    .pipe(minifyCSS({keepBreaks:false}))
    .pipe(rename({suffix: '.min'}))
    .pipe(header('/*! <%= pkg.name %> <%= pkg.version %> */\n', {pkg: pkg} ))
    .pipe(sourcemaps.write())
    .pipe(autoprefix('last 4 versions', '> 1%', 'ie 9', 'ie 10'))
    .pipe(gulp.dest(config.css.dest));
});

gulp.task('watcher', ['css', 'scripts', 'fonts'], function() {
  gulp.watch(config.js.src, ['scripts']);
  gulp.watch(config.css.src, ['css']);
  gulp.watch(config.images.src, ['images']);
});

gulp.task('default', ['scripts', 'images', 'fonts', 'css']);
gulp.task('build', ['default']);
gulp.task('watch', ['watcher']);
