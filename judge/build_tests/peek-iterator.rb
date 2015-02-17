require './common'
require '../ruby/common'

class Test_peek_iterator < TestBase
  def initialize(name)
    @manual_test = true
    super(name)
  end

  def add_test(arr)
    @test_in[0] << arr
  end

  def gen_tests
    @test_in, @test_out = [[]], []

    20.times do
      add_test gen_array(rand(1...20), 1..20)
    end

    30.times do
      add_test gen_array(rand(1...50), 1..50)
    end
  end
end

Test_peek_iterator.new 'peek-iterator'