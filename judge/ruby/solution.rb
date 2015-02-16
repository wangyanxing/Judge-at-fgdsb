# @param mat, integer matrix
# @return integer
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