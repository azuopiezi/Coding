#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python

import re
s = "HELLO WORLD"
print re.findall(r"^hello",s)
print re.findall(r"^hello",s,re.I)
print re.findall("WORLD$",s)
print re.findall(r"WORLD$",s,re.I)
print re.findall(r"\b\w +\b",s)



