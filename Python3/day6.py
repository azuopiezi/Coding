# ###字典
# dict1 = {}
# dict2 = {'name':'guoguo','age':4,'sex':'girl'}
# ##无序， 哈希算法， 键值对存储数据，python 中唯一的映射类型
#
#
# ###一切皆对象
#
# # a = 10
# # print(id(a))
#
#
# ###不可变类型： 整型，字典，元祖
# ###可变类型：
# ##字典创建，1,用工厂函数创建;2,
# #工厂函数
# #a = [1,2,3]
# a= list((1,))
# b = list([4])
# print(a)
# print(b)
# ##字典的操作：
# dict4 = dict((('name','guoguo'),))
# print(dict4)
# dict4['hobby']='boy'
# dict4.setdefault('age',12)
#
# print(dict4)
#
# ##查找
# print(dict4['name'])
# print(dict4.keys())
# print(list(dict4.keys()))
# print(list(dict4.items()))
# print(list(dict4.values()))
# ##删除
# #排序
# print(sorted(dict4))
# ##遍历
# print('遍历')
#
# dict6 = {'name':'guoguo','age':4,'sex':'girl'}
# for i in dict6:
#     print(i,dict6[i])
#
# print('items')
# for i,v in dict6.items():
#
#     print(i,v)
#
# print(dict6.items())

####字符串############
#String
print('字符串')
print('join 字符串拼接')

a = '123'
b = 'adag'

<<<<<<< HEAD
c = ''.join([a,b])
print(c)
=======
# a = 10
# print(id(a))


###不可变类型： 整型，字典，元祖
###可变类型：
##字典创建，1,用工厂函数创建;2,
#工厂函数
#a = [1,2,3]
a= list((1,))
b = list([4])
# print(a)
# print(b)
##字典的操作：
dict4 = dict((('name','guoguo'),))
# print(dict4)
dict4['hobby']='boy'
dict4.setdefault('age',12)

# print(dict4)

##查找
# print(dict4['name'])
# print(dict4.keys())
# print(list(dict4.keys()))
# print(list(dict4.items()))
# print(list(dict4.values()))

##字典循环遍历
# dic5 = {'name':'alice','age':29}
# print(dic5)
# for i in dic5:
#     print(i,dic5[i])
#
# for i in dic5.items():
#     print(i)
#
# for i,v in dic5.items():
#     print(i,v)


###字符串

#字符串内置方法

a = '1234'
b = 'adbc'
# c = a +b
# print(c)


###拼接字符串join，控制符拼接
c = ''.join([a,b])
print(c)

print(c.endswith(c))  ###以某个字符结尾
print(c.startswith('12')) ###以某个字符开头

st='hello kitty {name} is {age}'
print(st.find('t')) ###查找
print(st.expandtabs(tabsize=20))
print(st.center(50,'$'))  ###居中
print(st.format(name='alice',age=22))  ###格式化输出
print('  Mystr sdftar   '.strip()) ###去掉空格、转行符
print('mystr title'.split())
tsd = 'mystr title'.split()
print(''.join(tsd))

>>>>>>> 21e87497c7e020ad14411a9c8b5876eaa91b92a7
