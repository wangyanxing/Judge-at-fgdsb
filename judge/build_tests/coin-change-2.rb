require './common'
require '../ruby/common'

class Test_coin_change_2 < TestBase
  def initialize(name)
    super(name)
  end

  def add_test
  end

  def gen_tests
    @test_in, @test_out = [[]], []
  end
end

Test_coin_change_2.new 'coin-change-2'