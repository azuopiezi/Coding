#_*_coding:utf-8_*_
##read file content
'''f = file("py_home_work.csv")

print f.readline()
for line in f.readlines():
    print line,
f.close()
'''
##write
f = file("test.txt","w")
f.write("this is the first linse\n")
f.write("this is the second lines\n")
f.close()

##append file content
f = file("test.txt","a")
f.write("this a append one linxe")
f.close()

##修改第三行
###read and write:r+w+
f = file("test.txt","r+")



