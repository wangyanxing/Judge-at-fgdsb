require 'json'

class TestBase

  def initialize(name)
    @problem = load_problem name
    @name = name

    gen_tests
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

  def gen_cpp_test
    file = File.open("../cpp/tests/#{@name}.h", 'w')

    file.puts "const int num_test = #{@test_in[0].length};"

    @problem['in_type_cpp'].each_with_index do |in_type, i|
      file.print "vector<#{in_type}> in_#{i} = "
      file.puts cpp_arr(@test_in[i]) + ';'
      file.puts "vector<#{in_type}> in_org_#{i} = in_#{i};"
    end
    file.print "vector<#{@problem['out_type_cpp']}> out = ";
    file.puts cpp_arr(@test_out) + ';'

    file.puts @extra_test_code_cpp

    file.close
  end

  def gen_java_test
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
      file.print indent(1) + "public static #{in_type}[] in_#{i} = "
      file.puts cpp_arr(@test_in[i]) + ';'
      file.puts indent(1) + "public static #{in_type}[] in_org_#{i} = test_common.copy(in_#{i});"
    end
    file.print indent(1) + "public static #{@problem['out_type_java']}[] out = ";
    file.puts cpp_arr(@test_out) + ';'

    file.puts @extra_test_code_java

    file.puts '}'

    file.close
  end

  def gen_ruby_test
    file = File.open("../ruby/tests/#{@name}.rb", 'w')
    file.puts "T_num_test = #{@test_in[0].length}"

    @problem['in_type_java'].each_with_index do |in_type, i|
      file.print "T_in_#{i} = "
      file.puts @test_in[i].to_s
      file.puts "T_in_org_#{i} = T_in_#{i}.dup"
    end
    file.print 'T_out = ';
    file.puts @test_out.to_s

    file.puts @extra_test_code_ruby

    file.close
  end

  def gen_python_test
    file = File.open("../python/tests/#{@name.gsub(/-/, '_')}.py", 'w')
    file.puts 'from common import *'
    file.puts 'import copy'
    file.puts
    file.puts "num_test = #{@test_in[0].length}"
    file.puts 'true, false = True, False'

    @problem['in_type_java'].each_with_index do |in_type, i|
      file.print "in_#{i} = "
      file.puts @test_in[i].to_s
      file.puts "in_org_#{i} = copy.deepcopy(in_#{i})"
    end
    file.print 'out = ';
    file.puts @test_out.to_s

    file.puts @extra_test_code_python
    file.close
  end

  def gen_tests
  end
end