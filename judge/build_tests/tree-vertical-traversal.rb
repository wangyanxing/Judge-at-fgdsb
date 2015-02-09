require './common'
require '../ruby/common'

class Test_tree_vertical_traversal < TestBase
  def initialize(name)
    super(name)
  end
  
  def vertical_traversal(root)
    def minmax(node, min_max, d)
      return if node.nil?
      min_max[0],min_max[1] = [min_max[0],d].min, [min_max[1],d].max
      minmax(node.left, min_max, d - 1)
      minmax(node.right, min_max, d + 1)
      min_max
    end

    def solve(node, d, cur, sln)
      return if node.nil?
      sln << node.val if d == cur
      solve(node.left, d, cur - 1, sln)
      solve(node.right, d, cur + 1, sln)
    end

    min_hd, max_hd = minmax(root, [Integer::MAX, Integer::MIN], 0)

    ret = []
    (min_hd..max_hd).each do |i|
      sln = []
      solve(root, i, 0, sln)
      ret << sln.dup
    end
    ret
  end

  def add_test(nums)
    t = gen_tree nums
	  @test_in[0] << t
    @test_out << vertical_traversal(t)
  end

  def gen_tests
    @test_in, @test_out = [[]], []
    
    20.times do
	  add_test rand(5...10)
    end
#=begin
    50.times do
      add_test rand(50...100)
    end

    50.times do
      add_test rand(500...800)
    end
#=end
  end
end

Test_tree_vertical_traversal.new 'tree-vertical-traversal'