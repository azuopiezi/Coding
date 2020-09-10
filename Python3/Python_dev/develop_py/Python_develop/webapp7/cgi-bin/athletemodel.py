#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
import pickle

from athletelist import AthleteList


def get_coast_data(filename):
    try:
        with open(filename) as f:
            data = f.readline()
        templ = data.strip().split(',')
        return(AthleteList(templ.pop(0),templ.pop(),templ)) #这个AthleteList已经写好,并放在同一目录
    except IOError as ioerr:
        print('File error(get_coast_data):' + str(ioerr))
        return(None)
def put_to_store(files_list):
    all_athletes = {}
    for each_file in files_list:
        ath = get_coast_data(each_file)
        all_athletes[ath.name] = ath      #建立一个字典ath_athletes,键是ath.name，即实例属性的name属性，
        # 值是实例本身，这样的话我可以通过名字（选手）找到实例（文件）了
    try:
        with open('athletes.pickle','wb') as athf:
            pickle.dump(all_athletes,athf) ##存储这个字点到pickle中去
    except IOError as ioerr:
        print ('File error(put_and_store):' +str(ioerr))
    return (all_athletes)   ##返回这个字典
def get_from_store():
    all_athletes = {}
    try:
        with open('athletes.pickle','rb') as athf:
            all_athletes = pickle.load(athf)  #读入这个pickle
    except IOError as ioerr:
        print('File error(get_from_store):' + str(ioerr))
    return(all_athletes)  #返回这个字典
###测试代码，测试上面的效果，在整个程序里面可以忽略。

the_files = ['data/sarah2.txt','data/james2.txt','data/mikey2.txt','data/julie2.txt']
data = put_to_store(the_files)
print data

print '-----------------------------------------'
for each in data:
    print(data[each].name + ' ' + data[each].dob)
print '----------------------------------------------'
for each in data:
    print(each)
print '-----------------------------------------'
for each in data:
    print(data[each])




