require './common'
require '../ruby/common'

class Test_max_sum_nonconsecutive_elements < TestBase
  def initialize(name)
    super(name)
  end

  def max_values(nums)
    return 0 if nums.empty?
    prev_prev, prev = 0, nums[0]
    (1...nums.length).each do |i|
      old_prev = prev
      prev = [prev, [nums[i] + prev_prev, prev].max].max
      prev_prev = old_prev
    end
    prev
  end

  def add_test(array)
    @test_in[0] << array
    @test_out << max_values(array)
  end

  def gen_tests
    @test_in, @test_out = [[]], []

    add_test [3, 2, 7, 10]
    add_test [3, 2, 5, 10, 7]
    add_test [1, 5, 4, 3, 2]

    50.times do
      add_test gen_array(rand(5...100), 1...100)
    end

    30.times do
      add_test gen_array(rand(100...300), 1...500)
    end
  end
end

Test_max_sum_nonconsecutive_elements.new 'max-sum-nonconsecutive-elements'