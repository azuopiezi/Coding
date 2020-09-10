#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python

def sanitize(time_string):
    if '-' in time_string:
        splitter = '-'
    elif ':' in time_string:
        splitter = ':'
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
with open('james.txt') as jaf:
    data = jaf.readline()
james = data.strip().split(',')
with open('julie.txt') as jul:
    data = jul.readline()
julie = data.strip().split(',')
with open('mikey.txt') as mik:
    data = mik.readline()
mikey = data.strip().split(',')
with open('sarah.txt') as sar:
    data = sar.readline()
sarah = data.strip().split(',')
print(sorted(james))
print(sorted(julie))
print(sorted(mikey))
print(sorted(sarah))
print '\n'
clean_james = []
clean_julie = []
clean_mikey = []
clean_sarah = []

for each_t in james:
    clean_james.append(sanitize(each_t))
for each_t in julie:
    clean_julie.append(sanitize(each_t))
for each_t in mikey:
    clean_mikey.append(sanitize(each_t))
for each_t in sarah:
    clean_sarah.append(sanitize(each_t))
print(sorted(clean_james))
print(sorted(clean_julie))
print(sorted(clean_mikey))
print(sorted(clean_sarah))


print "shixingwen"
print(sorted(set([sanitize(t) for t in james]))[0:3])
print(sorted(set([sanitize(t) for t in julie]))[0:3])
print(sorted(set([sanitize(t) for t in mikey]))[0:3])
print(sorted(set([sanitize(t) for t in sarah]))[0:3])