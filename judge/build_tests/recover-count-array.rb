require './common'
require '../ruby/common'

class Test_recover_count_array < TestBase
  def initialize(name)
    super(name)
  end

  def add_test
  end

  def gen_tests
    @test_in, @test_out = [[]], []
  end
end

Test_recover_count_array.new 'recover-count-array'