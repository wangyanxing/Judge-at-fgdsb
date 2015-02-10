package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; public class Solution {
    private int[][] mat;
    
    public int num_islands(int[][] mat) {
        this.mat = mat;
        int count = 2;
        for(int i = 0; i < mat.length; ++i) {
            for(int j = 0; j < mat[0].length; ++j) {
                if(mat[i][j] == 1) {
                    mat[i][j] = count++;
                    dfs(i,j);
                }
            }
        }
        return count - 2;
    }
    
    private void dfs(int i, int j) {
        int m = mat.length, n = mat[0].length;
        int[][] dirs = {{0,1}, {0,-1}, {1,0}, {-1,0}};
        for(int id = 0; id < 4; ++id) {
            int newi = i + dirs[id][0], newj = j + dirs[id][1];
            if (newi < 0 || newj < 0 || newi >= m || newj >= n) continue;
            if (mat[newi][newj] != 1) continue;
            mat[newi][newj] = mat[i][j];
            dfs(newi,newj);
        }
    }
}