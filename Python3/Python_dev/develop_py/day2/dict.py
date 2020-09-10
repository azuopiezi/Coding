#!/usr/bin/python
# -*- coding: UTF-8 -*-
dict = {"a":"apple","b":"banana","g":"grade","o":"orange"}
dict["w"] = "watermelon"
del (dict["a"])
dict["g"] = "grapefruit"
print dict.pop("b")
print dict
dict.clear()
print dict

dict = {"a":"apple","b":"banana","g":"grade","o":"orange"}
for k in dict:
    print "dict[%s] = " %k,dict [k]
print dict.items()
for (k, v) in dict.items():
    print "dict[%s] =" % k, v

print dict.keys()
print dict.values()
print dict.iteritems()

