#!/usr/bin/python
# _*_ coding: UTF-8 _*_
'''
Created on Jun 28, 2016

@author: shixingwen
'''
import os,sys

import filecmp
import re
import shutil
from Finder.Finder_items import item
holderlist = []

def compareme(dir1,dir2): #递归获取更新项函数
    dircomp = filecmp.dircmp(dir1,dir2)
    only_in_one = dircomp.left_only #源目录新文件或目录
    diff_in_one = dircomp.diff_files #不匹配文件，源目录文件已发生变化
    dirpath=os.path.abspath(dir1) #定义源目录绝对路径
    #将更新文件名或目录追加到holderlist
    [holderlist.append(os.path.abspath(os.path.join(dir1,x))) for x in only_in_one]
    [holderlist.append(os.path.abspath(os.path.join(dir1,x))) for x in diff_in_one]
    
    if len(dircomp.common_dirs) > 0:
        for item in dircomp.common_dirs:
            compareme(os.path.abspath(os.path.join(dir1,item)),os.path.abspath(os.path.join(dir2,item)))
        return
    
def main():
    if len(sys.argv) > 2:
        dir1 = sys.argv[1]
        dir2 = sys.argv[2]
    else:
        print "Usage:",sys.argv[0],"datadir backupdir"
        sys.exit()


source_files = compareme(dir1,dir2)
dir1 = os.path.abspath(dir1)
if not dir2.endswith('/'): dir2=dir2 +'/'
dir2 = os.path.abspath(dir2)
destination_files = []
createdir_bool = False
for item in source_files:
    destination_files=re.sub(dir1,dir2,item)
    destination_files.append(destination_dir)
    if os.path.isdir(item):
        os.makedirs(destination_files, mode)
        
    

        
    
