/*
struct Interval {
    int begin{ 0 }, end{ 0 };
};
*/
int max_intervals(vector<Interval>& intervals) {
    sort(intervals.begin(), intervals.end(), [&](Interval& a, Interval& b) {
        return a.end < b.end;
    });
    
    int ret = 1, i = 0;
    for(int l = i + 1; l < intervals.size(); ++l) {
        if(intervals[l].begin >= intervals[i].end) {
            ret++;
            i = l;
        }
    }
    return ret;
}