require './common'
require '../ruby/common'

class Test_find_islands < TestBase
  def initialize(name)
    super(name)
  end

  def dfs(i,j,mat)
    m,n = mat.length, mat[0].length

    [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |x,y|
      newi, newj = i + x, j + y
      next if newi < 0 || newj < 0 || newi >= m || newj >= n
      next if mat[newi][newj] != 1
      mat[newi][newj] = mat[i][j]
      dfs(newi,newj,mat)
    end
  end

  def num_islands(mat)
    m,n = mat.length, mat[0].length

    count = 2
    ((0...m).to_a.product (0...n).to_a).each do |i,j|
      next if mat[i][j] != 1
      mat[i][j] = count
      count += 1
      dfs(i,j,mat)
    end
    count - 2
  end

  def add_test(m,n)
    r = gen_matrix(m,n,2)
    @test_in[0] << r
    @test_out << num_islands(r.map(&:dup))
  end

  def gen_tests
    @test_in, @test_out = [[]], []

    20.times do
      add_test rand(3...5),rand(3...5)
    end

    50.times do
      add_test rand(30...50),rand(30...50)
    end

    2.times do
      add_test rand(100...200),rand(100...200)
    end
  end
end

Test_find_islands.new 'find-islands'