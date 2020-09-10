#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
#this mem.py is writed by to get memory info from the minion. 20160522
'''
Module for squid disk information by python

'''
import commands
#from commands import *
import os

def cache():
    '''
    Return the memory usage information for volumes mounted on this minion
    '''
    grains={}
    m = commands.getoutput("free -g|awk '$0~/Mem/ {print$2+1}")
    grains['mem_test'] = int(m)
    return grains