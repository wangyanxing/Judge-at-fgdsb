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
  (0...m).each do |i|
    (0...n).each do |j|
      next if mat[i][j] != 1
      mat[i][j] = count
      count += 1
      dfs(i,j,mat)
    end
  end
  count - 2
end