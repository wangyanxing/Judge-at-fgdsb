require './common'
require '../ruby/common'

class Test_max_sum_rect < TestBase
  def initialize(name)
    super(name)
  end

  def max_sum_rect(mat)
    n, m = mat.length, mat[0].length
    col_sum = mat.map(&:dup)

    (1...n).each do |i|
      (0...m).each do |j|
        col_sum[i][j] += col_sum[i-1][j]
      end
    end

    ret = 0
    (0...n).each do |row|
      (0..row).each do |t|
        min_left, row_sum = 0, Array.new(m)
        (0...m).each do |i|
          col = t == 0 ? col_sum[row][i] : col_sum[row][i] - col_sum[t-1][i]
          row_sum[i] = i == 0? col : col + row_sum[i-1]
          ret = [ret, row_sum[i] - min_left].max
          min_left = [min_left, row_sum[i]].min
        end
      end
    end
    ret
  end

  def add_test(mat)
    @test_in[0] << mat
    @test_out << max_sum_rect(mat)
  end

  def gen_tests
    @test_in, @test_out = [[]], []

    add_test [[ 1,   2,  -1,  -4, -20],
              [-8,  -3,   4,   2,   1],
              [ 3,   8,  10,   1,   3],
              [-4,  -1,   1,   7,  -6]]

    add_test [[ 1,   2],
              [-3,   4]]

    add_test [[ 1,   2],
              [ 3,   4]]

    add_test [[ 1,  -2],
              [-3,   4]]

    add_test [[-1,  -2],
              [-3,  -4]]

    45.times do
      add_test gen_matrix(rand(5...30), rand(5...30), -100..100)
    end

    10.times do
      add_test gen_matrix(rand(50...80), rand(50...80), -500..500)
    end
  end
end

Test_max_sum_rect.new 'max-sum-rect'