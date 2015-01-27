import sys
import datetime
from common import *
from tests.segregate_even_odd import *

def segregate(arr):
	l, r = 0, len(arr) - 1
	while(l < r):
		while((arr[l] % 2 == 0) and (l < r)):
			l += 1
		while((arr[r] % 2 != 0) and (l < r)):
			r -= 1
		if(l < r):
			arr[l], arr[r] = arr[r], arr[l]
			l += 1
			r -= 1


start_time = datetime.datetime.now()

for i in range(num_test):
    answer = segregate(in_0[i])
    answer = in_0[i];
    if not test(i):
        out_str = ""
        out_str += str(i+1) + " / " + str(num_test) + ";"
        out_str += str(in_org_0[i])
        out_str += ";"
        out_str += str(answer)
        out_str += ";"
        out_str += str(out[i])
        print(out_str)
        sys.exit(0)
delta = datetime.datetime.now() - start_time
runtime = str(int(delta.total_seconds() * 1000))
print('Accepted;' + runtime)
