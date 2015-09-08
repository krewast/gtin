var path = require('path');

module.exports = function(grunt) {
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        concat: {
            options: {
                separator: ';'
            },
            dist: {
                src: [
                    'src/main/js/gtin_format_error.js',
                    'src/main/js/gtin_format.js',
                    'src/main/js/gtin.js',
                    'src/main/js/exports.js'
                ],
                dest: 'dist/<%= pkg.name.replace(".js", "") %>.js'
            }
        },
        uglify: {
            options: {
                banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> */\n'
            },
            dist: {
                files: {
                    'dist/<%= pkg.name.replace(".js", "") %>.min.js': ['<%= concat.dist.dest %>']
                }
            }
        },
        blanket_qunit: {
            all: {
                options: {
                    urls: [
                        'src/test/html/exports_test.html?coverage=true&grunt',
                        'src/test/html/gtin_format_test.html?coverage=true&grunt',
                        'src/test/html/gtin_test.html?coverage=true&grunt'
                    ],
                    threshold: 95
                }
            }
        },
        coveralls: {
            all: {
                src: './build/coverage-results/all.lcov'
            }
        },
        jshint: {
            files: ['Gruntfile.js', 'src/**/*.js']
        },
        watch: {
            files: ['<%= jshint.files %>'],
            tasks: ['jshint']
        }
    });

    grunt.event.on('qunit.report', function(data, filename) {
        var cleanFilename = filename.replace('file://', '').replace(/^\/([A-Z]{1}:\/)/, '$1');
        var relativeFilename = path.relative(process.cwd(), cleanFilename).split(path.sep).join('/');
        var coverageFilename = filename.indexOf('/') > 0 ? filename.substring(filename.lastIndexOf('/') + 1) : filename;
        var report = 'SF:' + relativeFilename + '\n' + data;

        grunt.file.write('./build/coverage-results/' + coverageFilename + '.lcov', report);
    });

    grunt.task.registerTask('lcov_aggregate', 'Aggregates separate lcov files into one single file.', function() {
        var files = grunt.file.expand('./build/coverage-results/*.lcov');
        var report = '';
        for (var i = 0; i < files.length; i++) {
            var filename = files[i];
            if (filename.match('all.lcov$') === null) {
                report += grunt.file.read(filename);
            }
        }

        grunt.file.write('./build/coverage-results/all.lcov', report);
    });

    grunt.loadNpmTasks('grunt-blanket-qunit');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-coveralls');

    grunt.registerTask('clean', []);
    grunt.registerTask('test', ['concat', 'blanket_qunit']);
    grunt.registerTask('build', ['concat', 'blanket_qunit', 'jshint', 'uglify']);
    grunt.registerTask('coverage', ['lcov_aggregate', 'coveralls']);
    grunt.registerTask('default', ['clean', 'build']);
};
