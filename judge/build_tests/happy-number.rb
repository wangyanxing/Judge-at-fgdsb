require './common'
require '../ruby/common'

class Test_happy_number < TestBase
  def initialize(name)
    super(name)
  end

  def add_test
  end

  def gen_tests
    @test_in, @test_out = [[]], []
  end
end

Test_happy_number.new 'happy-number'