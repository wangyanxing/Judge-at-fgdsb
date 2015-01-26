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