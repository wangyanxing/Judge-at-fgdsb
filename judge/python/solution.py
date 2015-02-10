from common import *
def smallest_character(str, c):
    l, r, ret = 0, len(str) - 1, str[0]
    while l <= r :
        m = l + (r-l) / 2
        print(str[m])
        if str[m] > c :
            ret, r = str[m], m - 1
        else :
            l = m + 1
    return ret