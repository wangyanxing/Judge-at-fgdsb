require './common'
require '../ruby/common'

class Test_subarray_sum < TestBase
  def initialize(name)
    super(name)
  end
  
  def subarray_sum(arr, t)
      arr.each_with_index do |num, i|
          sum = 0
          (i...arr.length).each do |j|
              sum += arr[j]
              return true if t == sum
          end
      end
      false
  end

  def add_test(arr, t)
      @test_in[0] << arr
      @test_in[1] << t
      @test_out << subarray_sum(arr,t)
  end

  def gen_tests
    @test_in, @test_out = [[],[]], []
    20.times do
      add_test(gen_array(rand(2...10), 1...10), rand(5..20))
    end
    
    50.times do
      add_test(gen_array(rand(20...50), 1...50), rand(50..500))
    end
    
    30.times do
      add_test(gen_array(rand(200...500), 1...100), rand(100..5000))
    end
  end
end

Test_subarray_sum.new 'subarray-sum'