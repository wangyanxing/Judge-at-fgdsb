package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; /*
public class Point {
    public int x = 0, y = 0;
    public Point() {}
    public Point(int x, int y) {
        this.x = x;
        this.y = y;
    }
}
*/
public class Solution {
    void search(Point pt, HashMap<Point,Boolean> visited, int[][] mat) {
        int[][] dirs = {{0,1}, {0,-1}, {1,0}, {-1,0}};
        for(int i = 0; i < 4; ++i) {
            int[] dir = dirs[i];
            Point new_pt = new Point(dir[0] + pt.x, dir[1] + pt.y);
            if( new_pt.x < 0 || new_pt.x >= mat.length || new_pt.y < 0 || new_pt.y >= mat.length ) {
                continue;
            }
            if( mat[new_pt.x][new_pt.y] < mat[pt.x][pt.y] || visited.containsKey(new_pt) ) {
                continue;
            }
            visited.put(new_pt, true);
            search(new_pt, visited, mat);
        }
    }
    
    public List<Point> flowing_water(int[][] mat) {
        int n = mat.length;
        
        HashMap<Point, Boolean> visited_pac = new HashMap<Point, Boolean>();
        
        for(int i = 0; i < n; ++i) {
            Point p = new Point(0,i);
            visited_pac.put(p, true);
            search(p, visited_pac, mat);
        }
        
        for(int i = 0; i < n; ++i) {
            Point p = new Point(i,0);
            visited_pac.put(p, true);
            search(p, visited_pac, mat);
        }
        
        HashMap<Point, Boolean> visited_alt = new HashMap<Point, Boolean>();
        
        for(int i = 0; i < n; ++i) {
            Point p = new Point(n-1,i);
            visited_alt.put(p, true);
            search(p, visited_alt, mat);
        }
        
        for(int i = 0; i < n; ++i) {
            Point p = new Point(i,n-1);
            visited_alt.put(p, true);
            search(p, visited_alt, mat);
        }
        
        ArrayList<Point> ret = new ArrayList<Point>();
        for(Point key : visited_alt.keySet()) {
            if(visited_pac.containsKey(key)) {
                ret.add(key);
            }
        }
        
        Collections.sort(ret);
        return ret;
    }
}