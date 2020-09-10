#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python

try:
    s = None
    if s is None:
        print "s is a kong object"
        raise NameError
    print len(s)
except TypeError:
    print "kong duixiang meiyou changdu"
