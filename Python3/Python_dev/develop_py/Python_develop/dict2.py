#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python

def sanitize(time_string):
    if '-' in time_string:
        splitter = '-'
    elif ':' in time_string:
        splitter = ':'
    else:
        return(time_string)
    (mins,secs) = time_string.split(splitter)
    return (mins + '.' + secs)
def get_coath_data(filename):
    try:
        with open(filename) as f:
            data = f.readline()
            temp1 = data.strip().split(',')
            return ({'Name':temp1.pop(0),
                      'DOB':temp1.pop(0),
                     'Times':str(sorted(set([sanitize(t) for t in temp1]))[0:3])})
    except IOError as ioerr:
        print('File error:' + str(ioerr))
        return (None)
sarah = get_coath_data('sarah2.txt')
print(sarah['Name']+ "'s fastest times are:" + sarah['Times'])