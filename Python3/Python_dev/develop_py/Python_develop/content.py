#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
context = '''hello world
hello China
'''
f = file('hello.txt','w')
f.write(context)
f.close()
