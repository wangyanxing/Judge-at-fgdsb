require './common'
require '../ruby/common'

class Test_coin_change < TestBase
  def initialize(name)
    super(name)
  end

  def min_coins(a, t)
    dp = Array.new(t+1, 0)
    (1..t).each do |i|
      minVal = i
      (0...a.length).each do |j|
        if a[j] <= i
          minVal = [dp[i-a[j]]+1, minVal].min
        else
          break
        end
      end
      dp[i] = minVal
    end
    dp[t]
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
    add_test [1,2,5], 4
    add_test [1,2,5], 5
    add_test [1,2,5], 10
  end
end

Test_coin_change.new 'coin-change'