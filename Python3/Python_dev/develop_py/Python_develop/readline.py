#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
f = open("hello.txt")
while True:
    lines = f.readlines()
    for line in lines:
        print line
f.close()