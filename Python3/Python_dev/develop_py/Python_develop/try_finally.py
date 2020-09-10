#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python

try:
    f = open("hello.txt","r")
    try:
         print f.read(5)
    except:
        print "read the file error"
    finally:
        print "release resources"
        f.close()
except IOError:
    print "the file does not exist"


