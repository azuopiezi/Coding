#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python


"""
比如我们用户拥有一个这样的数据结构，每一个对象是拥有三个元素的tuple。
使用namedtuple方法就可以方便的通过tuple来生成可读性更高也更好用的数据结构。
"""

from collections import namedtuple
websites = [
    ('Sohu','http://www.baidu.com.com/',u'张朝阳'),
    ('Sina','http://www.sina.com.cn/',u'王志东'),
    ('163','http://www.163.com',u'丁磊')

]
Website = namedtuple('Website',['name','url','founder'])
for website in websites:
    website = Website._make(website)
    print website
    print website[0],website.url



