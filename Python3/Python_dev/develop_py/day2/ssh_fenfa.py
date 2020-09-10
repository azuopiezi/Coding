#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
import subprocess
'''A ssh based command dispatch system'''
machines = ["10.10.0.102",
            "10.10.0.110"]
cmd = "uname"
for machine in machines:
    subprocess.call("ssh root@%s %s" %(machine,cmd),shell=True)
