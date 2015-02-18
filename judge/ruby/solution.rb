# class Iterator
#   def get_next()
#       ...
#   end   
#
#   def has_next()
#       ...
#   end
# end

class ZigzagIterator
    # @param i0: Iterator object, i1: Iterator object
    def initialize(i0, i1)
        @its, @pointer = [i0,i1], i0.has_next() ? 0 : 1
    end

    # @return boolean
    def has_next()
        @its[@pointer].has_next()
    end
    
    # @return integer
    def get_next()
        ret, old = @its[@pointer].get_next, @pointer;
        loop do 
            @pointer = (@pointer + 1) % 2
            break if @its[@pointer].has_next or @pointer == old
        end
        ret
    end
end