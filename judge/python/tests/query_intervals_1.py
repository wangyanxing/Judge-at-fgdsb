from common import *
from solution import *
import copy
import sys
import datetime

num_test = 120
true, false = True, False
in_0 = []
in_org_0 = []
in_1 = []
in_org_1 = []
out = []


def load_test():
    f = open('judge/tests/query-intervals-1.txt', 'r')
    global in_0, in_org_0, in_1, in_org_1
    in_0 = read_interval_matrix(f)
    in_org_0 = copy.deepcopy(in_0)
    in_1 = read_int_array(f)
    in_org_1 = copy.deepcopy(in_1)
    global out
    out = read_bool_matrix(f)
    f.close

def judge():
    load_test()
    start_time = datetime.datetime.now()
    for i in range(num_test):
        inte = Intervals(in_0[i])
        inte.preprocess()
        for j in range(in_1[i]):
            answer = inte.query(j)
            if (answer != out[i][j]):
                out_str = str(i+1) + " / " + str(num_test) + ";"
                out_str += str(in_org_0[i]) + ", " + str(j)
                out_str += ";"
                out_str += str(answer)
                out_str += ";"
                out_str += str(out[i][j])
                print(out_str)
                return

    delta = datetime.datetime.now() - start_time
    runtime = str(int(delta.total_seconds() * 1000))
    print('Accepted;' + runtime)
