#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
import pickle
from athletelist import AthleteList
def get_coach_data(filename):
    #Not shown here as it has not changed since the last chapter.
    def put_to_store(files_list):
        all_athletes = {}
    for each_file in files_list:
        ath = get_coach_data(each_file)
        all_athletes[ath.name] = ath
    try:
        with open('athletes.pickle','wb') as athf:
            pickle.dump(all_athletes,athf)
    except IOError as ioerr:
        print('File error(put_and_store:' + str(ioerr))
    return (all_athletes)
def get_from_store():
    all_athletes = {}
    try:
        with open('athletes.pickle','rb') as athf:
            all_athletes = pickle.load(athf)
    except IOError as ioerr:
        print('File error(get_from_store):' + str(ioerr))
    return (all_athletes)