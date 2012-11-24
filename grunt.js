module.exports = function(grunt) {

  grunt.loadNpmTasks('grunt-contrib');
  grunt.loadNpmTasks('grunt-coffee');

  // Project configuration.
  grunt.initConfig({
    pkg: '<json:package.json>',

    clean: {
      compiled: ['compiled'],
      production: ['production']
    },

    coffee: {
      grunt: {
        src: ["./grunt.coffee"],
        dest: "./",
        options: {
          bare: true
        }
      },
      classes: {
        src: ["lib/classes/*.coffee"],
        dest: "compiled/classes",
        options: {
          bare: true
        }
      },
      other: {
        src: ["lib/*.coffee"],
        dest: "compiled",
        options: {
          bare: true
        }
      }
    },

    concat: {
      all: {
        src: [
          "compiled/requires.js",
          "compiled/namespaces.js",
          "compiled/module.js",
          "compiled/classes/*.js",
          "compiled/exports.js"
        ],
        dest: "production/nicoscraper.js"
      }
    },

    test: {
      files: ['test/**/*.js']
    },

    watch: {
      files: '<config:lint.files>',
      tasks: 'default'
    },
  });

  // Default task.
  grunt.registerTask('default', 'build');

  grunt.registerTask('build', 'clean coffee concat');

};