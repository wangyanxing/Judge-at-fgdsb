# @param a, integer array
def product(a)
    ret = Array.new(a.length)
    prod = 1
    (0...a.length).each do |i|
        prod *= a[i]
        ret[i] = prod
    end
    prod = 1
    (0...a.length).reverse_each do |i|
        if i > 0
            ret[i] = ret[i-1] * prod
        else
            ret[i] = prod
        end
        prod *= a[i]
    end
    ret
end