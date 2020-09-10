#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
class AthleteList(list):

    def __init__(self, a_name, a_dob=None, a_times=[]):
        list.__init__([])
        self.name = a_name
        self.dob = a_dob
        self.extend(a_times)

    @staticmethod
    def sanitize(the_time):
        if '-' in the_time:
            splitter = '-'
        elif ':' in the_time:
            splitter = ':'
        else:
            return the_time
        (mins, secs) = the_time.split(splitter)
        return mins + '.' + secs

    # @property
    def top3(self):
        return sorted(set([self.sanitize(t) for t in self]))[0:3]