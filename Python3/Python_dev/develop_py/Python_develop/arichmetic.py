#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
def arithmetic(x = 1,y = 1,operator = " + "):
    result = {
        "+":x + y,
        "-":x - y,
        "*":x * y,
        "/":x/y
        }
    return result.get(operator)
print arithmetic(1,2)
print arithmetic(1,2,"-")
print arithmetic(y=3,operator=" -")
print arithmetic(x =4,operator="-")
print arithmetic(y=3,x=4,operator="-")

