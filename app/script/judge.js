var fs = require('fs');

var beginsWith = function(needle, haystack){
    return (haystack.substr(0, needle.length) == needle);
};

var generate_cpp = function(problem) {
    var out_file = "#include \"common.h\"\n";
    out_file += "#include \"solution.h\"\n";
    out_file += "#include \"tests/" + problem['id'] + ".h\"\n\n";
    out_file += "int main() {\n"
    out_file += "    judge();\n"
    out_file += "    return 0;\n"
    out_file += "}"
    return out_file;
};

var generate_java = function(problem) {
    var test_class = problem['id'].replace(new RegExp('-', 'g'), '_');

    var out_file = "package judge;\nimport java.util.*;\nimport java.lang.*;\nimport java.io.*;\nimport tests.test_common;\n";
    out_file += "import datastruct.*;\n";
    out_file += "import tests." + test_class + ";\n\n";

    out_file += "public class src {\n";

    out_file += "    public static void main (String[] args) throws java.lang.Exception {\n";
    out_file += "        " + test_class + ".judge();\n";
    out_file += "    }\n"

    out_file += "}\n";
    return out_file;
};

var generate_ruby = function(problem) {
    var out_file = "require './judge/ruby/common'\n";
    out_file += "require './judge/ruby/solution'\n";
    out_file += "require './judge/ruby/tests/" + problem['id'] + "'\n\n";

    out_file += "judge"

    return out_file;
};

var generate_python = function(problem) {
    var out_file = "from common import *\nfrom solution import *\n";
    var test_class = problem['id'].replace(new RegExp('-', 'g'), '_');
    out_file += "from tests." + test_class + " import *\n\n"

    out_file += "judge()";

    return out_file;
};

var generate_lua = function(problem) {

    var packpath = "package.path = package.path .. ';" + cur_dir + "/judge/lua/?.lua;'\n";

    var out_file = packpath + "require \"common\"\nrequire \"tests/" + problem['id'] + "\"\n";

    //out_file += "from tests." + test_class + " import *\n\n"

    out_file += "judge()";

    return out_file;
};

var judge_cpp = function($scope, callback, msg) {
    var cpp_out = generate_cpp($scope.problem);
    // write source
    fs.writeFile('judge/cpp/solution.h', $scope.$editor.getValue(), function (err) {
        if (err) {
            ret = {"result": "Internal Error", "details": err};
            callback(ret);
            return;
        }

        fs.writeFile('judge/cpp/src.cpp', cpp_out, function (err) {
            if (err) {
                ret = { "result" : "Internal Error", "details" : err };
                callback(ret);
                return;
            }
            // compile
            msg('Compiling');
            exec('clang++ -std=c++11 -stdlib=libc++ -w -Ofast judge/cpp/src.cpp -o judge/cpp/out',
                function (error, stdout, stderr) {
                    if(stderr != undefined && stderr != "") {
                        // Compile error
                        var errors = stderr.replace(new RegExp('judge/cpp/src.cpp:', 'g'), '');
                        var ret = { "result" : "Compile Error", "details" : errors };
                        callback(ret);
                        return;
                    }

                    if (error !== null) {
                        // Internal error
                        var ret = { "result" : "Internal Error", "details" : error };
                        callback(ret);
                        return;
                    }

                    msg('Judging');
                    // execute and judge
                    exec('judge/cpp/out',
                        function (error, stdout, stderr) {
                            if (error !== null) {
                                var ret = { "result" : "Runtime Error", "details" : error };
                                callback(ret);
                                return;
                            }
                            var results = stdout.trim();
                            if (beginsWith('Accepted', results)) {
                                var ret = { "result" : "Accepted", "runtime": results.split(";")[1]};
                                callback(ret);
                            } else {
                                var res = results.split(";");
                                var ret ={ "result" : "Wrong Answer", "tests": res[0], "input" : res[1], "output" : res[2], "expected" : res[3] };
                                callback(ret);
                            }
                        }
                    );
                }
            );
        });
    });
}

var judge_java = function($scope, callback, msg) {
    var java_out = generate_java($scope.problem);

    var class_name = $scope.problem['id'].replace(new RegExp('-', 'g'), '_');

    var solution_file = $scope.problem['class_name_java'];
    if (!solution_file) solution_file = 'Solution';
    solution_file += '.java';

    var solution = "package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; " + $scope.$editor.getValue();

    // write source
    fs.writeFile('judge/java/' + solution_file, solution, function (err) {
        if (err) {
            ret = {"result": "Internal Error", "details": err};
            callback(ret);
            return;
        }

        fs.writeFile('judge/java/src.java', java_out, function (err) {
            if (err) {
                ret = {"result": "Internal Error", "details": err};
                callback(ret);
                return;
            }

            // compile
            var test_file_name = class_name + '.java';
            msg('Compiling');
            var cmd = 'javac -Xlint:unchecked -cp judge/java -d judge/java/. judge/java/common.java judge/java/' + solution_file + ' judge/java/src.java judge/java/tests/test_common.java ';
            cmd += "judge/java/tests/" + test_file_name;
            exec(cmd,
                function (error, stdout, stderr) {
                    if (stderr != undefined && stderr != "") {
                        // Compile error
                        var errors = stderr.replace(new RegExp('judge/java/src.java:', 'g'), '');
                        var ret = {"result": "Compile Error", "details": errors};
                        callback(ret);
                        return;
                    }

                    if (error !== null) {
                        // Internal error
                        var ret = {"result": "Internal Error", "details": error};
                        callback(ret);
                        return;
                    }

                    msg('Judging');
                    // execute and judge
                    exec('java -cp judge/java judge/src',
                        function (error, stdout, stderr) {
                            if (error !== null) {
                                var ret = {"result": "Runtime Error", "details": error};
                                callback(ret);
                                return;
                            }
                            var results = stdout.trim();
                            if (beginsWith('Accepted', results)) {
                                var ret = {"result": "Accepted", "runtime": results.split(";")[1]};
                                callback(ret);
                            } else {
                                var res = results.split(";");
                                var ret = {
                                    "result": "Wrong Answer",
                                    "tests": res[0],
                                    "input": res[1],
                                    "output": res[2],
                                    "expected": res[3]
                                };
                                callback(ret);
                            }
                        }
                    );
                }
            );
        });
    });
}

var judge_ruby = function($scope, callback, msg) {
    var ruby_out = generate_ruby($scope.problem);

    fs.writeFile('judge/ruby/solution.rb', $scope.$editor.getValue(), function (err) {
        if (err) {
            ret = {"result": "Internal Error", "details": err};
            callback(ret);
            return;
        }

        // write source
        fs.writeFile('judge/ruby/src.rb', ruby_out, function (err) {
            if (err) {
                ret = {"result": "Internal Error", "details": err};
                callback(ret);
                return;
            }

            // judge
            msg('Judging');
            exec('ruby judge/ruby/src.rb',
                function (error, stdout, stderr) {
                    if (stderr != undefined && stderr != "") {
                        // Compile error
                        var errors = stderr.replace(new RegExp('judge/ruby/src.rb:', 'g'), '');
                        var ret = {"result": "Compile Error", "details": errors};
                        callback(ret);
                        return;
                    }

                    if (error !== null) {
                        // Internal error
                        var ret = {"result": "Internal Error", "details": error};
                        callback(ret);
                        return;
                    }

                    var results = stdout.trim();
                    if (beginsWith('Accepted', results)) {
                        var ret = {"result": "Accepted", "runtime": results.split(";")[1]};
                        callback(ret);
                    } else {
                        var res = results.split(";");
                        var ret = {
                            "result": "Wrong Answer",
                            "tests": res[0],
                            "input": res[1],
                            "output": res[2],
                            "expected": res[3]
                        };
                        callback(ret);
                    }
                }
            );
        });
    });
}

var judge_python = function($scope, callback, msg) {
    var py_out = generate_python($scope.problem);

    var sln = "from common import *\n" + $scope.$editor.getValue()
    // write source
    fs.writeFile('judge/python/solution.py', sln, function (err) {
        if (err) {
            ret = {"result": "Internal Error", "details": err};
            callback(ret);
            return;
        }
        fs.writeFile('judge/python/src.py', py_out, function (err) {
            if (err) {
                ret = {"result": "Internal Error", "details": err};
                callback(ret);
                return;
            }

            // judge
            msg('Judging');
            exec('python judge/python/src.py',
                function (error, stdout, stderr) {
                    if (stderr != undefined && stderr != "") {
                        // Compile error
                        var errors = stderr.replace(new RegExp('File "judge/python/src.py", ', 'g'), '');
                        var ret = {"result": "Compile Error", "details": errors};
                        callback(ret);
                        return;
                    }

                    if (error !== null) {
                        // Internal error
                        var ret = {"result": "Internal Error", "details": error};
                        callback(ret);
                        return;
                    }

                    var results = stdout.trim();
                    if (beginsWith('Accepted', results)) {
                        var ret = {"result": "Accepted", "runtime": results.split(";")[1]};
                        callback(ret);
                    } else {
                        var res = results.split(";");
                        var ret = {
                            "result": "Wrong Answer",
                            "tests": res[0],
                            "input": res[1],
                            "output": res[2],
                            "expected": res[3]
                        };
                        callback(ret);
                    }
                }
            );
        });
    });
}

var judge_lua = function($scope, callback, msg) {
    var py_out = generate_lua($scope.problem);

    // write source
    fs.writeFile('judge/lua/solution.lua', $scope.$editor.getValue(), function (err) {
        if (err) {
            ret = {"result": "Internal Error", "details": err};
            callback(ret);
            return;
        }
        fs.writeFile('judge/lua/src.lua', py_out, function (err) {
            if (err) {
                ret = {"result": "Internal Error", "details": err};
                callback(ret);
                return;
            }

            // judge
            msg('Judging');
            exec('lua judge/lua/src.lua',
                function (error, stdout, stderr) {
                    if (stderr != undefined && stderr != "") {
                        // Compile error
                        var errors = stderr;
                        var ret = {"result": "Compile Error", "details": errors};
                        callback(ret);
                        return;
                    }

                    if (error !== null) {
                        // Internal error
                        var ret = {"result": "Internal Error", "details": error};
                        callback(ret);
                        return;
                    }

                    var results = stdout.trim();
                    if (beginsWith('Accepted', results)) {
                        var ret = {"result": "Accepted", "runtime": results.split(";")[1]};
                        callback(ret);
                    } else {
                        var res = results.split(";");
                        var ret = {
                            "result": "Wrong Answer",
                            "tests": res[0],
                            "input": res[1],
                            "output": res[2],
                            "expected": res[3]
                        };
                        callback(ret);
                    }
                }
            );
        });
    });
}