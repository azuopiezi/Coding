# coding:utf-8
import os
from os import system,popen

import multiprocession as multi


cmd_res = system("dir")

res2 = popen("dir").read()
print res2


