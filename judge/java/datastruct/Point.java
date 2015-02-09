package datastruct;

public class Point {
    public int x = 0, y = 0;
    public Point() {}
    public Point(int x, int y) {
        this.x = x;
        this.y = y;
    }
    
    public String toString() {
        return "(" + Integer.toString(x) + ", " + Integer.toString(y) + ")";
    }
}