#coding:utf-8
from django.conf.urls import url


from . import views
#from develop_py.django.myblog.myblog.urls import urlpatterns
##url(r'post/(?P<pk>[0-9]+)/$',views.detail, name = 'detail')

 #app_name='blog' 告诉 Django 这个 urls.py 模块是属于 blog 应用的，
 #这种技术叫做视图函数命名空间。我们看到 blog\urls.py 目前有两个视图函数，
 #并且通过 name 属性给这些视图函数取了个别名，分别是 index、detail
app_name = 'blog'


urlpatterns = [
    #url 函数有参数（r'^$',第一个参数是网址，第二个参数是处理函数，还有个参数name，这个值作为处理参数的别名
    # 那么当用户输入网址 http://127.0.0.1:8000 后，Django 首先会把协议 http、域名 127.0.0.1 和端口号 8000 去掉，
    #此时只剩下一个空字符串，而 r'^$' 的模式正是匹配一个空字符串（这个正则表达式的意思是以空字符串开头且以空字符串结尾），
    #于是二者匹配，Django 便会调用其对应的 views.index 函数          
    url(r'^$', views.IndexView.as_view(), name='index'),
    #当用户访问 <网站域名>/post/1/ 时，显示的是第一篇文章的内容，而当用户访问 <网站域名>/post/2/ 时，
    #显示的是第二篇文章的内容，这里数字代表了第几篇文章，也就是数据库中 Post 记录的 id 值
    
    #此外这里 (?P<pk>[0-9]+) 表示命名捕获组，其作用是从用户访问的 URL 
    #里把括号内匹配的字符串捕获并作为关键字参数传给其对应的视图函数 detail
    #url(r'^post/(?P<pk>[0-9]+)/$', views.detail, name='detail'),
     url(r'^post/(?P<pk>[0-9]+)/$', views.PostDetailView.as_view(), name='detail'),
    #url(r'^archives/(?P<year>[0-9]{4})/(?P<month>[0-9]{1,2})/$', views.archives, name='archives'),
    url(r'^archives/(?P<year>[0-9]{4})/(?P<month>[0-9]{1,2})/$', views.ArchivesView.as_view(),name='archives'),
    
    #url(r'^category/(?P<pk>[0-9]+)/$',views.category,name='category'),
    url(r'^category/(?P<pk>[0-9]+)/$',views.CategoryView.as_view(),name='category'),
    url(r'^tag/(?P<pk>[0-9]+)/$', views.TagView.as_view(), name='tag'),
    #url(r'^search/$', views.search, name='search'),
]