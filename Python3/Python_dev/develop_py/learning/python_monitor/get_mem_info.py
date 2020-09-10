#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python

from __future__ import print_function
from collections import OrderedDict
def meminfo():
    ''' Return  the information in /proc/meminfo
    as a dictionary &#039;&#039;&#039;
    '''
    meminfo = OrderedDict()

    with open('/proc/meminfo') as f:
        for line in f:
            meminfo[line.split(':')[0]] = line.split(':')[1].strip()
    return meminfo
if __name__ =='__main__':
    #print(memeinfo())

    meminfo = meminfo()
    print ('Total memory:{0}'.format(meminfo['MemTotal']))
    print('Free memory:{0}'.format(meminfo['MemFree']))
    print('Cached:{0}'.format(meminfo['Cached']))



