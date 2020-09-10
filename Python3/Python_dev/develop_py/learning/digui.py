#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
#listdir.py

import os
def listyoudir(level,path):
    for i in os.listdir(path):
        print('  ' * (level +1 ) +i)
        if os.path.isdir(path + '\\' +i):
            listyoudir(level+1,path + '\\' +i)


rootpath = os.path.abspath('.')
print(rootpath)
listyoudir(0,rootpath)

