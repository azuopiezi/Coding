#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
from fabric.api import locale

def lsfab():
    local('cd ~/tmp/fab')
    local('ls')