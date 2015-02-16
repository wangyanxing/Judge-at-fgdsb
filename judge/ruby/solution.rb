# @param mat, matrix of integers
# @return array
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