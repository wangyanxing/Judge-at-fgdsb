from common import *
# @param arr, list of integers
# @param t, integer
def subarray_sum(arr, t):
    sum, last = arr[0], 0
    for i in range(1, len(arr)):
        while sum > t:
            sum -= arr[last]
            last += 1
        if sum == t: return True
        sum += arr[i]
    return sum == t