function dfs(i,j,mat)
  local m,n,dirs = #mat, #mat[1], {{0,1}, {0,-1}, {1,0}, {-1,0}} 
  for id = 1,#dirs do
    newi, newj = i + dirs[id][1], j + dirs[id][2]
    if newi <= 0 or newj <= 0 or newi > m or newj > n then goto continue end
    if mat[newi][newj] ~= 1 then goto continue end
    local x = mat[i][j]
    mat[newi][newj] = mat[i][j]
    dfs(newi,newj,mat)
    ::continue::
  end
end

function num_islands(mat)
  local count = 2
  for i = 1, #mat do
    for j = 1, #mat[1] do
      if mat[i][j] == 1 then
        mat[i][j] = count
        count = count + 1
        dfs(i,j,mat)
      end
    end
  end
  return count - 2
end