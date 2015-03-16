require 'set'

# @param n,integer
# @return boolean
def happy(n)
    m, digit = 0, 0
    cycle = Set.new
    while n != 1 and !cycle.include?(n)
        cycle << n
        m = 0
        while n > 0
            digit = n % 10
            m += digit ** 2
            n /= 10
        end
        n = m
    end
    n == 1
end