#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python

class Fruit:
    def __init__(self,color = None):
        self.color = color
class Apple(Fruit):
    def __init__(self,color = "red"):
        Fruit.__init__(self,color)
class Banana(Fruit):
    def __init__(self,color = "yellow"):
        Fruit.__init__(self,color)
class FruitShop:
    def sellFruit(self,fruit):
        if isinstance(fruit,Apple):
            print "sell apple"
        if isinstance(fruit,Banana):
            print "sell banana"
        if isinstance(fruit,Fruit):
            print "sell fruit"


if __name__ == "__main__":
    shop = FruitShop()
    apple = Apple("red")
    banana = Banana("yellow")
    shop.sellFruit(apple)
    shop.sellFruit(banana)

