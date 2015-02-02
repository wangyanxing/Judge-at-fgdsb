package datastruct;

public class Interval {
    public int begin = 0, end = 0;
    public Interval() {}
    public Interval(int b, int e) {
        begin = b;
        end = e;
    }
    
    public String toString() {
        return "[" + Integer.toString(begin) + ", " + Integer.toString(end) + "]";
    }
}