#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
if __name__ == "__main__":
    print ("hello,world")
age = 30
name = "bill"
print '% s is % d year old' %(name,age)
class Student:
    __name = ""
def __init__(self,name):
    self.__name = name
def getName(self):
    return self.__name
if __name__ == "__main__":
    student = Student("borphi")
print student.getName()
