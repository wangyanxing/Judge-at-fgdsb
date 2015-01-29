from common import *
from solution import *
import copy
import sys
import datetime

num_test = 50
true, false = True, False
in_0 = []
in_org_0 = []
in_1 = []
in_org_1 = []
out = []
def test(answer, i):
    if len(out[i]) != len(answer): return False
    if out[i][0] == -1 and out[i][1] == -1:
        return answer[0] == -1 and answer[1] == -1
    else:
        if answer[0] == -1 or answer[1] == -1:
            return False
        else:
            return abs(in_0[i][answer[0]] - in_0[i][answer[1]]) == in_1[i]
		

def load_test():
    f = open('judge/tests/two-difference.txt', 'r')
    global in_0, in_org_0
    in_0 = read_int_matrix(f)
    in_org_0 = copy.deepcopy(in_0)
    global in_1, in_org_1
    in_1 = read_int_array(f)
    in_org_1 = copy.deepcopy(in_1)
    global out
    out = read_int_matrix(f)
    f.close

def judge():
    load_test()
    start_time = datetime.datetime.now()
    for i in range(num_test):
        answer = two_dif(in_0[i], in_1[i]) 
        if (not test(answer, i)):
            out_str = str(i+1) + " / " + str(num_test) + ";"
            out_str += str(in_org_0[i])
            out_str += ", "
            out_str += str(in_org_1[i])
            out_str += ";"
            out_str += str(answer)
            out_str += ";"
            out_str += str(out[i])
            print(out_str)
            return

    delta = datetime.datetime.now() - start_time
    runtime = str(int(delta.total_seconds() * 1000))
    print('Accepted;' + runtime)
