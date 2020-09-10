#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python


movies = ["the holy grail",1975,"terry jones&thrry gillian",91,["graham chapman",["michael palin","john cheese","terry gillian","eric idle","terryjones"]]]
print(movies)

for each_item in movies:
    if isinstance(each_item,list):
        for nested_item in each_item:
            if isinstance(nested_item,list):
                for sested_item in nested_item:
                    print(sested_item)
            else:
                print (nested_item)
    else:
        print(each_item)

def print_lol(the_list):
    for each_item in the_list:
        if isinstance(each_item,list):
            print_lol(each_item)
        else:
            print(each_item)
print_lol(movies)


