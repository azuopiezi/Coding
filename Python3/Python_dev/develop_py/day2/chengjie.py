#!/usr/bin/python
# -*- coding: UTF-8 -*-
def refunc(n):
    i=1
    if n > 1:
        i=n
        n=n * refunc(n-1)
    print "%d!=" %i,n
    return n
print "5!=",reduce(lambda x,y:x*y,range(1,6))
