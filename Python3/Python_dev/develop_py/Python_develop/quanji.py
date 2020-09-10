#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
_a = 1
_b = 2
def add():
    global _a
    _a = 3
    return "_a +_b =", _a + _b
def sub():
    global _b
    _b = 4
    return "_a -_b =", _a - _b
print add()
print sub()


c = 7 + 8j
print type(c)
str = '''the say"  " hello,world!!!'''
print str
class Hello:
    '''hello,class'''
    def printHello():
        '''print "hello,world" '''
        print "hello world!"
print Hello.__doc__
