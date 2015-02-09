package datastruct;

public class Point implements Comparable<Point> {
    public int x = 0, y = 0;
    public Point() {}
    public Point(int x, int y) {
        this.x = x;
        this.y = y;
    }
    
    @Override
    public String toString() {
        return "(" + Integer.toString(x) + ", " + Integer.toString(y) + ")";
    }
    
    @Override
    public int hashCode() {
        Integer val = x * 100000 + y;
        return val.hashCode();
    }
    
    @Override public boolean equals(Object other) {
        boolean result = false;
        if (other instanceof Point) {
            Point that = (Point) other;
            result = (this.x == that.x && this.y == that.y);
        }
        return result;
    }
    
    @Override public int compareTo(Point that) {
        if (this.x == that.x) return this.y - that.y;
        return this.x - that.x;
    }
}