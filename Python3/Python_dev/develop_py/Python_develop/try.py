#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
try:
    file("hello1.txt","r")
    print "read the file content"
except IOError:
    print "file does not exist"
except:
    print "the program is ok!!!"

