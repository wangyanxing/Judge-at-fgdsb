require './common'
require '../ruby/common'

class Test_search_sorted_mat < TestBase
  def initialize(name)
    super(name)
  end

  def add_test
  end

  def gen_tests
    @test_in, @test_out = [[]], []
  end
end

Test_search_sorted_mat.new 'search-sorted-mat'