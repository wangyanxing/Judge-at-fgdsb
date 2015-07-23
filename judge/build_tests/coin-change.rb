require './common'
require '../ruby/common'

class Test_coin_change < TestBase
  def initialize(name)
    super(name)
  end

  def dfs(index, stack, a, t)
    if stack[0] == t
        return true
        end
    if stack[0] > t
        return false
        end
    for i in (index).downto(0) do
        stack[0] += a[i]
        stack.push(a[i])
        if dfs(i, stack, a, t)
            return true
            end
        stack[0] -= a[i]
        stack.pop()
        end
    false
    end
    
  def min_coins(a, t)
    stack = [0]
    a.sort()
    dfs(a.length - 1, stack, a, t)
    print stack.length - 1
    stack.length - 1
    end

  def add_test(a, t)
    @test_in[0] << a
    @test_in[1] << t
    @test_out << min_coins(a, t)
  end

  def gen_tests
    @test_in, @test_out = [[],[]], []
    add_test [1,2], 3
    add_test [1,2], 2

    (1..100).each do |i|
      add_test [1,2,5], i
    end

    (1..100).each do |i|
      add_test [2,5,10], i
    end

    (1..50).each do |i|
      add_test [2,4,6,8], i
    end

    (1..50).each do |i|
      add_test [1,3,5,7], i
    end
  end
end

Test_coin_change.new 'coin-change'