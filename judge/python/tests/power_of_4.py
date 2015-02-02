from common import *
from solution import *
import copy
import sys
import datetime

num_test = 260
true, false = True, False
in_0 = []
in_org_0 = []
out = []


def load_test():
    f = open('judge/tests/power-of-4.txt', 'r')
    global in_0, in_org_0
    in_0 = read_int_array(f)
    in_org_0 = copy.deepcopy(in_0)
    global out
    out = read_bool_array(f)
    f.close

def judge():
    load_test()
    start_time = datetime.datetime.now()
    for i in range(num_test):
        answer = power_of_4(in_0[i]) 
        if (answer != out[i]):
            out_str = str(i+1) + " / " + str(num_test) + ";"
            out_str += str(in_org_0[i])
            out_str += ";"
            out_str += str(answer)
            out_str += ";"
            out_str += str(out[i])
            print(out_str)
            return

    delta = datetime.datetime.now() - start_time
    runtime = str(int(delta.total_seconds() * 1000))
    print('Accepted;' + runtime)
