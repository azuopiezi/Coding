#!/usr/bin/env python
import platform
from Finder.Finder_items import item
profile = [
           platform.architecture(),
           platform.dist(),
           platform.libc_ver(),
           platform.machine(),
           platform.mac_ver(),
           platform.node(),
           platform.platform(),
           platform.processor(),
           platform.python_build(),
           platform.python_version(),
           
        
           ]
for item in profile:
    print item