#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
from __future__ import division
x = 1
y = 2
operator = "/"
result = {
    "+": x + y,
    "-": x - y,
    "*": x * y,
    "/": x / y
     }
print result.get(operator)
