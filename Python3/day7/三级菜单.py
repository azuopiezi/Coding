#!/bin/python3
#三级菜单，省、市，区；
#依次可以计入所有层，在每一次又可以返回上一层
##可以在任意层退回上一层或者退出程序

menu = {
    '北京': {
        '朝阳':{
            '望京': {},
            '国贸': {},
            '双井': {},
        },
        '顺义': {
            '南法信': {},
            '南彩镇': {},
            '石门': {},
        },
        '海淀': {
            '中关村': {},
            '十里河': {},
            '蒲黄榆': {},
        },
    },
    '河北': {
        '石家庄': {},
        '廊坊': {
            '固安县': {
                '固安区':{},
                '牛驼镇': {},
                '安次区': {},
            },
        '沧州': {},
        },
    },
    '山东': {
        '菏泽': {
            '单县': {},
            '牡丹区': {},
            '曹县': {},

        },
        '青岛': {},
        '济南': {},
    },
}
# print(menu)

###设置标志位
back_flag = False
exit_flag = False

while not back_flag and not exit_flag:
    for i in menu:
        print(i)
    choice = input("1>>:").strip()
    if choice == 'b':
        back_flag = True
    if choice == 'q':
        exit_flag = True
    if choice in menu:
        while not back_flag and not exit_flag:
            for key2 in menu[choice]:
                print(key2)
            choice2 = input("2>>:").strip()
            if choice2 == 'b':
                back_flag = True
            if choice2 == 'q':
                exit_flag = True
            if choice2 in menu[choice]:
                while not back_flag and not exit_flag:
                    for key3 in menu[choice][choice2]:
                        print(key3)
                    choice3 = input("3>>:").strip()
                    if choice3 == 'b':
                        back_flag = True
                    if choice3 == 'q':
                        exit_flag = True
                else:
                    back_flag = False
        else:
            back_flag = False