#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
f = open("hello1.txt")
while True:
    line = f.readline()
    if line:
        print line,
    else:
        break
f.close()