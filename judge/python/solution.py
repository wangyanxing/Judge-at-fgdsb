from common import *
def smallest_character(str, c):
    for i in range(len(str)):
        if str[i] > c: return str[i]
    return str[0]