require './common'
require '../ruby/common'

class Test_search_sorted_mat < TestBase
  def initialize(name)
    super(name)
  end

  def gen_sorted_mat(m, n)
    start = rand(1...50)
    ret = [[start]]
    (1...n).each do |i|
      ret[0] << ret[0][-1] + rand(1..10)
    end

    (1...m).each do |i|
      ret << [ret[-1][0] + rand(1..10)]
    end

    (1...m).each do |i|
      (1...n).each do |j|
        ret[i][j] = [ret[i-1][j], ret[i][j-1]].max + rand(1..10)
      end
    end
    ret
  end

  def search_matrix(mat, t)
    (0...mat.length).each do |i|
      (0...mat[0].length).each do |j|
        return true if mat[i][j] == t
      end
    end
    false
  end

  def add_test(mat)
    range = mat[0][0]...mat[-1][-1]
    selected = []

    5.times do
      rd = rand(range)
      while selected.include? rd
        rd = rand(range)
      end
      selected << rd

      @test_in[0] << mat
      @test_in[1] << rd
      @test_out << search_matrix(mat, rd)
    end
  end

  def gen_tests
    @test_in, @test_out = [[],[]], []

    add_test [[1, 2, 4],
              [2, 6, 8],
              [3, 7, 9]]

    add_test [[1, 2, 4],
              [2, 6, 8]]

    add_test [[1, 2],
              [2, 6],
              [3, 7]]

    10.times do
      add_test gen_sorted_mat(rand(5...20), rand(5...20))
    end

    5.times do
      add_test gen_sorted_mat(rand(30...50), rand(30...50))
    end
  end
end

Test_search_sorted_mat.new 'search-sorted-mat'