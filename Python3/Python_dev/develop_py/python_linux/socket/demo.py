#!/usr/bin/env python
from optparse import OptionParser
usage = "myprog[ -f <filename>][-s <xyz>] arg1[,arg2..]"
optParser = OptionParser(usage)
optParser.add_option("-f","--file",action = "store",type = "string",dest = "fileName")
optParser.add_option("-v","--version",action = "store_true",dest = "verbose",default = 'None',help = "make lots of noise [default]")
fakeArgs = ['-f','file.txt','-v','good luck to you','arg2','arge']

options,args = optParser.parse_args(fakeArgs)

print options.fileName
print options.verbose
print args
print optParser.print_help()
