#!/usr/bin/env python
import os 
from __builtin__ import file
class Delete(object):
    
    def __init__(self,file):
        self.file = file
    def interactive(self):
        input = raw_input("Do you really want to delete %s [N]/Y" %self.file)
        if input.upper():
            print "DELETING: %s" %self.file
            status = os.remove(self.file)
        else:
            print "Skipping %s" %self.file
        return
    def dryrun(self):
        print "Dry Run: %s [NOT DELETED]" %self.file
        return
    def delete(self):
        print "DELETING: %s" %self.file
        try:
            status = os.remove(self.file)
        except Exception,e:
            print e
            return status
if __name__ == "__main__":
    #from find_dupes import findDupes
    dupes = findDupes('/tmp/test')
    
for dupe in dupes:
    delete = Delete(dupe)
    
    
        
        
        
        
        
        
        
        
        
        
        
        
    