import sys
import datetime
from common import *
from tests.fence_painter import *

def num_colors(n, k):
	if n <= 0 or k <= 0: return 0
	prev_prev, prev = k, k * k
	for i in range(n-1):
		prev, prev_prev = (k - 1) * (prev_prev + prev), prev
	return prev_prev


start_time = datetime.datetime.now()

for i in range(num_test):
    answer = num_colors(in_0[i],in_1[i])
    if answer != out[i] :
        out_str = ""
        out_str += str(i+1) + " / " + str(num_test) + ";"
        out_str += str(in_org_0[i])
        out_str += ", "
        out_str += str(in_org_1[i])
        out_str += ";"
        out_str += str(answer)
        out_str += ";"
        out_str += str(out[i])
        print(out_str)
        sys.exit(0)
delta = datetime.datetime.now() - start_time
runtime = str(int(delta.total_seconds() * 1000))
print('Accepted;' + runtime)
