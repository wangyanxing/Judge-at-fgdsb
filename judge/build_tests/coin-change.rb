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