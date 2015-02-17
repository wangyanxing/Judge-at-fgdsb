# class Iterator
#   def get_next()
#       ...
#   end   
#
#   def has_next()
#       ...
#   end
# end

class PeekIterator
    # @param it: Iterator object
    def initialize(it)
        @it, @peeks = it, nil
    end
    
    # @return integer
    def peek()
        @peeks = @it.get_next if @peeks.nil?
        @peeks
    end
    
    # @return boolean
    def has_next()
        @it.has_next or not @peeks.nil?
    end
    
    # @return integer
    def get_next()
        if @peeks.nil?
            @it.get_next
        else
            ret = @peeks
            @peeks = nil
            ret
        end
    end
end