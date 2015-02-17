from common import *
# class Iterator:
#   def get_next(self):
#       ...
#
#   def has_next(self):
#       ...

class PeekIterator:
    # @param it: Iterator object
    def __init__(self, it):
        self.it, self.peeks = it, None
    
    # @return integer
    def peek(self):
        if self.peeks == None:
            self.peeks = self.it.get_next()
        return self.peeks
    
    # @return boolean
    def has_next(self):
        return self.it.has_next() or self.peeks != None
    
    # @return integer
    def get_next(self):
        if self.peeks == None:
            return self.it.get_next()
        else:
            ret = self.peeks
            self.peeks = None
            return ret