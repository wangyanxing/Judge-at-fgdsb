require './common'
require '../ruby/common'

class Test_max_sum_nonconsecutive_elements < TestBase
  def initialize(name)
    super(name)
  end

  def add_test
  end

  def gen_tests
    @test_in, @test_out = [[]], []
  end
end

Test_max_sum_nonconsecutive_elements.new 'max-sum-nonconsecutive-elements'