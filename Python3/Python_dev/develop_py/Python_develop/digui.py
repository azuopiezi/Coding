#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
def refunc(n):
    i = 1
    if n > 1:
        i = n
        n = n * refunc(n - 1)
    print "% d ! = " % i , n
    return n
refunc(5)

def func():
    x = 1
    y = 2
    m = 3
    n = 4
    sum = lambda x,y:x + y
    print sum
    sub = lambda m,n:m - n
    print sub
    return sum(x,y) * sub(m,n)
print func()



