path = require 'path'
gulp = require 'gulp'
$run = require 'run-sequence'
gutil = require 'gulp-util'

$ = require('gulp-load-plugins')({
    lazy: no
})

paths =
    scripts: [
        './coffee/**/*.coffee'
    ]

gulp.task 'coffee', (done) ->
    gulp.src(paths.scripts)
        .pipe($.coffee(bare: yes).on('error', gutil.log))
        .pipe(gulp.dest('./'))
        .pipe($.size(showFiles: true))
    #.on('end', done)

gulp.task 'watch', ->
    gulp.watch(paths.scripts, ['coffee'])

gulp.task 'build', (callback) ->
    $run "coffee", callback
