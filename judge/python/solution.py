from common import *
def dfs(i,j,mat):
  m,n = len(mat), len(mat[0])
  dirs = [[0,1], [0,-1], [1,0], [-1,0]]
  for _, dir in enumerate(dirs):
    newi, newj = i + dir[0], j + dir[1]
    if newi < 0 or newj < 0 or newi >= m or newj >= n: continue
    if mat[newi][newj] != 1: continue

    mat[newi][newj] = mat[i][j]
    dfs(newi,newj,mat)

def num_islands(mat):
  m,n = len(mat), len(mat[0])
  count = 2
  for i in range(m):
    for j in range(n):
      if mat[i][j] != 1: continue
      mat[i][j] = count
      count += 1
      dfs(i,j,mat)
  return count - 2