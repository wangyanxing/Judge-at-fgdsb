package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; public class Solution {
    public boolean search_matrix(int[][] mat, int target) {
        for(int i = 0; i < mat.length; ++i) {
            for(int j = 0; j < mat[0].length; ++j) {
                if(mat[i][j] == target) return true;
            }
        }
        return false;
    }
}