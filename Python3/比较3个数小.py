num1 = int(input("num1:"))
num2 = int(input("num2:"))
num3 = int(input("num3:"))

max_num=0
if num1 > num2 :
    max_num = num1
    if max_num > num3:
        print(max_num)
    else:
        max_num=num3
        print(max_num)
else:
    max_num = num2
    if max_num > num3:
        print(max_num)
    else:
        max_num = num3
        print(max_num)



