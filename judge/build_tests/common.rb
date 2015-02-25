require 'json'
require '../ruby/common'
require './utils.rb'

class TestBase

  include Utils

  def initialize(name)
    @problem = load_problem name
    @name = name

    gen_tests

    puts "#{@test_in[0].length} test cases generated."
    gen_test_file
    if @manual_test.nil? || @manual_test == false
      gen_cpp_test
      gen_java_test
      gen_ruby_test
      gen_python_test
      gen_lua_test
      gen_scala_test
    end
  end

  def load_problem(name)
    path = '../../app/problems/' + name + '.json'
    contents = File.read(path)
    JSON.parse(contents)
  end

  def indent(num = 0)
    ret = ''
    num.times do
      ret += '    '
    end
    ret
  end

  def cpp_arr(arr)
    str = arr.to_s.gsub(/\[/, '{')
    str.gsub(/\]/, '}')
  end

  def gen_test_file
    @types = {
        'bool' => '1D',
        'int' => '1D',
        'double' => '1D',
        'string' => '1D',
        'char' => '1D',
        'TreeNode*' => '1D_bt',
        'TreeNodeWithParent*' => '1D_bt_p',
        'vector<bool>' => '2D',
        'vector<int>' => '2D',
        'vector<double>' => '2D',
        'vector<string>' => '2D',
        'vector<char>' => '2D',
        'vector<Interval>' => '2D_interval',
        'vector<Point>' => '2D_point',
        'vector<TreeNode*>' => '2D_bt',
        'vector<TreeNodeWithParent*>' => '2D_bt_p',
        'vector<vector<bool>>' => '3D',
        'vector<vector<int>>' => '3D',
        'vector<vector<double>>' => '3D',
        'vector<vector<string>>' => '3D',
        'vector<vector<char>>' => '3D',
        'vector<vector<Interval>>' => '3D_interval',
        'vector<vector<Point>>' => '3D_point',
    }
    file = File.open("../tests/#{@name}.txt", 'w')
    in_types = @problem['in_type_cpp']
    out_type = @problem['out_type_cpp']

    @test_in.each_with_index do |t, i|
      type = @types[in_types[i]]
      case type
        when '0D'
          write_0D(file, t)
        when '1D'
          write_1D(file, t)
        when '1D_bt', '1D_bt_p'
          write_1D_bt(file, t)
        when '2D'
          write_2D(file, t)
        when '2D_interval'
          write_2D_interval(file, t)
        when '2D_point'
          write_2D_point(file, t)
        when '2D_bt', '2D_bt_p'
          write_2D_bt(file, t)
        when '3D'
          write_3D(file, t)
        else
          puts 'Unsupported type!' + in_types[i].to_s
      end
    end

    type = @types[out_type]
    case type
      when '0D'
        write_0D(file, @test_out)
      when '1D'
        write_1D(file, @test_out)
      when '1D_bt', '1D_bt_p'
        write_1D_bt(file, @test_out)
      when '2D'
        write_2D(file, @test_out)
      when '2D_interval'
        write_2D_interval(file, @test_out)
      when '2D_point'
        write_2D_interval(file, @test_out)
      when '2D_bt', '2D_bt_p'
        write_2D_bt(file, @test_out)
      when '3D'
        write_3D(file, @test_out)
      when '3D_interval'
        write_3D_interval(file, @test_out)
      when '3D_point'
        write_3D_point(file, @test_out)
      else
        puts 'Unsupported type!' + type.to_s
    end

    file.close
  end

  def write_0D(file, data)
    if [true, false].include? data
      map = {true => '1', false => '0'}
      file.puts map[data]
    else
      file.puts data
    end
  end

  def write_bt(file, data)
    out = []
    save_tree(data, out)
    file.puts out.length
    out.each do |d|
      file.puts d
    end
  end

  def write_1D(file, data)
    file.puts data.length
    data.each do |d|
      write_0D file, d
    end
  end

  def write_1D_bt(file, data)
    file.puts data.length
    data.each do |d|
      write_bt file, d
    end
  end

  def write_1D_interval(file, data)
    file.puts data.length
    data.each do |d|
      file.puts d[0]
      file.puts d[1]
    end
  end

  def write_1D_point(file, data)
    file.puts data.length
    data.each do |d|
      file.puts d[0]
      file.puts d[1]
    end
  end

  def write_2D(file, data)
    file.puts data.length
    data.each do |d|
      write_1D file, d
    end
  end

  def write_2D_point(file, data)
    file.puts data.length
    data.each do |d|
      write_1D_point file, d
    end
  end

  def write_2D_interval(file, data)
    file.puts data.length
    data.each do |d|
      write_1D_interval file, d
    end
  end

  def write_2D_bt(file, data)
    file.puts data.length
    data.each do |d|
      write_1D_bt file, d
    end
  end

  def write_3D(file, data)
    file.puts data.length
    data.each do |d|
      write_2D file, d
    end
  end

  def write_3D_interval(file, data)
    file.puts data.length
    data.each do |d|
      write_2D_interval file, d
    end
  end

  def write_3D_point(file, data)
    file.puts data.length
    data.each do |d|
      write_2D_point file, d
    end
  end

  def gen_cpp_test
    file = File.open("../cpp/tests/#{@name}.h", 'w')

    file.puts "const int num_test = #{@test_in[0].length};"

    @problem['in_type_cpp'].each_with_index do |in_type, i|
      file.puts "vector<#{in_type}> in_#{i};"
      file.puts "vector<#{in_type}> in_org_#{i};"
    end
    file.print "vector<#{@problem['out_type_cpp']}> out;";

    file.puts
    file.puts @extra_test_code_cpp

    file.puts
    file.puts "void load_test() {
    ifstream in(\"judge/tests/#{@name}.txt\");
"
    @problem['in_type_cpp'].each_with_index do |in_type, i|
      case @types[in_type]
        when '1D', '1D_bt', '1D_bt_p'
          file.puts "    read_array(in, in_#{i});"
        when '2D', '2D_interval'
          file.puts "    read_matrix(in, in_#{i});"
        when '3D'
          file.puts "    read_matrix_arr(in, in_#{i});"
        else
          puts 'Invalid input type ' + @types[in_type].to_s
      end
      file.puts "    in_org_#{i} = clone(in_#{i});"
    end
    case @types[@problem['out_type_cpp']]
      when '1D','1D_bt','1D_bt_p'
        file.puts '    read_array(in, out);'
      when '2D','2D_interval','2D_point'
        file.puts '    read_matrix(in, out);'
      when '3D','3D_interval','3D_point'
        file.puts '    read_matrix_arr(in, out);'
      else
        puts 'Invalid output type ' + @types[@problem['out_type_cpp']].to_s
    end
    file.puts '    in.close();'
    file.puts '}'
    file.puts
    file.puts 'void judge() {
    cout.setf(ios::boolalpha);

    capture_stdout();

    load_test();
    auto start = chrono::steady_clock::now();
    for(int i = 0; i < num_test; ++i) {
        printf("Testing case #%d\n", i+1);'

    judge_call = '        ';
    judge_inputs = '';
    if(@problem['ret_type_cpp'] != 'void')
        judge_call += "auto answer = #{@problem['judge_call']}"
    else
        judge_call += @problem['judge_call'];
    end
    judge_call += ';';

    @problem['in_type_cpp'].each_with_index do |in_type, i|
      judge_inputs += ', ' if i != 0
      judge_inputs += "in_#{i}[i]"
    end

    file.puts judge_call.gsub(/@/, judge_inputs)

    if @problem['ret_type_cpp'] == 'void'
      file.puts '        auto answer = in_0[i];'
    end

    if @problem['judge_type_cpp'] == 'equal'
      file.puts '        if(answer != out[i]) {'
    else
      file.puts "        if(#{@problem['judge_type_cpp']}) {"
    end

    file.puts '            release_stdout();'
    file.puts '            cout << i+1 << "/" << num_test << ";";'

    file.print '            cout << '
    @problem['in_type_cpp'].each_with_index do |in_type, i|
      file.print ' << + ", " << ' if i != 0
      file.print "in_org_#{i}[i]"
    end
    file.puts ' << ";";'

    vis_answer = @problem['vis_answer_cpp']
    vis_answer = 'answer' if vis_answer.nil?

    vis_out = @problem['vis_out_cpp']
    vis_out = 'out[i]' if vis_out.nil?

    file.puts "            cout << #{vis_answer} << \";\";
            cout << #{vis_out} << endl;
            return;
        }"

    file.puts '    }
    release_stdout();
    auto elapsed = chrono::duration_cast<chrono::milliseconds>(chrono::steady_clock::now() - start);
    cout << "Accepted;";
    cout << elapsed.count() << endl;'

    file.puts '}'

    file.close
  end

  def gen_java_test
    java_funcs = {
        'bool' => 'common.read_bool_array',
        'int' => 'common.read_int_array',
        'double' => 'common.read_double_array',
        'char' => 'common.read_char_array',
        'string' => 'common.read_string_array',
        'Interval' => 'common.read_interval_array',
        'Point' => 'common.read_point_array',
        'TreeNode*' => 'common.read_tree_array',
        'TreeNodeWithParent*' => 'common.read_tree_with_p_array',
        'vector<bool>' => 'common.read_bool_matrix',
        'vector<int>' => 'common.read_int_matrix',
        'vector<char>' => 'common.read_char_matrix',
        'vector<double>' => 'common.read_double_matrix',
        'vector<string>' => 'common.read_string_matrix',
        'vector<Interval>' => 'common.read_interval_matrix',
        'vector<Point>' => 'common.read_point_matrix',
        'vector<TreeNode*>' => 'common.read_tree_matrix',
        'vector<TreeNodeWithParent*>' => 'common.read_tree_with_p_matrix',
        'vector<vector<bool>>' => 'common.read_bool_matrix_arr',
        'vector<vector<char>>' => 'common.read_char_matrix_arr',
        'vector<vector<int>>' => 'common.read_int_matrix_arr',
        'vector<vector<double>>' => 'common.read_double_matrix_arr',
        'vector<vector<string>>' => 'common.read_string_matrix_arr'
    }

    class_name = @name.gsub(/-/, '_')
    file = File.open("../java/tests/#{class_name}.java", 'w')

    file.puts 'package tests;'
    file.puts 'import java.util.*;'
    file.puts 'import java.lang.*;'
    file.puts 'import java.io.*;'
    file.puts 'import judge.*;'
    file.puts 'import datastruct.*;'
    file.puts

    file.puts "public class #{class_name} {"
    file.puts indent(1) + "public static int num_test = #{@test_in[0].length};"

    @problem['in_type_java'].each_with_index do |in_type, i|
      file.puts indent(1) + "public static #{in_type}[] in_#{i};"
      file.puts indent(1) + "public static #{in_type}[] in_org_#{i};"
    end
    file.print indent(1) + "public static #{@problem['out_type_java']}[] out;";

    file.puts
    file.puts @extra_test_code_java
    file.puts

    file.puts '    public static void load_test() {'
    file.puts "        File fil = new File(\"judge/tests/#{@name}.txt\");
        FileReader inputFil = null;
        try {
            inputFil = new FileReader(fil);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        BufferedReader in = new BufferedReader(inputFil);
        try {"

    @problem['in_type_cpp'].each_with_index do |in_type, i|
      file.puts "            in_#{i} = #{java_funcs[in_type]}(in);"
      file.puts "            in_org_#{i} = test_common.copy(in_#{i});"
    end
    file.puts "            out = #{java_funcs[@problem['out_type_cpp']]}(in);"
    file.puts '        } catch (IOException e) {
            e.printStackTrace();
        }'
    file.puts '    }'

    solution_class = @problem['class_name_java']
    solution_class = 'Solution' if solution_class.nil?

    file.puts
    file.puts '    public static void judge() {'
    file.puts '        load_test();'
    file.puts '        common.capture_stdout();'

    file.puts "        #{solution_class} s = new #{solution_class}();"
    file.puts
    file.puts '        long startTime = System.currentTimeMillis();'
    file.puts
    file.puts '        for(int i = 0; i < num_test; ++i) {'
    file.puts '            System.out.printf("Testing case #%d\n", i+1);'

    caller = @problem['judge_call_java']
    caller = 's.' + @problem['judge_call'] if caller.nil?
    judge_call = '        '
    judge_inputs = ''
    if(@problem['ret_type_java'] != 'void')
      judge_call += "    #{@problem['ret_type_java']} answer = #{caller}"
    else
      judge_call += caller
    end
    judge_call += ';'

    @problem['in_type_java'].each_with_index do |in_type, i|
      judge_inputs += ', ' if i != 0
      judge_inputs += "in_#{i}[i]"
    end

    file.puts judge_call.gsub(/@/, judge_inputs)

    if @problem['ret_type_java'] == 'void'
      file.puts "        #{@problem['out_type_java']} answer = in_0[i];"
    end

    if @problem['judge_type_java'] == 'equal'
      file.puts '            if(answer != out[i]) {'
    else
      file.puts "            if(#{@problem['judge_type_java']}) {"
    end

    file.puts '                common.release_stdout();'
    file.puts '                System.out.printf("%d / %d;", i+1, num_test);'

    file.print '                String outs = '
    @problem['in_type_java'].each_with_index do |in_type, i|
      file.print ' + ", " + ' if i != 0
      file.print "common.to_string(#{class_name}.in_org_#{i}[i])"
    end
    file.puts ';'
    file.puts '                System.out.print(outs + ";");'

    vis_answer = @problem['vis_answer_java']
    vis_answer = 'common.to_string(answer)' if vis_answer.nil?

    vis_out = @problem['vis_out_java']
    vis_out = 'common.to_string(out[i])' if vis_out.nil?

    file.puts "                System.out.print(#{vis_answer} + \";\");"
    file.puts "                System.out.println(#{vis_out});"
    file.puts '                return;'
    file.puts '            }'

    file.puts '        }'
    file.puts
    file.puts '        common.release_stdout();'
    file.puts '        long estimatedTime = System.currentTimeMillis() - startTime;'
    file.puts '        System.out.print("Accepted;");'
    file.puts '        System.out.println(estimatedTime);'
    file.puts '    }'

    file.puts '}'

    file.close
  end

  def gen_ruby_test

    ruby_funcs = {
        'bool' => 'read_bool_array',
        'int' => 'read_int_array',
        'char' => 'read_string_array',
        'double' => 'read_double_array',
        'string' => 'read_string_array',
        'Interval' => 'read_interval_array',
        'Point' => 'read_point_array',
        'TreeNode*' => 'read_tree_array',
        'TreeNodeWithParent*' => 'read_tree_with_p_array',
        'vector<bool>' => 'read_bool_matrix',
        'vector<int>' => 'read_int_matrix',
        'vector<char>' => 'read_string_matrix',
        'vector<double>' => 'read_double_matrix',
        'vector<string>' => 'read_string_matrix',
        'vector<Interval>' => 'read_interval_matrix',
        'vector<Point>' => 'read_point_matrix',
        'vector<TreeNode*>' => 'read_tree_matrix',
        'vector<TreeNodeWithParent*>' => 'read_tree_with_p_matrix',
        'vector<vector<bool>>' => 'read_bool_matrix_arr',
        'vector<vector<char>>' => 'read_string_matrix_arr',
        'vector<vector<int>>' => 'read_int_matrix_arr',
        'vector<vector<double>>' => 'read_double_matrix_arr',
        'vector<vector<string>>' => 'read_string_matrix_arr'
    }

    file = File.open("../ruby/tests/#{@name}.rb", 'w')
    file.puts "@num_test = #{@test_in[0].length}"

    @problem['in_type_cpp'].each_with_index do |in_type, i|
      file.puts "@in_#{i} = []"
      file.puts "@in_org_#{i} = []"
    end
    file.puts '@out = []';

    file.puts @extra_test_code_ruby

    file.puts

    file.puts 'def load_test'
    file.puts "    f = File.new(\"judge/tests/#{@name}.txt\")"
    @problem['in_type_cpp'].each_with_index do |in_type, i|
      file.puts "    @in_#{i} = #{ruby_funcs[in_type]}(f)"
      file.puts "    @in_org_#{i} = @in_#{i}.dup"
    end
    file.puts "    @out = #{ruby_funcs[@problem['out_type_cpp']]}(f)"
    file.puts '    f.close'
    file.puts 'end'

    file.puts

    file.puts 'def judge'
    file.puts '    load_test'
    file.puts '    capture_stdout'
    file.puts
    file.puts '    start_time = Time.now'
    file.puts
    file.puts '    (0...@num_test).each do |i|'
    file.puts '       puts \'Testing case #\' + (i+1).to_s'

    caller = @problem['judge_call']
    judge_call = "        answer = #{caller} "
    judge_inputs = ''

    @problem['in_type_java'].each_with_index do |in_type, i|
      judge_inputs += ', ' if i != 0
      judge_inputs += "@in_#{i}[i]"
    end
    file.puts judge_call.gsub(/@/, judge_inputs)

    if @problem['ret_type_java'] == 'void'
      file.puts '        answer = @in_0[i]'
    end

    if @problem['judge_type_ruby'] == 'equal'
      file.puts '        if answer != @out[i]'
    else
      file.puts "        if (#{@problem['judge_type_ruby']})"
    end

    vis_answer = @problem['vis_answer_ruby']
    vis_answer = 'answer.to_s' if vis_answer.nil?

    vis_out = @problem['vis_out_ruby']
    vis_out = '@out[i].to_s' if vis_out.nil?

    file.puts '            release_stdout'
    file.puts '            print "#{i+1} / #{@num_test};"'
    @problem['in_type_java'].each_with_index do |in_type, i|
      file.puts '            print \', \'' if i != 0
      file.puts "            print @in_org_#{i}[i].to_s"
    end
    file.puts '            print \';\''
    file.puts "            print #{vis_answer}"
    file.puts '            print \';\''
    file.puts "            print #{vis_out}"
    file.puts '            puts'

    file.puts '            return'
    file.puts '        end'

    file.puts '    end'
    file.puts
    file.puts '    release_stdout'
    file.puts '    runtime = (Time.now - start_time) * 1000.0'
    file.puts '    puts(\'Accepted;\' + runtime.to_i.to_s)'
    file.puts 'end'

    file.close
  end

  def gen_python_test

    python_funcs = {
        'bool' => 'read_bool_array',
        'int' => 'read_int_array',
        'char' => 'read_string_array',
        'double' => 'read_double_array',
        'string' => 'read_string_array',
        'Interval' => 'read_interval_array',
        'Point' => 'read_point_array',
        'TreeNode*' => 'read_tree_array',
        'TreeNodeWithParent*' => 'read_tree_with_p_array',
        'vector<bool>' => 'read_bool_matrix',
        'vector<int>' => 'read_int_matrix',
        'vector<char>' => 'read_string_matrix',
        'vector<double>' => 'read_double_matrix',
        'vector<string>' => 'read_string_matrix',
        'vector<Interval>' => 'read_interval_matrix',
        'vector<Point>' => 'read_point_matrix',
        'vector<TreeNode*>' => 'read_tree_matrix',
        'vector<TreeNodeWithParent*>' => 'read_tree_with_p_matrix',
        'vector<vector<bool>>' => 'read_bool_matrix_arr',
        'vector<vector<int>>' => 'read_int_matrix_arr',
        'vector<vector<char>>' => 'read_string_matrix_arr',
        'vector<vector<double>>' => 'read_double_matrix_arr',
        'vector<vector<string>>' => 'read_string_matrix_arr'
    }

    file = File.open("../python/tests/#{@name.gsub(/-/, '_')}.py", 'w')
    file.puts 'from common import *'
    file.puts 'from solution import *'
    file.puts 'import copy'
    file.puts 'import sys'
    file.puts 'import datetime'
    file.puts
    file.puts "num_test = #{@test_in[0].length}"
    file.puts 'true, false = True, False'


    @problem['in_type_java'].each_with_index do |in_type, i|
      file.puts "in_#{i} = []"
      file.puts "in_org_#{i} = []"
    end
    file.puts 'out = []';

    file.puts @extra_test_code_python
    file.puts

    file.puts 'def load_test():'
    file.puts "    f = open('judge/tests/#{@name}.txt', 'r')"
    @problem['in_type_cpp'].each_with_index do |in_type, i|
      file.puts "    global in_#{i}, in_org_#{i}"
      file.puts "    in_#{i} = #{python_funcs[in_type]}(f)"
      file.puts "    in_org_#{i} = copy.deepcopy(in_#{i})"
    end
    file.puts '    global out'
    file.puts "    out = #{python_funcs[@problem['out_type_cpp']]}(f)"
    file.puts '    f.close'

    file.puts

    file.puts 'def judge():'
    file.puts '    load_test()'
    file.puts '    capture_stdout()'
    file.puts '    start_time = datetime.datetime.now()'
    file.puts '    for i in range(num_test):'
    file.puts '        print (\'Testing case #\' + str(i+1))'

    caller = @problem['judge_call']
    judge_call = "        answer = #{caller} "
    judge_inputs = ''

    @problem['in_type_java'].each_with_index do |in_type, i|
      judge_inputs += ', ' if i != 0
      judge_inputs += "in_#{i}[i]"
    end
    file.puts judge_call.gsub(/@/, judge_inputs)

    if @problem['ret_type_java'] == 'void'
      file.puts '        answer = in_0[i]'
    end

    if @problem['judge_type_python'] == 'equal'
      file.puts '        if (answer != out[i]):'
    else
      file.puts "        if (#{@problem['judge_type_python']}):"
    end
    file.puts '            release_stdout()'
    file.puts '            out_str = str(i+1) + " / " + str(num_test) + ";"'

    @problem['in_type_java'].each_with_index do |in_type, i|
      file.puts '            out_str += ", "' if i != 0
      file.puts "            out_str += str(in_org_#{i}[i])"
    end

    vis_answer = @problem['vis_answer_python']
    vis_answer = 'str(answer)' if vis_answer.nil?

    vis_out = @problem['vis_out_python']
    vis_out = 'str(out[i])' if vis_out.nil?

    file.puts "            out_str += \";\"
            out_str += #{vis_answer}
            out_str += \";\"
            out_str += #{vis_out}
            print(out_str)
            return"
    file.puts '
    release_stdout()
    delta = datetime.datetime.now() - start_time
    runtime = str(int(delta.total_seconds() * 1000))
    print(\'Accepted;\' + runtime)'
    file.close
  end

  def gen_lua_test
    lua_funcs = {
        'bool' => 'read_bool_array',
        'int' => 'read_num_array',
        'char' => 'read_string_array',
        'double' => 'read_num_array',
        'string' => 'read_string_array',
        'Interval' => 'read_interval_array',
        'Point' => 'read_point_array',
        'TreeNode*' => 'read_tree_array',
        'TreeNodeWithParent*' => 'read_tree_with_p_array',
        'vector<bool>' => 'read_bool_matrix',
        'vector<int>' => 'read_num_matrix',
        'vector<double>' => 'read_num_matrix',
        'vector<char>' => 'read_string_matrix',
        'vector<string>' => 'read_string_matrix',
        'vector<Interval>' => 'read_interval_matrix',
        'vector<Point>' => 'read_point_matrix',
        'vector<TreeNode*>' => 'read_tree_matrix',
        'vector<TreeNodeWithParent*>' => 'read_tree_with_p_matrix',
        'vector<vector<bool>>' => 'read_bool_matrix_arr',
        'vector<vector<int>>' => 'read_num_matrix_arr',
        'vector<vector<double>>' => 'read_num_matrix_arr',
        'vector<vector<string>>' => 'read_string_matrix_arr',
        'vector<vector<char>>' => 'read_string_matrix_arr'
    }

    file = File.open("../lua/tests/#{@name}.lua", 'w')

    file.puts 'require("../solution")'

    file.puts
    file.puts "local num_test = #{@test_in[0].length}"

    @problem['in_type_java'].each_with_index do |in_type, i|
      file.puts "local in_#{i} = {}"
      file.puts "local in_org_#{i} = {}"
    end
    file.puts 'local out = {}';

    file.puts @extra_test_code_lua
    file.puts

    file.puts 'function load_test()'
    file.puts "    local f = io.open(\"./judge/tests/#{@name}.txt\", \"r\")"
    @problem['in_type_cpp'].each_with_index do |in_type, i|
      file.puts "    in_#{i} = #{lua_funcs[in_type]}(f)"
      file.puts "    in_org_#{i} = copy(in_#{i})"
    end
    file.puts "    out = #{lua_funcs[@problem['out_type_cpp']]}(f)"
    file.puts '    f:close()'
    file.puts 'end'

    file.puts

    file.puts 'function judge()'
    file.puts '    load_test()'
    file.puts '    capture_stdout()'
    file.puts
    file.puts '    local start = os.clock()'
    file.puts '    for i = 1, num_test do'
    file.puts '        print("Testing case #" .. i)'

    caller = @problem['judge_call']
    judge_call = "        local answer = #{caller} "
    judge_inputs = ''

    @problem['in_type_java'].each_with_index do |in_type, i|
      judge_inputs += ', ' if i != 0
      judge_inputs += "in_#{i}[i]"
    end
    file.puts judge_call.gsub(/@/, judge_inputs)

    if @problem['ret_type_java'] == 'void'
      file.puts '        answer = in_0[i]'
    end

    if @problem['judge_type_lua'] == 'equal'
      file.puts '        if answer ~= out[i] then'
    else
      file.puts "        if #{@problem['judge_type_lua']} then"
    end
    file.puts '            io.write(string.format("%d / %d;", i, num_test))'

    @problem['in_type_java'].each_with_index do |in_type, i|
      file.puts '            io.write(", ")' if i != 0
      file.puts "            io.write(to_string(in_org_#{i}[i]))"
    end

    vis_answer = @problem['vis_answer_lua']
    vis_answer = 'to_string(answer)' if vis_answer.nil?

    vis_out = @problem['vis_out_lua']
    vis_out = 'to_string(out[i])' if vis_out.nil?

    file.puts "            io.write(\";\")
            io.write(#{vis_answer})
            io.write(\";\")
            io.write(#{vis_out})
            io.write(\"\\n\")
            return
        end
    end"
    file.puts '
    release_stdout()
    local elapsed = math.floor((os.clock() - start) * 1000)
	print("Accepted;" .. elapsed)
end'

    file.close
  end

  def gen_scala_test
    scala_funcs = {
      'bool' => 'common.read_bool_array',
      'int' => 'common.read_int_array',
      'double' => 'common.read_double_array',
      'char' => 'common.read_char_array',
      'string' => 'common.read_string_array',
      'Interval' => 'common.read_interval_array',
      'Point' => 'common.read_point_array',
      'TreeNode*' => 'common.read_tree_array',
      'TreeNodeWithParent*' => 'common.read_tree_with_p_array',

      'vector<bool>' => 'common.read_bool_matrix',
      'vector<int>' => 'common.read_int_matrix',
      'vector<char>' => 'common.read_char_matrix',
      'vector<double>' => 'common.read_double_matrix',
      'vector<string>' => 'common.read_string_matrix',
      'vector<Interval>' => 'common.read_interval_matrix',
      'vector<Point>' => 'common.read_point_matrix',
      'vector<TreeNode*>' => 'common.read_tree_matrix',
      'vector<TreeNodeWithParent*>' => 'common.read_tree_with_p_matrix',

      'vector<vector<bool>>' => 'common.read_bool_matrix_arr',
      'vector<vector<char>>' => 'common.read_char_matrix_arr',
      'vector<vector<int>>' => 'common.read_int_matrix_arr',
      'vector<vector<double>>' => 'common.read_double_matrix_arr',
      'vector<vector<string>>' => 'common.read_string_matrix_arr'
    }

    type_map = {
      'int' => 'Int',
      'double' => 'Double',
      'char' => 'Char',
      'boolean' => 'Boolean',

      'int[]' => 'List[Int]',
      'double[]' => 'List[Double]',
      'char[]' => 'List[Char]',
      'boolean[]' => 'List[Boolean]',

      'int[][]' => 'List[List[Int]]',
      'double[][]' => 'List[List[Double]]',
      'char[][]' => 'List[List[Char]]',
      'boolean[][]' => 'List[List[Boolean]]'
    }

    class_name = @name.gsub(/-/, '_')
    file = File.open("../scala/tests/#{class_name}.scala", 'w')

    file.puts 'package test'
    file.puts 'import scala.io.Source'
    file.puts 'import judge.common'
    file.puts 'import judge.Solution'
    file.puts

    file.puts "object #{class_name} {"
    file.puts indent(1) + "val num_test = #{@test_in[0].length};"

    @problem['in_type_java'].each_with_index do |in_type, i|
      type = type_map.has_key?(in_type) ? type_map[in_type] : in_type
      file.puts indent(1) + "var in_#{i} = List[#{type}]();"
    end
    out_type = @problem['out_type_scala']

    file.print indent(1) + "var out = List[#{out_type}]();"

    file.puts
    file.puts @extra_test_code_scala
    file.puts

    file.puts '    def load_test() = {'
    file.puts "        val in = Source.fromFile(\"./judge/tests/#{@name}.txt\").getLines;"

    @problem['in_type_cpp'].each_with_index do |in_type, i|
      file.puts "        in_#{i} = #{scala_funcs[in_type]}(in);"
    end
    file.puts "        out = #{scala_funcs[@problem['out_type_cpp']]}(in);"
    file.puts '    }'

    solution_class = @problem['class_name_java']
    solution_class = 'Solution' if solution_class.nil?

    file.puts
    file.puts '    def judge(): Int = {'
    file.puts '        load_test();'
    file.puts '        common.capture_stdout();'

    file.puts
    file.puts '        val startTime = System.currentTimeMillis();'
    file.puts '        var i = 0;'
    file.puts
    file.puts '        while(i < num_test) {'
    file.puts '            printf("Testing case #%d\n", i+1);'

    caller = @problem['judge_call_java']
    caller = 'Solution.' + @problem['judge_call'] if caller.nil?
    judge_call = '        '
    judge_inputs = ''
    judge_call += "    val answer = #{caller}"
    judge_call += ';'

    @problem['in_type_java'].each_with_index do |in_type, i|
      judge_inputs += ', ' if i != 0
      judge_inputs += "in_#{i}(i)"
    end

    file.puts judge_call.gsub(/@/, judge_inputs)


    if @problem['judge_type_scala'] == 'equal'
      file.puts '            if(answer != out(i)) {'
    else
      file.puts "            if(#{@problem['judge_type_scala']}) {"
    end

    file.puts '                common.release_stdout();'
    file.puts '                printf("%d / %d;", i+1, num_test);'

    file.print '                var outs = '
    @problem['in_type_java'].each_with_index do |in_type, i|
      file.print ' + ", " + ' if i != 0
      file.print "common.to_string(#{class_name}.in_#{i}(i))"
    end
    file.puts ';'
    file.puts '                print(outs + ";");'

    vis_answer = @problem['vis_answer_scala']
    vis_answer = 'common.to_string(answer)' if vis_answer.nil?

    vis_out = @problem['vis_out_scala']
    vis_out = 'common.to_string(out(i))' if vis_out.nil?

    file.puts "                print(#{vis_answer} + \";\");"
    file.puts "                println(#{vis_out});"
    file.puts '                return 1;'
    file.puts '            }'
    file.puts '            i += 1;'
    file.puts '        }'
    file.puts
    file.puts '        common.release_stdout();'
    file.puts '        val estimatedTime = System.currentTimeMillis - startTime;'
    file.puts '        print("Accepted;");'
    file.puts '        println(estimatedTime);'
    file.puts '        return 0;'
    file.puts '    }'

    file.puts '}'

    file.close
  end

  def gen_tests
  end

end
