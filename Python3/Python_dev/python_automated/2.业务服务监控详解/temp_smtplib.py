#!/usr/bin/python
# _*_ coding: UTF-8 _*_
'''
Created on Jun 29, 2016

@author: shixingwen
发送电子邮件模块smtplib
'''
import smtplib
import string
HOST = "smtp.163.com" #定义smtp主机
SUBJECT = "Test email from Python" #定义邮件主题
TO = "shixingwe.n@163.com" #定义邮件收件人
FROM = "shixingwe.n@163.com" #定义邮件发件人
text = "Python rules them all!" #邮件内容
BODY = string.join((  #组装sendmail 方法的邮件主题内容，各段一"\r\n" 进行分隔
                      "From: %s" % FROM,
                      "To: %s" % TO,
                      "Subject: %s" % SUBJECT,
                      "",
                      text
                    ),"\r\n")
server = smtplib.SMTP()  #创建一个SMTP（）对象
server.connect(HOST, "25") #通过connect 方法连接smtp 主机
server.starttls() #启动安全传输模式
server.login("shixingwe.n@163.com", "A19860926a") #邮箱账户登录校验
server.sendmail(FROM,[TO], BODY) #邮件发送
server.quit() #断开smtp连接


