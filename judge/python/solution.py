# @param a, integer list
def product(a):
    ret = [None] * len(a)
    
    prod = 1
    for i in range(len(a)):
        prod *= a[i]
        ret[i] = prod
        
    prod = 1
    for i in reversed(range(len(a))):
        if i > 0: ret[i] = ret[i-1] * prod
        else: ret[i] = prod
        prod *= a[i]
    return ret