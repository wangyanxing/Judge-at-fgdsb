require './common'
require '../ruby/common'

class Test_zigzag_iterator < TestBase
  def initialize(name)
    super(name)
  end

  def add_test(a0, a1)
      @test_in[0] << a0
      @test_in[1] << a1
  end

  def gen_tests
    @test_in, @test_out = [[],[]], []
    
    20.times do
      add_test gen_array(rand(1...20), 1..20), gen_array(rand(1...20), 1..20)
    end

    30.times do
      add_test gen_array(rand(1...50), 1..50), gen_array(rand(1...50), 1..50)
    end
  end
end

Test_zigzag_iterator.new 'zigzag-iterator'