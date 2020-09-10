'''

逻辑运算符，表达式
条件运算符
条件1 and 条件2
条件1 or 条件2

'''
'''
if 5 > 3 and 5 > 4:
    print(True)
else:
    print(False)
'''
'''
while条件:
执行
'''
'''
###print 10
num=0
while num < 10:
    num +=1
    print("num=%d" %num)
    print("num=",num)
'''
###print 0-100 之间的偶数和奇数
'''
num1 = 0
while num1 < 100:
    num1 += 1
    if num1 %2==0:
        print(num1)
    elif num1 %2 ==1:
        print("num1=",num1)
    else:
        print("Error")
 '''

'''
### break and continue 用法
while True:
    num2 = int(input("num2:"))
    if num2 ==10:
        print("Right")
        break
    elif num2 < 10:
        print("太小了")
        continue
    elif num2 > 10:
        print("太大了")
        continue
    else:
        pass

print("end")

'''

####打印n行m列 #号
输入m:5
输入n:4
# # # #
# # # #
# # # #
# # # #
# # # #


m = int(input("输入m:"))
n1 = int(input("输入n:"))
while m > 0:
    n = n1
    while n > 0:
        print("#", end=' ')
        n -= 1
    print()
    m -= 1



'''
while True:
    if n>0:
        print("#",end=' ')
    n -= 1
'''




