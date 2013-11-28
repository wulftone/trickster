module.exports = function(grunt) {

  grunt.loadNpmTasks('grunt-mocha-test');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-browserify');

  grunt.registerTask('default', 'mochaTest');

  grunt.initConfig({

    mochaTest: {
      test: {
        options: {
          reporter: 'spec',
          growl: true,
          require: 'coffee-script'
        },
        src: ['test/**/*.js','test/**/*.coffee']
      }
    },

    watch: {
      files: ['**/*'],
      tasks: ['mochaTest'],
    },

    browserify: {
      dist: {
        files: {
          'dist/bundle.js': ['src/prob.coffee'],
        },
        options: {
          transform: ['coffeeify'],
          standalone: 'Trickster'
        }
      }
    }
  });

};
