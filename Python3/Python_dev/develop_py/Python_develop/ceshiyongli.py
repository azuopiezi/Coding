#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python

import unittest
import string
class StringReplaceTestCasel(unittest,TestCase):
    def runTest(self):
        source = "HELLO"
        expect = "HELLO"
        result = string.replace(source,"","")
        self.assertEqual(expect,result)
class StringReplaceTestCase2(unittest,TestCase):
    def runTest(self):
        source = "HELLO"
        expect = "*H*E*L*L*O*"
        result = string.replace(source,"","*")
        self.assertEqual(expect,result)

