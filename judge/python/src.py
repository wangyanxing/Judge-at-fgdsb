import sys
import datetime
from common import *
from tests.second_largest_number import *

def second_largest(arr):
    if len(arr) < 2: return 0
    second_max, max_val = arr[0], arr[0]
    for i in range(1, len(arr)):
        if arr[i] > max_val:
            second_max = max_val
            max_val = arr[i]
        elif arr[i] > second_max and arr[i] != max_val:
            second_max = arr[i]
    if second_max == max_val: return 0
    else: return second_max


start_time = datetime.datetime.now()

for i in range(num_test):
    answer = second_largest(in_0[i])
    if answer != out[i] :
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
