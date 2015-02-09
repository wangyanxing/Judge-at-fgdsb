require './common'
require '../ruby/common'

class Test_tree_vertical_traversal < TestBase
  def initialize(name)
    super(name)
  end

  def add_test
  end

  def gen_tests
    @test_in, @test_out = [[]], []
  end
end

Test_tree_vertical_traversal.new 'tree-vertical-traversal'