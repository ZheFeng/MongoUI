'use strict';

module.exports = function (grunt) {
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    clean: {
      front: [
        './app/public/html',
        './app/public/js',
        './app/public/js.src',
        './app/public/css'
      ],
      server: ['./app/server']
    },
    coffee: {
      server: {
        options: {
          bare: true
        },
        expand: true,
        cwd: 'coffee.server',
        src: ['**/*.coffee'],
        dest: './app/server',
        ext: '.js'
      },
      angular: {
        options: {
          join: true,
          bare: false
        },
        files: {
          './app/public/js.src/mongoui.js': [
            './coffee.front.angular/mongoUi/init.coffee',
            './coffee.front.angular/mongoUi/services.coffee',
            './coffee.front.angular/mongoUi/factories.coffee',
            './coffee.front.angular/mongoUi/filters.coffee',
            './coffee.front.angular/mongoUi/directives.coffee',
            './coffee.front.angular/mongoUi/controllers.coffee',
            './coffee.front.angular/mongoUi/configs.coffee',
            './coffee.front.angular/mongoUi/main.coffee'
          ] // concat then compile into single file
        }
      }
    },
    uglify: {
      front: {
        options: {
          banner: '/*<%= grunt.template.today("yyyy-mm-dd") %> */',
          mangle: true,
          beautify: false,
          // sourceMapRoot: '/',
          // sourceMap: function(path) { return path.replace(/.min.js/,".min.js.map"); },
          // sourceMappingURL: function(path) { return  path.replace(/app\/public/,"").replace(/.min.js/,".min.js.map"); },
          // sourceMapPrefix: 2
        },
        expand: true,
        cwd: './app/public/js.src',
        src: ['**/*.js'],
        dest: './app/public/js',
        ext: '.min.js'
      }
    },
    jade: {
      html: {
        options: {
          pretty: true
        },
        expand: true,
        cwd: 'jade',
        src: ['**/*.jade'],
        dest: './app/public/html',
        ext: '.html'
      }
    },
    less: {
      minCss: {
        options: {
          compress: true,
          yuicompress: true
        },
        expand: true,
        cwd: 'less',
        src: ['**/*.less'],
        dest: './app/public/css',
        ext: '.min.css'
      },
      css: {
        options: {
          compress: false,
          yuicompress: false
        },
        expand: true,
        cwd: 'less',
        src: ['**/*.less'],
        dest: './app/public/css',
        ext: '.css'
      }
    },
    develop: {
      server: {
        nodeArgs: ['--debug'],
        file: 'app/server/app.js',
        env: { 
          NODE_ENV: 'development',
        }
      }
    },
    regarde: {
      server: {
        files: [
          'coffee.server/**/*.coffee'
        ],
        tasks: ['compileServer','develop', 'delayed-livereload']
      },
      front: {
        files: [
          'coffee.front.angular/**/*.coffee',
          'less/**/*.less',
          'jade/**/*.jade'
        ],
        tasks: ['compileFront','livereload']
      },
      jade: {
        files: ['app/views/**/*.jade'],
        tasks: ['livereload']
      }
    }
  });
  grunt.registerTask('delayed-livereload', 'delayed livereload', function () {
    var done = this.async();
    setTimeout(function () {
      grunt.task.run('livereload');
      done();
    }, 500);
  });

  grunt.registerTask('compileFront', ['clean:front', 'coffee:angular','uglify', 'jade','less']);
  grunt.registerTask('compileServer', ['clean:server', 'coffee:server','develop']);


  grunt.registerTask('default', ['compileFront', 'compileServer','livereload-start','regarde']);
};
