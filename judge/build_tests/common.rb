require 'json'

class TestBase

  def initialize(name)
    @problem = load_problem name
    @name = name

    gen_tests
    gen_test_file
    gen_cpp_test
    gen_java_test
    gen_ruby_test
    gen_python_test
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
        'vector<bool>' => '2D',
        'vector<int>' => '2D',
        'vector<double>' => '2D',
        'vector<string>' => '2D',
        'vector<vector<bool>>' => '3D',
        'vector<vector<int>>' => '3D',
        'vector<vector<double>>' => '3D',
        'vector<vector<string>>' => '3D',
    }
    file = File.open("../tests/#{@name}.txt", 'w')
    in_types = @problem['in_type_cpp']
    out_type = @problem['out_type_cpp']
    #file.puts in_types.length

    @test_in.each_with_index do |t, i|
      type = @types[in_types[i]]
      case type
        when '0D'
          write_0D(file, t)
        when '1D'
          write_1D(file, t)
        when '2D'
          write_2D(file, t)
        when '3D'
          write_3D(file, t)
        else
          puts 'Unsupported type!' + in_types[i]
      end
    end

    type = @types[out_type]
    case type
      when '0D'
        write_0D(file, @test_out)
      when '1D'
        write_1D(file, @test_out)
      when '2D'
        write_2D(file, @test_out)
      when '3D'
        write_3D(file, @test_out)
      else
        puts 'Unsupported type!' + in_types[i]
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

  def write_1D(file, data)
    file.puts data.length
    data.each do |d|
      write_0D file, d
    end
  end

  def write_2D(file, data)
    file.puts data.length
    data.each do |d|
      write_1D file, d
    end
  end

  def write_3D(file, data)
    file.puts data.length
    data.each do |d|
      write_2D file, d
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
        when '1D'
          file.puts "    read_array(in, in_#{i});"
        when '2D'
          file.puts "    read_matrix(in, in_#{i});"
      end
      file.puts "    in_org_#{i} = in_#{i};"
    end
    case @types[@problem['out_type_cpp']]
      when '1D'
        file.puts '    read_array(in, out);'
      when '2D'
        file.puts '    read_matrix(in, out);'
      when '3D'
        file.puts '    read_matrix_arr(in, out);'
    end
    file.puts '    in.close();'
    file.puts '}'
    file.puts
    file.puts 'void judge() {
    cout.setf(ios::boolalpha);
    load_test();
    auto start = chrono::steady_clock::now();
    for(int i = 0; i < num_test; ++i) {'

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

    file.puts '            cout << i+1 << "/" << num_test << ";";'

    file.print '            cout << '
    @problem['in_type_cpp'].each_with_index do |in_type, i|
      file.print ' << + ", " << ' if i != 0
      file.print "in_org_#{i}[i]"
    end
    file.puts ' << ";";'
    file.puts '            cout << answer << ";";
            cout << out[i] << endl;
            return;
        }'

    file.puts '    }
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
        'string' => 'common.read_string_array',
        'vector<bool>' => 'common.read_bool_matrix',
        'vector<int>' => 'common.read_int_matrix',
        'vector<double>' => 'common.read_double_matrix',
        'vector<string>' => 'common.read_string_matrix',
        'vector<vector<bool>>' => 'common.read_bool_matrix_arr',
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
    file.puts "        #{solution_class} s = new #{solution_class}();"
    file.puts
    file.puts '        long startTime = System.currentTimeMillis();'
    file.puts
    file.puts '        for(int i = 0; i < num_test; ++i) {'

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

    file.puts '                System.out.printf("%d / %d;", i+1, num_test);'

    file.print '                String outs = '
    @problem['in_type_java'].each_with_index do |in_type, i|
      file.print ' + ' if i != 0
      file.print "common.to_string(#{class_name}.in_org_#{i}[i])"
    end
    file.puts ';'
    file.puts '                System.out.print(outs + ";");'

    file.puts '                System.out.print(common.to_string(answer) + ";");'
    file.puts '                System.out.println(common.to_string(out[i]));'
    file.puts '                return;'
    file.puts '            }'

    file.puts '        }'
    file.puts
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
        'double' => 'read_double_array',
        'string' => 'read_string_array',
        'vector<bool>' => 'read_bool_matrix',
        'vector<int>' => 'read_int_matrix',
        'vector<double>' => 'read_double_matrix',
        'vector<string>' => 'read_string_matrix',
        'vector<vector<bool>>' => 'read_bool_matrix_arr',
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
    file.puts
    file.puts '    start_time = Time.now'
    file.puts
    file.puts '    (0...@num_test).each do |i|'

    caller = @problem['judge_call']
    judge_call = "        answer = #{caller} "
    judge_inputs = ''

    @problem['in_type_java'].each_with_index do |in_type, i|
      judge_inputs += ', ' if i != 0
      judge_inputs += "@in_#{i}[i]"
    end
    file.puts judge_call.gsub(/@/, judge_inputs)

    if @problem['judge_type_ruby'] == 'equal'
      file.puts '        if answer != @out[i]'
    else
      file.puts "        if (#{@problem['judge_type_ruby']})"
    end

    file.puts '            print "#{i+1} / #{@num_test};"'
    @problem['in_type_java'].each_with_index do |in_type, i|
      file.puts '            print \', \'' if i != 0
      file.puts "            print @in_org_#{i}[i]"
    end
    file.puts '            print \';\''
    file.puts '            print answer'
    file.puts '            print \';\''
    file.puts '            print @out[i]'
    file.puts '            puts'

    file.puts '            return'
    file.puts '        end'

    file.puts '    end'
    file.puts
    file.puts '    runtime = (Time.now - start_time) * 1000.0'
    file.puts '    puts(\'Accepted;\' + runtime.to_i.to_s)'
    file.puts 'end'

    file.close
  end

  def gen_python_test

    python_funcs = {
        'bool' => 'read_bool_array',
        'int' => 'read_int_array',
        'double' => 'read_double_array',
        'string' => 'read_string_array',
        'vector<bool>' => 'read_bool_matrix',
        'vector<int>' => 'read_int_matrix',
        'vector<double>' => 'read_double_matrix',
        'vector<string>' => 'read_string_matrix',
        'vector<vector<bool>>' => 'read_bool_matrix_arr',
        'vector<vector<int>>' => 'read_int_matrix_arr',
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
    file.puts '    start_time = datetime.datetime.now()'
    file.puts '    for i in range(num_test):'

    caller = @problem['judge_call']
    judge_call = "        answer = #{caller} "
    judge_inputs = ''

    @problem['in_type_java'].each_with_index do |in_type, i|
      judge_inputs += ', ' if i != 0
      judge_inputs += "in_#{i}[i]"
    end
    file.puts judge_call.gsub(/@/, judge_inputs)

    if @problem['judge_type_python'] == 'equal'
      file.puts '        if (answer != out[i]):'
    else
      file.puts "        if (#{@problem['judge_type_python']}):"
    end
    file.puts '            out_str = str(i+1) + " / " + str(num_test) + ";"'

    @problem['in_type_java'].each_with_index do |in_type, i|
      file.puts '            out_str += ", "' if i != 0
      file.puts "            out_str += str(in_org_#{i}[i])"
    end

    file.puts '            out_str += ";"
            out_str += str(answer)
            out_str += ";"
            out_str += str(out[i])
            print(out_str)
            return'
    file.puts '
    delta = datetime.datetime.now() - start_time
    runtime = str(int(delta.total_seconds() * 1000))
    print(\'Accepted;\' + runtime)'
    file.close
  end

  def gen_tests
  end
end