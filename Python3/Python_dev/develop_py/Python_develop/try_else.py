#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python

try:
    result = 10/0
except ZeroDivisionError:
    print "0 bu neng zuo chu shu"
else:
    print result