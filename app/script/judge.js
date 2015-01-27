var gui = require('nw.gui');
var fs = require('fs');
var util = require('util');
var exec = require('child_process').exec;

//change directory settings per user platform
if (process.platform === 'darwin') {
    gui.Window.get().menu = new gui.Menu({ type: 'menubar' });
    //console.log('mac')
    baseDIR = process.env.HOME

} else if (process.platform === 'win32') {
    gui.Window.get().menu = new gui.Menu({ type: 'menubar' });
    //console.log('windows')
    baseDIR = process.env.HOME

} else {
    var user_menu = new gui.Menu({ type: 'menubar' });
    gui.Window.get().menu = user_menu;
    //console.log('not windows or mac')
    baseDIR = process.env.HOME
}

win = gui.Window.get();
var nativeMenuBar = new gui.Menu({ type: "menubar" });
try {
    nativeMenuBar.createMacBuiltin("fgdsb@Judge");
    win.menu = nativeMenuBar;
} catch (ex) {
    console.log(ex.message);
}

///////////////////////////////////////////////////////////////////////////

var beginsWith = function(needle, haystack){
    return (haystack.substr(0, needle.length) == needle);
}

var generate_cpp = function(problem, solution) {

    var out_file = "#include <vector>\n"
    out_file += "#include <string>\n"
    out_file += "#include <algorithm>\n"
    out_file += "#include <cstdlib>\n"

    out_file += "using namespace std;\n\n"

    out_file += "#include \"common.h\"\n";
    out_file += "#include \"tests/" + problem['id'] + ".h\"\n\n";

    out_file += solution + "\n\n";

    out_file += "int main() {\n";

    var indent = "    ";
    var indent2 = indent + indent;
    var indent3 = indent + indent + indent;

    // judge
    out_file += "\n" + indent;
    out_file += "cout.setf(ios::boolalpha);\n";
    out_file += "\n" + indent;
    out_file += "auto start = chrono::steady_clock::now();\n"
    out_file += "\n" + indent;
    out_file += "for(int i = 0; i < num_test; ++i) {\n";
    out_file += indent2;

    if(problem["ret_type_cpp"] != "void") {
        out_file += "auto answer = " + problem["judge_call"] + "(";
    } else {
        out_file += problem["judge_call"] + "(";
    }

    for(var i = 0; i < problem["in_type_cpp"].length; ++i) {
        if(i != 0) out_file += ",";
        out_file += "in_" + i + "[i]";
    }
    out_file += ");\n";

    if(problem["ret_type_cpp"] == "void") {
        out_file += indent2;
        out_file += "auto answer = in_0[i];\n";
    }

    out_file += indent2;

    if (problem['judge_type_cpp'] == 'equal') {
        out_file += "if(answer != out[i]) {\n";
    } else {
        out_file += "if(" + problem['judge_type_cpp'] + ") {\n";
    }

    out_file += indent3 + "cout << i+1 << \"/\" << num_test << \";\";\n"
    out_file += indent3 + "cout << ";
    for(var i = 0; i < problem["in_type_cpp"].length; ++i) {
        if(i != 0) out_file += " << + \", \" << ";
        out_file += "in_org_" + i + "[i]";
    }
    out_file += " << \";\";\n";

    out_file += indent3 + "cout << answer << \";\";\n"
    out_file += indent3 + "cout << out[i] << endl;\n"
    out_file += indent3 + "return 0;\n"
    out_file += indent2 + "}\n";

    out_file += indent;
    out_file += "}\n";

    // last
    out_file += indent + "auto elapsed = chrono::duration_cast<chrono::milliseconds>(chrono::steady_clock::now() - start);\n";
    out_file += indent + "cout << \"Accepted;\";\n"
    out_file += indent + "cout << elapsed.count() << endl;\n";

    out_file += indent + "return 0;\n"
    out_file += "}\n"
    return out_file;
};

var generate_java = function(problem, solution) {
    var out_file = "package judge;\nimport java.util.*;\nimport java.lang.*;\nimport java.io.*;\nimport tests.*;\n\n";
    var test_class = problem['id'].replace(new RegExp('-', 'g'), '_');

    out_file += "public class src {\n";
    out_file += solution + "\n\n";
    out_file += "public static void main (String[] args) throws java.lang.Exception {\n";

    var indent = "    ";
    var indent2 = indent + indent;
    var indent3 = indent + indent + indent;

    // judge
    out_file += "\n" + indent;
    out_file += "src s = new src();\n";
    out_file += "\n" + indent;
    out_file += "long startTime = System.currentTimeMillis();\n";
    out_file += "\n" + indent;
    out_file += "for(int i = 0; i < " + test_class + ".num_test; ++i) {\n";
    out_file += indent2;

    if(problem["ret_type_java"] != "void") {
        out_file += problem["ret_type_java"] + " answer = s." + problem["judge_call"] + "(";
    } else {
        out_file += "s." + problem["judge_call"] + "(";
    }

    for(var i = 0; i < problem["in_type_java"].length; ++i) {
        if(i != 0) out_file += ",";
        out_file += test_class + ".in_" + i + "[i]";
    }
    out_file += ");\n";

    if(problem["ret_type_java"] == "void") {
        out_file += indent2;
        out_file += problem["out_type_java"] + " answer = " + test_class + ".in_0[i];\n";
    }

    out_file += indent2;

    if (problem['judge_type_java'] == 'equal') {
        out_file += "if(answer != " + test_class + ".out[i]) {\n";
    } else {
        out_file += "if(" + problem['judge_type_java'] + ") {\n";
    }

    out_file += indent3 + "System.out.printf(\"%d / %d;\", i+1, " + test_class + ".num_test);\n"
    out_file += indent3 + "String outs = ";
    for(var i = 0; i < problem["in_type_java"].length; ++i) {
        if(i != 0) out_file += " + \", \" + ";
        out_file += "common.to_string(" + test_class + ".in_org_" + i + "[i])";
    }
    out_file += ";\n";
    out_file += indent3 + "System.out.print(outs + \";\");\n"

    out_file += indent3 + "System.out.print(common.to_string(answer) + \";\");\n"
    out_file += indent3 + "System.out.println(common.to_string(" + test_class + ".out[i]));\n"
    out_file += indent3 + "return;\n"
    out_file += indent2 + "}\n";

    out_file += indent;
    out_file += "}\n";

    // last
    out_file += indent + "long estimatedTime = System.currentTimeMillis() - startTime;\n";
    out_file += indent + "System.out.print(\"Accepted;\");\n"
    out_file += indent + "System.out.println(estimatedTime);\n"
    out_file += "}\n"

    out_file += "}\n";
    return out_file;
};

var generate_ruby = function(problem, solution) {
    var out_file = "require './judge/ruby/common'\n";
    out_file += "require './judge/ruby/tests/" + problem['id'] + "'\n\n";

    out_file += solution + "\n\n";

    var indent = "";
    var indent2 = "    ";
    var indent3 = "        ";

    // judge
    out_file += "\n" + indent;
    out_file += "start_time = Time.now\n";
    out_file += "\n" + indent;
    out_file += "(0...T_num_test).each do |i|\n";
    out_file += indent2;

    out_file += "answer = " + problem["judge_call"] + "(";

    for(var i = 0; i < problem["in_type_java"].length; ++i) {
        if(i != 0) out_file += ",";
        out_file += "T_in_" + i + "[i]";
    }
    out_file += ")\n";

    if(problem["ret_type_java"] == "void") {
        out_file += indent2;
        out_file += "answer = T_in_0[i];\n";
    }

    out_file += indent2;

    if (problem['judge_type_ruby'] == 'equal') {
        out_file += "if answer != T_out[i]\n";
    } else {
        out_file += "if " + problem['judge_type_ruby'] + "\n";
    }

    out_file += indent3 + "print \"#{i+1} / #{T_num_test};\"\n"
    for(var i = 0; i < problem["in_type_java"].length; ++i) {
        if(i != 0) out_file += "\n" + indent3 + "print ', '\n";
        out_file += indent3 + "print T_in_org_" + i + "[i]";
    }
    out_file += "\n";

    out_file += indent3 + "print ';'\n"
    out_file += indent3 + "print answer\n"
    out_file += indent3 + "print ';'\n"
    out_file += indent3 + "print T_out[i]\n"
    out_file += indent3 + "puts\n"
    out_file += indent3 + "exit\n"
    out_file += indent2 + "end\n";

    out_file += indent;
    out_file += "end\n";

    // last
    out_file += indent + "runtime = (Time.now - start_time) * 1000.0\n";
    out_file += indent + "puts('Accepted;' + runtime.to_i.to_s)\n"

    return out_file;
};

var generate_python = function(problem, solution) {
    var out_file = "import sys\nimport datetime\nfrom common import *\n";
    var test_class = problem['id'].replace(new RegExp('-', 'g'), '_');
    out_file += "from tests." + test_class + " import *\n\n"

    out_file += solution + "\n\n";

    var indent = "";
    var indent2 = "    ";
    var indent3 = "        ";

    // judge
    out_file += "\n" + indent;
    out_file += "start_time = datetime.datetime.now()\n"
    out_file += "\n" + indent;
    out_file += "for i in range(num_test):\n";
    out_file += indent2;

    out_file += "answer = " + problem["judge_call"] + "(";

    for(var i = 0; i < problem["in_type_java"].length; ++i) {
        if(i != 0) out_file += ",";
        out_file += "in_" + i + "[i]";
    }
    out_file += ")\n";

    if(problem["ret_type_java"] == "void") {
        out_file += indent2;
        out_file += "answer = in_0[i];\n";
    }

    out_file += indent2;

    if (problem['judge_type_python'] == 'equal') {
        out_file += "if answer != out[i] :\n";
    } else {
        out_file += "if " + problem['judge_type_python'] + ":\n";
    }

    out_file += indent3 + "out_str = \"\"\n"
    out_file += indent3 + "out_str += str(i+1) + \" / \" + str(num_test) + \";\"\n"

    for(var i = 0; i < problem["in_type_java"].length; ++i) {
        if(i != 0) {
            out_file += indent3 + "out_str += \", \"\n"
        }
        out_file += indent3 + "out_str += str(in_org_" + i + "[i])\n";
    }

    out_file += indent3 + "out_str += \";\"\n"
    out_file += indent3 + "out_str += str(answer)\n"
    out_file += indent3 + "out_str += \";\"\n"
    out_file += indent3 + "out_str += str(out[i])\n"
    out_file += indent3 + "print(out_str)\n"
    out_file += indent3 + "sys.exit(0)\n"

    // last
    out_file += indent + "delta = datetime.datetime.now() - start_time\n"
    out_file += indent + "runtime = str(int(delta.total_seconds() * 1000))\n"
    out_file += indent + "print('Accepted;' + runtime)\n"

    return out_file;
};

var judge_cpp = function($scope, callback, msg) {
    var cpp_out = generate_cpp($scope.problem, $scope.$editor.getValue());
    // write source
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
}

var judge_java = function($scope, callback, msg) {
    var java_out = generate_java($scope.problem, $scope.$editor.getValue());

    // write source
    fs.writeFile('judge/java/src.java', java_out, function (err) {
        if (err) {
            ret = { "result" : "Internal Error", "details" : err };
            callback(ret);
            return;
        }

        // compile
        var test_file_name = $scope.problem['id'].replace(new RegExp('-', 'g'), '_') + '.java';
        msg('Compiling');
        var cmd = 'javac -cp judge/java -d judge/java/. judge/java/common.java judge/java/src.java judge/java/tests/test_common.java ';
        cmd += "judge/java/tests/" + test_file_name;
        exec(cmd,
            function (error, stdout, stderr) {
                if(stderr != undefined && stderr != "") {
                    // Compile error
                    var errors = stderr.replace(new RegExp('judge/java/src.java:', 'g'), '');
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
                exec('java -cp judge/java judge/src',
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
}

var judge_ruby = function($scope, callback, msg) {
    var ruby_out = generate_ruby($scope.problem, $scope.$editor.getValue());

    // write source
    fs.writeFile('judge/ruby/src.rb', ruby_out, function (err) {
        if (err) {
            ret = { "result" : "Internal Error", "details" : err };
            callback(ret);
            return;
        }

        // judge
        msg('Judging');
        exec('ruby judge/ruby/src.rb',
            function (error, stdout, stderr) {
                if(stderr != undefined && stderr != "") {
                    // Compile error
                    var errors = stderr.replace(new RegExp('judge/ruby/src.rb:', 'g'), '');
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
    });
}

var judge_python = function($scope, callback, msg) {
    var py_out = generate_python($scope.problem, $scope.$editor.getValue());

    // write source
    fs.writeFile('judge/python/src.py', py_out, function (err) {
        if (err) {
            ret = { "result" : "Internal Error", "details" : err };
            callback(ret);
            return;
        }

        // judge
        msg('Judging');
        exec('python judge/python/src.py',
            function (error, stdout, stderr) {
                if(stderr != undefined && stderr != "") {
                    // Compile error
                    var errors = stderr.replace(new RegExp('File "judge/python/src.py", ', 'g'), '');
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
    });
}