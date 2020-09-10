#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
'''import sys
if __name__ == '__main__':
    for item in sys.argv:
        print item'''

import getopt1
import sys
config = {
    "input":"",
    "output":".",
}
#getopt 三个选项,第一个一般为sys.argv[1:],第二个参数为短参数,如果参数后面必须跟值,须加:,第三个参数为长参数,是一个列表


opts,args = getopt1.getopt1(sys.argv[1:], 'hi:o:d',
                            [
                              'input=',
                              'output=',
                              'help'
                          ]
                            )

#参数的解析过程,长参数为--,短参数为-


for option,value in opts:
    if option in ["-h","--help"]:
        print """
        usage:%s --input=[value] --output=[value]
        usage:%s -input value -o value
        """
    elif option in ['--input','-i']:
        config["input"] = value
    elif option in ['--output','-o']:
        config["output"] = value
    elif option == "-d":
        print "usage -d"

print config


