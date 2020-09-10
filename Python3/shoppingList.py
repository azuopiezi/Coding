#!/bin/python
###产品列表
productList = [
    ['Iphone6', 5800],
    ['Macbook', 9000],
    ['Coffee', 32],
    ['Pythonbook', 80],
    ['Bicycle', 1500]
]
###创建一个购物列表
shoppingList=[]
###输入工资
salary = input("工资多少:")
if salary.isdigit():
    salary = int(salary)
    while True:
        for index, i in enumerate(productList): ####这里用的枚举方式
            print(index, i)
        userChoice=input("请输入产品序号或者q:")
        if userChoice.isdigit():
            userChoice=int(userChoice)
            if userChoice < len(productList) and userChoice >= 0:
                ### 产品序号范围
                productChoice=productList[userChoice]  ###选择产品
                if productChoice[1] < salary:
                    shoppingList.append(productChoice)
                    salary -= productChoice[1]
                    for s_index,s in enumerate(shoppingList):

                        print("----------选择商品信息----------")
                        print("%s,%s, 余额为：%d" %(s_index,s,salary))
                    print("-----------------END----------------------")
                else:
                    print("余额不足,")
                    for s_index,s in enumerate(shoppingList):

                        print("----------选择商品信息----------")
                        print("%s,%s,\n 余额为：%d" %(s_index,s,salary))
        elif userChoice=="q":
            print("结账")
            print("----------购买的商品信息----------")
            for s_index,i in shoppingList:
                print("%s,%s" % (s_index, i))
            print("余额为：%d" %salary ,"欢迎下次光临")
            break
        else:
            print("输入错误，请输入正确的产品序号")
    else:
        pass
else:
    print("输入错误")