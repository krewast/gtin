(function() {
    "use strict";

    // bridge between blanket.js and the grunt-blanket-qunit plugin reporter
    //
    // Copyright (C) 2013 Model N, Inc.
    // Distributed under the MIT License
    //
    // Documentation and full license available at:
    // https://github.com/ModelN/grunt-blanket-qunit

    // helper function for computing coverage info for a particular file
    var reportFile = function(data) {
        var ret = {
            coverage: 0,
            hits: 0,
            misses: 0,
            sloc: 0
        };
        for (var i = 0; i < data.source.length; i++) {
            var line = data.source[i];
            var num = i + 1;
            if (data[num] === 0) {
                ret.misses++;
                ret.sloc++;
            } else if (data[num] !== undefined) {
                ret.hits++;
                ret.sloc++;
            }
        }
        ret.coverage = ret.hits / ret.sloc * 100;

        return [ret.hits, ret.sloc];
    };

    // this function is invoked by blanket.js when the coverage data is ready.  it will
    // compute per-file coverage info, and send a message to the parent phantomjs process
    // for each file, which the grunt task will use to report passes & failures.
    var gruntReporter = function(coverageData) {
        var sortedFileNames = [];
        for (var filename in coverageData.files) {
            if (coverageData.files.hasOwnProperty(filename)) {
                sortedFileNames.push(filename);
            }
        }

        sortedFileNames.sort();
        for (var i = 0; i < sortedFileNames.length; i++) {
            var filename = sortedFileNames[i];
            var data = coverageData.files[filename];
            var report = reportFile(data);

            alert(JSON.stringify(["blanket:fileDone", report, filename]));
        }

        alert(JSON.stringify(["blanket:done"]));
    };

    // lcov reporter
    var lcovReporter = function(coverageData) {
        for (var filename in coverageData.files) {
            var data = coverageData.files[filename];
            var report = '';
            data.source.forEach(function(line, num) {
                // increase the line number, as JS arrays are zero-based
                num++;
                if (data[num] !== undefined) {
                    report += 'DA:' + num + ',' + data[num] + '\n';
                }
            });
            report += 'end_of_record\n';
            alert(JSON.stringify(['qunit.report', report, filename]));
        }
    };

    var mergeReporters = function(reporter1, reporter2) {
        return function(coverageData, options) {
            reporter1(coverageData, options);
            reporter2(coverageData, options);
        }
    }

    blanket.customReporter = mergeReporters(lcovReporter, gruntReporter);
})();
