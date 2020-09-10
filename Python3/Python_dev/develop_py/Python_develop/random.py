#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
import random
def compareNum(num1,num2):
    if(num1 > num2):
        return 1
    elif(num1 == num2):
        return 0
    else:
        return -1

num1 =range.randrange(1, 9)
num2 =range.randrange(1, 9)
print "num1 =",num1
print "num2 = ",num2
print compareNum(num1,num2)
