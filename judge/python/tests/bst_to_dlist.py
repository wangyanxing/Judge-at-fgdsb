from common import *
from solution import *
import copy
import sys
import datetime

num_test = 100
true, false = True, False
in_0 = []
in_org_0 = []
out = []

def check_dlist(arr, list):
	cur, pre, i = list, None, 0

	while(cur != None):
		if (i >= len(arr) or arr[i] != cur.val): return False
		i += 1
		pre = cur
		cur = cur.right

	if i != len(arr): return False
	cur = pre
	i -= 1
	while(cur != None):
		if (i < 0 or arr[i] != cur.val): return False
		i -= 1
		last = cur
		cur = cur.left
		last.left = None

	if i != -1: return False
	return True

def dlist_to_string(list):
	ret = "["
	first = True
	while(list != None):
		if not first: ret += ", "
		ret += str(list.val)
		list = list.right
		first = False
	return ret + "]"

def load_test():
    f = open('judge/tests/bst-to-dlist.txt', 'r')
    global in_0, in_org_0
    in_0 = read_tree_array(f)
    in_org_0 = copy.deepcopy(in_0)
    global out
    out = read_int_matrix(f)
    f.close

def judge():
    load_test()
    capture_stdout()
    start_time = datetime.datetime.now()
    for i in range(num_test):
        print ('Testing case #' + str(i+1))
        answer = bst_to_list(in_0[i]) 
        if (not check_dlist(out[i], answer)):
            release_stdout()
            out_str = str(i+1) + " / " + str(num_test) + ";"
            out_str += str(in_org_0[i])
            out_str += ";"
            out_str += dlist_to_string(answer)
            out_str += ";"
            out_str += str(out[i])
            print(out_str)
            return

    release_stdout()
    delta = datetime.datetime.now() - start_time
    runtime = str(int(delta.total_seconds() * 1000))
    print('Accepted;' + runtime)
