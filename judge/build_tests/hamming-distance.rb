require './common'
require '../ruby/common'

class Test_hamming_distance < TestBase
  def initialize(name)
    super(name)
  end
  
  def hamming(a, b)
    res = 0
    while a >0 or b > 0
        i, j = a % 10, b % 10
        res += 1 if a == 0 or b == 0 or i != j
        a, b = a / 10, b / 10
    end
    res
  end

  def add_test(a, b)
      @test_in[0] << a
      @test_in[1] << b
      @test_out << hamming(a, b)
  end

  def gen_tests
    @test_in, @test_out = [[],[]], []
    
    30.times do
        add_test rand(0..50), rand(0..50)
    end
    
    70.times do
        add_test rand(500..10000000), rand(500..10000000)
    end
  end
end

Test_hamming_distance.new 'hamming-distance'