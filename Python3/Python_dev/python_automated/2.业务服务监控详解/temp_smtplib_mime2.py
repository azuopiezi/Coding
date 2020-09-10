#!/usr/bin/python
# _*_ coding: UTF-8 _*_
'''
Created on Jun 29, 2016

@author: shixingwen
实现HTML格式的数据报表邮件
'''
import smtplib
from email.mime.text import MIMEText #导入MIMEText 类
from email.mime.multipart import MIMEMultipart #导入MINEMultipart 类
from email.mime.image import MIMEImage #导入MIMEImage 类
from test.test_mimetools import msgtext1
HOST = "smtp.163.com" #定义HOST 主机
SUBJECT = u"官网流量数据报表" #定义邮件主题
TO = "shixingwe.n@163.com" #定义邮件收件人
FROM = "shixingwe.n@163.com" #定义邮件发送人

def addimg(src,imgid): #添加图片函数，参数1：图片路径，参数2：图片id
    fp = open(src,'rb') #打开文件
    msgImage = MIMEImage(fp.read())#创建MIMEImage 对象，读取图片内容作为参数
    fp.close() #关闭文件
    msgImage.add_header('Content-ID',imgid) #指定图片文件Content-ID，<img> 标签src用到
    return msgImage #返回msgImage对象
msg = MIMEMultipart('related')
msgtext = MIMEText()
msg.attach(msgtext)
msg.attach(addimg(src, imgid))

     


'''
msg = MIMEText("""  #创建一个MIMEText对象，分别制定HTML内容、类型（文本或html）、字符编码
    <table width="800" border="0" cellspacing="0" cellpadding="4">
        <tr>    
            <td bgcolor="#DEDFAD" height="20" style="font-size:14px"> 
            *官网数据 
                <a href="https://www.fortunemar.com">
                更多>>
                </a>
            </td>
        </tr>
        
        <tr>
            <td bgcolor="#EFEBDE" height="100" style="font-size:13px">
               1)日访问量：<font color=red> 15323<font><br>
               2)状态码信息<br>
               500:105 404:3264 503:214<br>
               3)访客浏览器信息<br>
               4)页面信息<br> 
            
            </td>
        </tr>
    </table>

""","html","utf-8"
               
               )
               
'''


msg['Subject'] = SUBJECT #邮件主题
msg['From'] = FROM
msg['To'] = TO
try:
    server = smtplib.SMTP() #创建一个SMTP（）对象
    server.connect(HOST,"25") #通过connect 方法连接smtp 主机
    server.starttls() #启动安全传输模式
    server.login("shixingwe.n@163.com","A19860926a") #邮箱账号登录检验
    server.sendmail(FROM,TO,msg.as_string()) #邮件发送
    server.quit() #断开smtp连接
except Exception,e:
    print "失败：" +str(e)
