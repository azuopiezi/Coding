import os

'''

#作业：输入用户名和密码
#认证成功后显示欢迎信息
#超过3次锁定

'''
for i in range(3):
    i +=1
    username = str(input("username:"))
    password = str(input("password:"))
    if username == "admin" and password == "admin@123":
        print("登录成功")
        exit()
    else:
        print('登录失败，还剩下%d次机会\n' %(3-i))
exit("超过3次，请稍后再试！！！")

'''
##或者用while实现

i=1
while i <= 3:
    i += 1
    username = str(input("username:"))
    password = str(input("password:"))
    if username == "admin" and password == "admin@123":
        print("登录成功")
        exit()
    else:
        print("登录失败%d!\n" %(4-i))
else:
    print("登录失败，请稍后再试")

##"https://www.bilibili.com/video/av13690129?p=31"
'''