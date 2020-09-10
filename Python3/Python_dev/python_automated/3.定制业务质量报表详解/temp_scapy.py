#!/usr/bin/python
# _*_ coding: utf-8 _*_

import os,sys,time,subprocess
import warnings,logging
#from scapy.layers.inet import traceroute

warnings.filterwarnings("ignore", category=DeprecationWarning)
logging.getLogger("scapy.runtime").setLevel(logging.ERROR)

from scapy import *

domains = raw_input('Please input one or more IP/domain: ')
target = domains.split(' ')
dport = [80]

if len(target) >= 1 and target[0]!='':
    res,unans = traceroute(target,dport,retry = -2)
    res.graph(target="> test.svg")
    time.sleep(1)
    subprocess.Popen("/usr/bin/convert test.svg test.png", shell=True)
else:
    print "IP/domain number of errors,exit"