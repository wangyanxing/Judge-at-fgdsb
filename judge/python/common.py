import copy
import sys

# data structures
class Interval:
    def __init__(self, b=0, e=0):
        self.begin = b
        self.end = e
    
    def __str__(self):
        return "[" + str(self.begin) + ", " + str(self.end) + "]"

    def __repr__(self):
        return self.__str__()
    
    def __eq__(self, other):
        return self.begin == other.begin and self.end == other.end

class Point:
    def __init__(self, x=0, y=0):
        self.x = x
        self.y = y
    
    def __str__(self):
        return "(" + str(self.x) + ", " + str(self.y) + ")"
    
    def __repr__(self):
        return self.__str__()
    
    def __eq__(self, other):
        return self.x == other.x and self.y == other.y

def serial(root):
    if root == None: return "# "
    ret = str(root.val) + ' '
    ret += serial(root.left)
    ret += serial(root.right)
    return ret

class TreeNode:
    def __init__(self, v=0):
        self.val, self.left, self.right = v, None, None
    
    def __str__(self):
        return serial(self)
    
    def __repr__(self):
        return self.__str__()

############################################################

def node_equals(n1, n2):
    if n1 == None and n2 == None: return True
    if n1 == None or n2 == None: return False
    return n1.val == n2.val

def node_to_string(n):
    if n == None: return "None"
    return str(n.val)

############################################################

# test anagram
def test_anagram(a0, a1):
    if len(a0) != len(a1) : return False
    t0, t1 = copy.deepcopy(a0), copy.deepcopy(a1)
    t0.sort()
    t1.sort()
    return cmp(t0, t1) == 0

# loaders
def read_tree(f, nums):
    if nums == 0: return None
    cur = f.readline().rstrip('\r|\n')
    if(cur == "#"): return None
    
    root = TreeNode(int(cur))
    nums -= 1
    root.left = read_tree(f, nums)
    nums -= 1
    root.right = read_tree(f, nums)
    return root

def read_tree_array(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        n = int(f.readline())
        ret.append(read_tree(f, n))
    return ret

def read_tree_matrix(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        ret.append(read_tree_array(f))
    return ret

def read_point_array(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        b = int(f.readline())
        e = int(f.readline())
        ret.append(Point(b,e))
    return ret

def read_point_matrix(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        ret.append(read_point_array(f))
    return ret

def read_point_matrix_arr(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        ret.append(read_point_matrix(f))
    return ret

def read_interval_array(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        b = int(f.readline())
        e = int(f.readline())
        ret.append(Interval(b,e))
    return ret

def read_interval_matrix(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        ret.append(read_interval_array(f))
    return ret

def read_interval_matrix_arr(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        ret.append(read_interval_matrix(f))
    return ret

def read_int_array(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        ret.append(int(f.readline()))
    return ret

def read_int_matrix(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        ret.append(read_int_array(f))
    return ret

def read_int_matrix_arr(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        ret.append(read_int_matrix(f))
    return ret

def read_double_array(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        ret.append(float(f.readline()))
    return ret

def read_double_matrix(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        ret.append(read_double_array(f))
    return ret

def read_double_matrix_arr(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        ret.append(read_double_matrix(f))
    return ret

def read_string_array(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        ret.append(f.readline().rstrip('\r|\n'))
    return ret

def read_string_matrix(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        ret.append(read_string_array(f))
    return ret

def read_string_matrix_arr(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        ret.append(read_string_matrix(f))
    return ret

def read_bool_array(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        val = int(f.readline())
        if val == 1: ret.append(True)
        else: ret.append(False)
    return ret

def read_bool_matrix(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        ret.append(read_bool_array(f))
    return ret

def read_bool_matrix_arr(f) :
    num = int(f.readline())
    ret = []
    for i in range(num):
        ret.append(read_bool_matrix(f))
    return ret

OrigStdOut = sys.stdout

def capture_stdout() :
    sys.stdout = open('judge/stdout.txt', 'w')

def release_stdout() :
    global OrigStdOut
    sys.stdout = OrigStdOut