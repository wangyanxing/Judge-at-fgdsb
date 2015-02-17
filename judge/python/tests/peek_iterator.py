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


def load_test():
    f = open('judge/tests/peek-iterator.txt', 'r')
    global in_0, in_org_0
    in_0 = read_int_matrix(f)
    in_org_0 = copy.deepcopy(in_0)
    global out
    out = read_bool_array(f)
    f.close

def judge():
    load_test()
    capture_stdout()
    start_time = datetime.datetime.now()
    for i in range(num_test):
        print ('Testing case #' + str(i+1))
        
        it = Iterator(in_0[i])
        pi = PeekIterator(it)

        for j in range(len(in_0[i])):
            num = in_0[i][j]
            has_next_wrong, peek_wrong, get_next_wrong = False, False, False
            
            if not pi.has_next(): has_next_wrong = True
            if pi.peek() != num: peek_wrong = True
            nxt = pi.get_next()
            if nxt != num: get_next_wrong = True
            
            if has_next_wrong or peek_wrong or get_next_wrong:
                release_stdout()
                
                msg = ''
                if has_next_wrong: msg += 'has_next() == False, '
                if peek_wrong: msg += 'peek() == ' + str(pi.peek()) + ', '
                if get_next_wrong: msg += 'get_next() == ' + str(nxt) + ', '
                
                expmsg = ''
                if has_next_wrong: expmsg += 'has_next() == True, '
                if peek_wrong: expmsg += 'peek() == ' + str(num) + ', '
                if get_next_wrong: expmsg += 'get_next() == ' + str(num) + ', '
                                
                out_str = str(i+1) + " / " + str(num_test) + ";"
                out_str += str(in_org_0[i]) + ', current element: ' + str(num)
                out_str += ";"
                out_str += msg[:-2]
                out_str += ";"
                out_str += expmsg[:-2]
                
                print(out_str)
                return

    release_stdout()
    delta = datetime.datetime.now() - start_time
    runtime = str(int(delta.total_seconds() * 1000))
    print('Accepted;' + runtime)
