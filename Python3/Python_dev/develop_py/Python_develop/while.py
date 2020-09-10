#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
numbers = raw_input("输入几个数字，用逗号分隔：").split(",")
print numbers
x = 0
while x < len(numbers):
    print numbers[x]
    x += 1