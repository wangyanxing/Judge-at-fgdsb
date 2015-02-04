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
public class Solution {
    public int min_rooms(Interval[] meetings) {
        Comparator<Integer> cp = new Comparator<Integer>() {
			public int compare(Integer a, Integer b) {
			    Integer abs_a = Math.abs(a);
			    Integer abs_b = Math.abs(b);
			    if(abs_a.equals(abs_b)) return a.compareTo(b);
				else return abs_a.compareTo(abs_b);
			}
		};
		
		Integer[] times = new Integer[meetings.length*2];
        for(int i = 0; i < meetings.length; ++i) {
            times[i*2] = meetings[i].begin;
            times[i*2 + 1] = -meetings[i].end;
        }   
        Arrays.sort(times, cp);
        int ret = 0, cur = 0;
        for(int i = 0; i < times.length; ++i) {
            if(times[i] >= 0) ret = Math.max(ret, ++cur);
            else --cur;
        }
        return ret;
    }
}