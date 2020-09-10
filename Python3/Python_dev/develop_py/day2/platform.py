#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
import platform
profile = [
    platform.architecture(),
    platform.dist(),
    platform.libc_ver(),
    platform.system(),
    platform.uname()
    platform.version(),
]
for item in profile:
    print item
