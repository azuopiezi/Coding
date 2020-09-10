
# name = ['wuchao','jinxin','sanpang','ligang']
#
# print(name)
# ###查 切片
# print(name[1:3])
# print(name[2:])###位置2之后全部取出来
# print(name[1:4:2])###步长
# ###增
# #append insert
#
# name.append('xuefeng') ###默认末尾
# print(name)
# name.insert(1,'wangming') #位置，值
# print(name)
# ###修改
# name[2]='wanhui'
# print(name)
# ##删
# name.remove('sanpang')
# print(name)
# name.pop(3)
# print(name)
# a=name.count('xuefeng')
# print(a)
# del name[3]
# print(name)
# wei=name.index('wanhui')
# print(wei)

a=[6,7,5,3,1,3,8]
print(a)
a.sort()
print(a)
a.sort(reverse=True)
print(a)