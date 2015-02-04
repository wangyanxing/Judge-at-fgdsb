/*
struct Interval {
    int begin{ 0 }, end{ 0 };
};
*/
int min_rooms(vector<Interval>& meetings) {
    vector<int> times;
    times.reserve(meetings.size()*2);
    for(auto m : meetings) {
        times.push_back(m.begin);
        times.push_back(-m.end);
    }   
    sort(times.begin(), times.end(), [](int a, int b){
        return abs(a) == abs(b) ? a < b : abs(a) < abs(b);
    });   
    int ret = 0, cur = 0;
    for(auto t : times) {
        if(t >= 0) ret = max(ret, ++cur);
        else --cur;
    }
    return ret;
}