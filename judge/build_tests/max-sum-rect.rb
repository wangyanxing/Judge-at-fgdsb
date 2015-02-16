require './common'
require '../ruby/common'

class Test_max_sum_rect < TestBase
  def initialize(name)
    super(name)
  end

  def add_test
  end

  def gen_tests
    @test_in, @test_out = [[]], []
  end
end

Test_max_sum_rect.new 'max-sum-rect'