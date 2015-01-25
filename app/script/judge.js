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

var generate_cpp = function(problem, solution) {
    var out_file = "#include \"common.h\"\n\n";
    out_file += solution + "\n\n";

    out_file += "int main() {\n";

    var indent = "    ";
    var indent2 = indent + indent;
    var indent3 = indent + indent + indent;

    var num_test = problem["test_in"].length;
    var num_outs = problem["test_out"].length;

    // number of test
    out_file += indent;
    out_file += "const int num_test = " + num_test + ";\n";

    // inputs
    for(var i = 0; i < problem["in_type_cpp"].length; ++i) {
        out_file += indent;
        out_file += "vector<" + problem["in_type_cpp"][i] + "> in_" + i + " = {";
        for(var j = 0; j < num_test; ++j) {
            if(j != 0) out_file += ",";
            out_file += problem["test_in"][j][i];
        }
        out_file += "};\n";
    }
    for(var i = 0; i < problem["in_type_cpp"].length; ++i) {
        out_file += indent;
        out_file += "vector<" + problem["in_type_cpp"][i] + "> in_org_" + i + " = {";
        for(var j = 0; j < num_test; ++j) {
            if(j != 0) out_file += ",";
            out_file += problem["test_in"][j][i];
        }
        out_file += "};\n";
    }

    // outputs
    out_file += indent;
    out_file += "vector<" + problem["out_type_cpp"] + "> out = {";
    for(var i = 0; i < num_outs; ++i) {
        if(i != 0) out_file += ",";
        out_file += problem["test_out"][i];
    }
    out_file += "};\n";

    // judge
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

    out_file += indent3 + "cout << i+1 << \"/\" << num_test << \";\";"
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
    out_file += indent + "cout << \"Accepted\" << endl;\n"
    out_file += indent + "return 0;\n"
    out_file += "}\n"
    return out_file;
};

var generate_java = function(problem, solution) {
    var out_file = "package judge;\nimport java.util.*;\nimport java.lang.*;\nimport java.io.*;\n\n";

    out_file += "public class src {\n";

    out_file += solution + "\n\n";

    out_file += "public static void main (String[] args) throws java.lang.Exception {\n";

    var indent = "    ";
    var indent2 = indent + indent;
    var indent3 = indent + indent + indent;

    var num_test = problem["test_in"].length;
    var num_outs = problem["test_out"].length;

    // number of test
    out_file += indent;
    out_file += "final int num_test = " + num_test + ";\n";
    out_file += indent;
    out_file += "src s = new src();\n";

    // inputs
    for(var i = 0; i < problem["in_type_java"].length; ++i) {
        out_file += indent;
        out_file += problem["in_type_java"][i] + "[] in_" + i + " = {";
        for(var j = 0; j < num_test; ++j) {
            if(j != 0) out_file += ",";
            out_file += problem["test_in"][j][i];
        }
        out_file += "};\n";
    }
    for(var i = 0; i < problem["in_type_java"].length; ++i) {
        out_file += indent;
        out_file += problem["in_type_java"][i] + "[] in_org_" + i + " = {";
        for(var j = 0; j < num_test; ++j) {
            if(j != 0) out_file += ",";
            out_file += problem["test_in"][j][i];
        }
        out_file += "};\n";
    }

    // outputs
    out_file += indent;
    out_file += problem["out_type_java"] + "[] out = {";
    for(var i = 0; i < num_outs; ++i) {
        if(i != 0) out_file += ",";
        out_file += problem["test_out"][i];
    }
    out_file += "};\n";

    // judge
    out_file += "\n" + indent;
    out_file += "for(int i = 0; i < num_test; ++i) {\n";
    out_file += indent2;

    if(problem["ret_type_java"] != "void") {
        out_file += problem["ret_type_java"] + " answer = s." + problem["judge_call"] + "(";
    } else {
        out_file += "s." + problem["judge_call"] + "(";
    }

    for(var i = 0; i < problem["in_type_java"].length; ++i) {
        if(i != 0) out_file += ",";
        out_file += "in_" + i + "[i]";
    }
    out_file += ");\n";

    if(problem["ret_type_java"] == "void") {
        out_file += indent2;
        out_file += problem["out_type_java"] + " answer = in_0[i];\n";
    }

    out_file += indent2;

    if (problem['judge_type_java'] == 'equal') {
        out_file += "if(answer != out[i]) {\n";
    } else {
        out_file += "if(" + problem['judge_type_java'] + ") {\n";
    }

    out_file += indent3 + "System.out.printf(\"%d / %d;\", i+1, num_test);\n"
    out_file += indent3 + "String outs = ";
    for(var i = 0; i < problem["in_type_java"].length; ++i) {
        if(i != 0) out_file += " + \", \" + ";
        out_file += "common.to_string(in_org_" + i + "[i])";
    }
    out_file += ";\n";
    out_file += indent3 + "System.out.print(outs + \";\");\n"

    out_file += indent3 + "System.out.print(common.to_string(answer) + \";\");\n"
    out_file += indent3 + "System.out.println(common.to_string(out[i]));\n"
    out_file += indent3 + "return;\n"
    out_file += indent2 + "}\n";

    out_file += indent;
    out_file += "}\n";

    // last
    out_file += indent + "System.out.println(\"Accepted\");\n"
    out_file += "}\n"

    out_file += "}\n";
    return out_file;
};

var generate_ruby = function(problem, solution) {
    var out_file = "require './judge/ruby/common'\n\n";

    out_file += solution + "\n\n";

    var indent = "";
    var indent2 = "    ";
    var indent3 = "        ";

    var num_test = problem["test_in"].length;
    var num_outs = problem["test_out"].length;

    // number of test
    out_file += "num_test = " + num_test + ";\n";

    var var_decl = ""
    // inputs
    for(var i = 0; i < problem["in_type_java"].length; ++i) {
        var_decl += indent;
        var_decl += "in_" + i + " = [";
        for(var j = 0; j < num_test; ++j) {
            if(j != 0) var_decl += ",";
            var_decl += problem["test_in"][j][i];
        }
        var_decl += "]\n";
    }
    for(var i = 0; i < problem["in_type_java"].length; ++i) {
        var_decl += indent;
        var_decl += "in_org_" + i + " = [";
        for(var j = 0; j < num_test; ++j) {
            if(j != 0) var_decl += ",";
            var_decl += problem["test_in"][j][i];
        }
        var_decl += "]\n";
    }

    // outputs
    var_decl += indent;
    var_decl += "out = [";
    for(var i = 0; i < num_outs; ++i) {
        if(i != 0) var_decl += ",";
        var_decl += problem["test_out"][i];
    }
    var_decl += "]\n";

    var_decl = var_decl.replace(new RegExp('{', 'g'), '[');
    var_decl = var_decl.replace(new RegExp('}', 'g'), ']');
    out_file += var_decl

    // judge
    out_file += "\n" + indent;
    out_file += "(0...num_test).each do |i|\n";
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

    if (problem['judge_type_ruby'] == 'equal') {
        out_file += "if answer != out[i]\n";
    } else {
        out_file += "if " + problem['judge_type_ruby'] + "\n";
    }

    out_file += indent3 + "print \"#{i+1} / #{num_test};\"\n"
    for(var i = 0; i < problem["in_type_java"].length; ++i) {
        if(i != 0) out_file += "\n" + indent3 + "print ', '\n";
        out_file += indent3 + "print in_org_" + i + "[i]";
    }
    out_file += "\n";

    out_file += indent3 + "print ';'\n"
    out_file += indent3 + "print answer\n"
    out_file += indent3 + "print ';'\n"
    out_file += indent3 + "print out[i]\n"
    out_file += indent3 + "puts\n"
    out_file += indent3 + "exit\n"
    out_file += indent2 + "end\n";

    out_file += indent;
    out_file += "end\n";

    // last
    out_file += indent + "puts('Accepted')\n"

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
                var before_time = new Date().getTime();
                // execute and judge
                exec('judge/cpp/out',
                    function (error, stdout, stderr) {
                        var runtime = new Date().getTime() - before_time;
                        if (error !== null) {
                            var ret = { "result" : "Runtime Error", "details" : error };
                            callback(ret);
                            return;
                        }
                        var results = stdout.trim();
                        if(results == "Accepted") {
                            var ret = { "result" : "Accepted", "runtime": runtime};
                            callback(ret);
                        } else {
                            var res = results.split(";");
                            var ret ={ "result" : "Wrong Answer", "input" : res[1], "output" : res[2], "expected" : res[3] };
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
        msg('Compiling');
        exec('javac -cp judge/java -d judge/java/. judge/java/common.java judge/java/src.java',
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
                var before_time = new Date().getTime();
                // execute and judge
                exec('java -cp judge/java judge/src',
                    function (error, stdout, stderr) {
                        var runtime = new Date().getTime() - before_time;
                        if (error !== null) {
                            var ret = { "result" : "Runtime Error", "details" : error };
                            callback(ret);
                            return;
                        }
                        var results = stdout.trim();
                        if(results == "Accepted") {
                            var ret = { "result" : "Accepted", "runtime": runtime};
                            callback(ret);
                        } else {
                            var res = results.split(";");
                            var ret ={ "result" : "Wrong Answer", "input" : res[1], "output" : res[2], "expected" : res[3] };
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
        var before_time = new Date().getTime();
        exec('ruby judge/ruby/src.rb',
            function (error, stdout, stderr) {
                var runtime = new Date().getTime() - before_time;
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
                if(results == "Accepted") {
                    var ret = { "result" : "Accepted", "runtime": runtime};
                    callback(ret);
                } else {
                    var res = results.split(";");
                    var ret ={ "result" : "Wrong Answer", "input" : res[1], "output" : res[2], "expected" : res[3] };
                    callback(ret);
                }
            }
        );
    });
}

var judge_python = function($scope, callback, msg) {

}