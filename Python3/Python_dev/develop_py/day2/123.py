#!/usr/bin/python
# -*- coding: UTF-8 -*-
class switch(object):
    def __init__(self,value):
        self.value = value
        self.fall = False

    def __iter__(self):
        yield self.match
        raise StopIteration

    def match(self,*args):
        if self.fall or not args:
            return True
        elif self.value in args:
            self.fall = True
            return True
        else:
            return False
operator = "+"
x = 1
y = 2
for case in switch(operator):
    if case('+'):
        print x + y
        break

    if case('-'):
        print x - y
        break
    if case('*'):
        print x * y
        break

    if case('/'):
        print x / y
        break
    if case():
        print ""

operator = "+"
x = 1
y = 2
for case in switch(operator):
    if case('+'):
        print x + y


    if case('-'):
        print x - y

    if case('*'):
        print x * y


    if case('/'):
        print x / y

    if case():
        print ""