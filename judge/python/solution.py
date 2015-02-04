# class Interval:
#     def __init__(self, b=0, e=0):
#     self.begin = b
#     self.end = e

def comparator(x, y):
    if abs(x) == abs(y): return x - y
    else: return abs(x) - abs(y)

# @param intervals, Intervals list
def min_rooms(meetings):
    times = [None] * len(meetings) * 2
    for i in range(len(meetings)):
        times[i*2] = meetings[i].begin
        times[i*2+1] = -meetings[i].end
    times.sort(comparator)
    ret, cur = 0, 0
    for t in times:
        if t >= 0:
            cur += 1
            ret = max(ret, cur)
        else:
            cur -= 1
    return ret