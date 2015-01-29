from common import *
from solution import *
import copy
import sys
import datetime

num_test = 50
true, false = True, False
in_0 = []
in_org_0 = []
out = []
def test(i):
    if not test_anagram(in_0[i], in_org_0[i]): return False
    flag = False
    for i, num in enumerate(in_0[i]):
        if num % 2 == 0:
            if flag: return False
        else:
            flag = True
    return True

def load_test():
    f = open('judge/tests/segregate-even-odd.txt', 'r')
    global in_0, in_org_0
    in_0 = read_int_matrix(f)
    in_org_0 = copy.deepcopy(in_0)
    global out
    out = read_int_matrix(f)
    f.close

def judge():
    load_test()
    start_time = datetime.datetime.now()
    for i in range(num_test):
        answer = segregate(in_0[i]) 
        if (not test(i)):
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
