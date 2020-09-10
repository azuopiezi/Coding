#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
'''import cgi
import cgitb
import athletemodel
import yate
cgitb.enable()
athletes = athletemodel.get_from_store()
form_data = cgi.FieldStorage()
athlete_name = form_data['which_athlete'].value
print(yate.start_response())
print(yate.include_header("Coach Kelly's Timing Data"))
print(yate.header("Athlete:" + athlete_name + ",DOB:" + athletes[athlete_name].dob + "."))
print(yate.para("The top times for this athlete are:"))
print(yate.u_list(athletes[athlete_name].top3))
print(yate.include_footer({"Home":"/index.html","Select another athlete":"generate_list.py"}))'''

import cgi

import cgitb
cgitb.enable()

import athletemodel
import yate

athletes = athletemodel.get_from_store()

form_data = cgi.FieldStorage()
athlete_name = form_data['each_athlete'].value #主要是这2行，使用cgi.FieldStorage方法获取表单的数据，并存放在一个字典里，然后从这个字典里访问需要的数据，记得之前的表单里面的数据是选择按钮名称是which_athlete，选择按钮值是athletes[each_athlete].name，所以对应这里也是。

print(yate.start_response())
print(yate.include_header("Coach Kelly's Timing Data"))
print(yate.header("Athlete: " + athlete_name + ", DOB: " +
                      athletes[athlete_name].dob + "."))
print(yate.para("The top times for this athlete are:"))
print(yate.u_list(athletes[athlete_name].top3))
print(yate.include_footer({"Home": "/index.html",
                           "Select another athlete": "generate_list.py"}))

