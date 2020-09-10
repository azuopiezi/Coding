#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
class fruit:
    def __init__(self,color):
        self.__color = color
        print self.__color
    def __del__(self):
        self.__color = ""
        print "free....."
    def grow(self):
        print "grow..."
if __name__ == "__main__":
    color = "red"
    fruit = Fruit(color)
    fruit.grow()