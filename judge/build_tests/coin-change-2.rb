require './common'
require '../ruby/common'

class Test_coin_change_2 < TestBase
  def initialize(name)
    super(name)
  end

  def count_changes(a, t)
    table = Array.new(t+1, 0)
    table[0] = 1
    (0...a.length).each do |i|
      (a[i]..t).each do |j|
        table[j] += table[j-a[i]]
      end
    end
    table[t]
  end

  def add_test(a, t)
    @test_in[0] << a
    @test_in[1] << t
    @test_out << count_changes(a, t)
  end

  def gen_tests
    @test_in, @test_out = [[],[]], []
    add_test [1,2], 3
    add_test [1,2], 2
    add_test [1,2], 5

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

Test_coin_change_2.new 'coin-change-2'