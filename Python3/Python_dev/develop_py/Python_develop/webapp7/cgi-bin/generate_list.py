#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python

import glob

import Python_develop.webapp7.yate

import athletemodel

data_files = glob.glob("data/*.txt")
athletes = athletemodel.put_to_store(data_files)

print(Python_develop.webapp7.yate.start_response())
print(Python_develop.webapp7.yate.include_header("Coach Kelly's List of Athletes"))
print(Python_develop.webapp7.yate.start_form("generate_timing_data.py"))
print(Python_develop.webapp7.yate.para("Select an athlete form the list to work with:"))

for each_athlete in athletes:
    print(Python_develop.webapp7.yate.radio_button("Witch_athlete", athletes[each_athlete].name))
print(Python_develop.webapp7.yate.end_form("Select"))
print(Python_develop.webapp7.yate.include_footer({"Home": "/index.html"}))
