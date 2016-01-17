module.exports = function (grunt) {
  'use strict';

  grunt.config.merge({
    coffeelint: {
      options: {
        'max_line_length': {
          level: 'ignore'
        }
      },
      app: ['<%= paths.app %>/**/*.coffee']
    },
    jshint: {
      options: {
        jshintrc: true
      },
      grunt: ['Gruntfile.js', '<%= paths.gruntTasks %>/**/*.js']
    }
  });

};
