from common import *
from solution import *
import copy
import sys
import datetime

num_test = 55
true, false = True, False
in_0 = []
in_org_0 = []
in_1 = []
in_org_1 = []
out = []


class ZigzagIterator_ref:
    def __init__(self, i0, i1):
        self.its = [i0,i1]
        if i0.has_next(): self.pointer = 0
        else: self.pointer = 1
    
    def has_next(self):
        return self.its[self.pointer].has_next()
    
    def get_next(self):
        ret, old = self.its[self.pointer].get_next(), self.pointer;
        while True:
            self.pointer = (self.pointer + 1) % 2
            if self.its[self.pointer].has_next() or self.pointer == old: break
        return ret


def load_test():
    f = open('judge/tests/zigzag-iterator.txt', 'r')
    global in_0, in_org_0
    in_0 = read_int_matrix(f)
    in_org_0 = copy.deepcopy(in_0)
    global in_1, in_org_1
    in_1 = read_int_matrix(f)
    in_org_1 = copy.deepcopy(in_1)
    global out
    out = read_bool_array(f)
    f.close

def judge():
    load_test()
    capture_stdout()
    start_time = datetime.datetime.now()
    for i in range(num_test):
        print ('Testing case #' + str(i+1))
        
        pi = ZigzagIterator(Iterator(in_0[i]), Iterator(in_1[i]))
        w = []
        while pi.has_next(): w.append(pi.get_next())
        
        wi = ZigzagIterator_ref(Iterator(in_0[i]), Iterator(in_1[i]))
        wo = []
        while wi.has_next(): wo.append(wi.get_next())

        if w != wo:
            release_stdout()
            out_str = str(i+1) + " / " + str(num_test) + ";"
            out_str += str(in_org_0[i])
            out_str += ", "
            out_str += str(in_org_1[i])
            out_str += ";"
            out_str += str(w)
            out_str += ";"
            out_str += str(wo)
            print(out_str)
            return

    release_stdout()
    delta = datetime.datetime.now() - start_time
    runtime = str(int(delta.total_seconds() * 1000))
    print('Accepted;' + runtime)
