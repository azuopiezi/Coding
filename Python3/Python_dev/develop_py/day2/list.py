menu = {
    'Beijing':{
        "ChaoYang":{
            "CBD":['CICC','CCTV'],
            "JinRongJie":[],
            "WangJing":["Momo","ChuiZi"]
        },
        "HaiDian":["Baidu","YouKu"]
    },
    'ShangHai':{
        "PuDong":['Ctrip',"1 shop"],
        "PuXi":["China Bank","America Bank"]
    }

}
exit_flag = False
while True:
    for index,key in enumerate( menu.keys()):
        print (index,key)
    choice_1 = input("please choose menu to enter:").strip()
    if choice_1.isdigit():
        choice_1 = int(choice_1)
        key_1 = menu.keys()[choice_1]
        while not exit_flag:
              for index,key in enumerate(menu[key_1]):
                print ('-->',index,key)
              choice_2 = input("please choose menu to enter:").strip()
              if choice_2.isdigit():
                  choice_2 = int(choice_2)
                  key_2 = menu[key_1].keys()[choice_2]


                  for index,key in enumerate(menu[key_1][key_2]):
                     print ('--->--->',index,key)


                     choice_3 = input("please choose menu to enter:").strip()
                  if choice_3.isdigit():
                      print ("this is the lase level")
                  elif choice_3 =='quit':
                      exit_flag =True


                  elif choice_3 == 'back':
                    break
        else:
          print ("========going to")
        print ('--------')