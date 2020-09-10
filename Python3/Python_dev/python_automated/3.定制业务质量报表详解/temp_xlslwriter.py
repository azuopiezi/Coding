#!/usr/bin/python
# _*_ coding: UTF-8 _*_
'''
Created on Jun 29, 2016
数据表格之EXCLE 操作模块
@author: shixingwen
'''
import xlsxwriter
from xlsxwriter.worksheet import Worksheet
workbook = xlsxwriter.Workbook('demo1.xlsx') #创建一个Excel文件
worksheet = workbook.add_worksheet() #创建一个工作表对象
worksheet.set_column('A:B',20) #设定第一列A 宽度为20的像素
worksheet.set_row(1, 50)
bold = workbook.add_format({'bold':True}) #定义一个加粗的格式对象

worksheet.write('A1','Hello') #A1单元个写入hello
worksheet.write('A2','World',bold) #A2单元格写入world并引用加粗格式对象bold
worksheet.write('B2',u'中文测试',bold) #B2单元格写入中文并引用加粗格式对象bold

worksheet.write(2,0,36) #用行列表示法写入数字，2，0 等价于A3
worksheet.write(3,0,35)
worksheet.write(4,0,'=SUM(A3:A4)')
#worksheet.insert_image('B5','img/python-logo.png') #插入图片
workbook.close() #关闭excel文件

