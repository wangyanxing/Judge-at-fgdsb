# @param a: integer, b: integer
# @return integer
def hamming(a, b)
    res = 0
    while a >0 or b > 0
        res += 1 if a == 0 or b == 0 or a % 10 != b % 10
        a, b = a / 10, b / 10
    end
    res
end