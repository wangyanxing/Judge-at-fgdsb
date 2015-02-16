require './common'
require '../ruby/common'

class Test_longest_inc_seq_matrix < TestBase
  def initialize(name)
    super(name)
  end

  def add_test
  end

  def gen_tests
    @test_in, @test_out = [[]], []
  end
end

Test_longest_inc_seq_matrix.new 'longest-inc-seq-matrix'