require './common'
require '../ruby/common'

class Test_recover_count_array < TestBase
  def initialize(name)
    super(name)
  end

  def gen(n)
    arr, cnt = (1..n).to_a.shuffle, []
    arr.each_with_index do |num,i|
      count = 0
      ((i+1)...n).each do |j|
        count += 1 if arr[j] < num
      end
      cnt << count
    end
    [arr, cnt]
  end

  def add_test(n)
    org, cnt = gen(n)
    @test_in[0] << cnt
    @test_out << org
  end

  def gen_tests
    @test_in, @test_out = [[]], []

    @test_in[0] << [3, 0, 1, 0]
    @test_out << [4, 1, 3, 2]

    30.times do
      add_test rand(3...50)
    end

    30.times do
      add_test rand(30...50)
    end

    39.times do
      add_test rand(300...500)
    end
  end
end

Test_recover_count_array.new 'recover-count-array'