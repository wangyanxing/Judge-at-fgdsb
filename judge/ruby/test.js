fs = require('fs');

var problem = {
    "name" : "Two Difference",
    "discuss_link" : "http://www.fgdsb.com/2015/01/06/two-difference/",
    "desc" : "<p>有序数组中都是正数且为unique number，找出两个数A、B，so that A-B = 一个给定的数C。要求使用常数空间和O(N)时间。</p>",
    "code_cpp" : "vector<int> two_dif(vector<int>& A, int target) {\n}",
    "code_java" : "int[] two_dif(int[] A, int target) {\n}",

    "in_type_cpp" : ["vector<int>", "int"],
    "ret_type_cpp" : "vector<int>",
    "out_type_cpp" : "vector<int>",
    "judge_type_cpp" : "abs(in_0[i][answer[0]] - in_0[i][answer[1]]) != in_1[i]",

    "in_type_java" : ["int[]", "int"],
    "ret_type_java" : "int[]",
    "out_type_java" : "int[]",
    "judge_type_java" : "abs(in_0[i][answer[0]] - in_0[i][answer[1]]) != in_1[i]",

    "judge_type_ruby" : "(in_0[i][answer[0]] - in_0[i][answer[1]]).abs != in_1[i]",

    "judge_call" : "two_dif",
    "test_in" : [
            ["{1, 2, 3}", 2],
            ["{1, 3, 5, 7, 9}", 6],
            ["{9, 7, 4, 8, 1}", 3]
        ],
    "test_out" : ["{0, 2}","{0, 3}","{2, 4}"]
};

var solution = "def two_dif(arr, target)\n    [0,0]\nend"

var generate_ruby = function(problem, solution) {
    var out_file = "require './common'\n\n";

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
        out_file += indent3 + "print in_" + i + "[i]";
    }
    out_file += "\n";    

    out_file += indent3 + "print ';'\n"
    out_file += indent3 + "print answer\n"
    out_file += indent3 + "print ';'\n"
    out_file += indent3 + "print out[i]\n"
    out_file += indent3 + "puts\n"
    out_file += indent3 + "exit!\n"
    out_file += indent2 + "end\n";

    out_file += indent;
    out_file += "end\n";

    // last
    out_file += indent + "puts('Accepted')\n"

    return out_file;
};

var ret = generate_ruby(problem, solution);
console.log(ret);




