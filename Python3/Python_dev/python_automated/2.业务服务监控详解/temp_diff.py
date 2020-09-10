#!/usr/bin/python
# _*_ coding: UTF-8 _*_
'''
Created on Jun 28, 2016

@author: shixingwen
'''
from logging import FileHandler
from cgitb import text
'''import difflib
test1 = """text1:
this module provides classes and functions for comparing sequences.
includeing HTML and context adn unified diffs.
difflib document v7.4
add string

"""
test1_lines = test1.splitlines()
test2 = """test2:
this module provides classes and functions for comparing sequences.
includeing HTML and context adn unified diffs.
difflib document v7.5


"""
test2_lines = test2.splitlines()
d = difflib.Differ()
diff = d.compare(test1_lines, test2_lines)
print '\n'.join(list(diff))

d = difflib.HtmlDiff()
print d.make_file(test1_lines,test2_lines)
'''
import difflib
import sys
try:
    textfile1 = sys.argv[1] #第一个配置文件路径参数
    textfile2 = sys.argv[2] #第二个配置文件路径参数
except Exception,e:
    print "Error:" +str(e)
    print "Usage:simple3.py filename1 filename2"
    sys.exit()

def readfile(filename): #文件读取分隔函数
    try:
        fileHandle = open(filename,'rb')
        text = fileHandle.read().splitlines()
        fileHandle.close()
        return text
    except IOError as error:
        print('Read file Error:' + str(error)) #读取后以行进行分隔
        sys.exit()
if textfile1== "" or textfile2=="":
    print "Usage:simple3.py filename1 filename2"
    sys.exit()
text1_lines = readfile(textfile1) #调用readfile函数，获取分隔后的字符串
text2_lines = readfile(textfile2)

d = difflib.HtmlDiff() #创建HtmlDiff（）类对象
print d.make_file(text1_lines,text2_lines) #通过make_file方法输出HTML格式的对比结果


        
    
    
    
    
    
    
    
    
    
    



