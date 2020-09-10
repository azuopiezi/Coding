#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
def print_lol(the_list):
    for each_item in the_list:
        if isinstance(each_item,list):
            print_lol(each_item)
        else:
            print(each_item)