import copy

def test_wiggle(arr):
    if not arr:
        return False
    test_flag = True
    for i in range(len(arr)-1):
        if test_flag:
            if arr[i] > arr[i+1]:
                return False
        else:
            if arr[i] < arr[i+1]:
                return False
        test_flag = not test_flag
    return True

# test anagram
def test_anagram(a0, a1):
    if len(a0) != len(a1) : return False
    t0, t1 = copy.deepcopy(a0), copy.deepcopy(a1)
    t0.sort()
    t1.sort()
    return cmp(t0, t1) == 0