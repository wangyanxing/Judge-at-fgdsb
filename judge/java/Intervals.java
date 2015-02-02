package judge;import java.util.*;import java.lang.*;import java.io.*;import datastruct.*; /*
public class Interval {
    public int begin = 0, end = 0;
    public Interval() {}
    public Interval(int b, int e) {
        begin = b;
        end = e;
    }
}
*/
public class Intervals {
    public Intervals(List<Interval> data) {
        intervals = data;
    }

    public void preprocess() {
        Collections.sort(intervals,new Comparator<Interval>(){
            public int compare(Interval i0,Interval i1){
                  if(i0.begin == i1.begin)
                      return i0.end - i1.end;
                  else
                      return i0.begin - i1.begin;
            }});
    }

    public List<Interval> query(int time) {
        List<Interval> ret = new ArrayList<>();
        for(Interval i : intervals) {
            if(time >= i.begin && time <= i.end) {
                ret.add(i);
            }
        }
        return ret;
    }
    List<Interval> intervals;
};
