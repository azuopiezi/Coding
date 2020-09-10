#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python


def sanitize(time_string):
    if '-' in time_string:
        splitter = '-'
    elif ':' in time_string:
        splitter = ":"
    else:
        return (time_string)
    (mins,secs) = time_string.split(splitter)
    return (mins + '.' + secs)
def get_coach_data(filename):
    try:
        with open(filename) as f:
            data = f.readline()
        return (data.strip().split(','))
    except IOError as ioerror:
        print('File error:' + str(ioerror))
        return (None)
sarah = get_coach_data('sarah2.txt')
'''(sarah_name , sarah_dob) = sarah.pop(0),sarah.pop(0)
print(sarah_name + ' ' +sarah_dob +"'s fastest times are:" + str(sorted(set([sanitize(t) for t in sarah]))))'''

sarah_data = {}
sarah_data['Name'] = sarah.pop(0)
sarah_data['DOB'] = sarah.pop(0)
sarah_data['Times'] = sarah
print(sarah_data['Name'] + "'s fastest times are:" + str(sorted(set([sanitize(t) for t in sarah]))[0:3]))




