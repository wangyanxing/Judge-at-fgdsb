from common import *
# class Iterator:
#   def get_next(self):
#       ...
#
#   def has_next(self):
#       ...

class ZigzagIterator:
    # @param i0: Iterator object, i1: Iterator object
    def __init__(self, i0, i1):
        self.its = [i0,i1]
        if i0.has_next(): self.pointer = 0
        else: self.pointer = 1
    
    # @return boolean
    def has_next(self):
        return self.its[self.pointer].has_next()
    
    # @return integer
    def get_next(self):
        ret, old = self.its[self.pointer].get_next(), self.pointer;
        while True:
            self.pointer = (self.pointer + 1) % 2
            if self.its[self.pointer].has_next() or self.pointer == old: break
        return ret