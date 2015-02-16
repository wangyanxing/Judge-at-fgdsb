require './common'
require '../ruby/common'

class Test_longest_inc_seq_matrix < TestBase
  def initialize(name)
    super(name)
  end

  def longest_seq(mat)
    def dfs(mat, mem, i, j)
      return mem[i][j] if mem[i][j] != 0

      [[-1,0],[1,0],[0,-1],[0,1]].each do |d|
        newi, newj = i + d[0], j + d[1]
        next if newi < 0 or newj < 0 or newi >= mat.length or newj >= mat[0].length
        if mat[newi][newj] == mat[i][j] + 1
          new_val = dfs(mat, mem, newi, newj)
          mem[i][j] = [mem[i][j], new_val].max
        end
      end
      mem[i][j] += 1
    end

    m, n = mat.length, mat[0].length
    mem = Array.new(m) { Array.new(n, 0) }
    max_start, max_path = 0, 0
    (0...m).each do |i|
      (0...n).each do |j|
        path = dfs(mat, mem, i, j)
        if path > max_path
          max_start = mat[i][j]
          max_path = path
        end
      end
    end

    (max_start...(max_start + max_path)).to_a
  end

  def add_test(mat)
    @test_in[0] << mat
    @test_out << longest_seq(mat)
  end

  def gen_tests
    @test_in, @test_out = [[]], []

    add_test [[4, 3],
              [1, 2]]

    add_test [[1, 2, 3, 4],
              [8, 7, 6, 5]]

    add_test [[1, 2, 3, 9],
              [8, 7, 6, 5]]

    add_test [[1, 2, 3],
              [5, 7, 6]]

    add_test [[9, 5, 3],
              [8, 7, 4]]

    add_test [[1, 3],
              [5, 4]]

    30.times do
      add_test gen_matrix(5, 5, rand(1...10))
    end

    50.times do
      add_test gen_matrix(10, 10, rand(1...50))
    end

    10.times do
      add_test gen_matrix(100, 100, rand(1...200))
    end
  end
end

Test_longest_inc_seq_matrix.new 'longest-inc-seq-matrix'