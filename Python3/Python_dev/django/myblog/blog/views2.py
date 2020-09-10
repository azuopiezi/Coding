#coding:utf-8
import markdown 
from django.shortcuts import render, get_object_or_404
from .models import Post,Category
from comments.forms import CommentForm


# Create your views here.

def index(request):
    '''
    all 方法返回的是一个 QuerySet（可以理解成一个类似于列表的数据结构），
    由于通常来说博客文章列表是按文章发表时间倒序排列的，即最新的文章排在最前面，
    所以我们紧接着调用了 order_by 方法对这个返回的 queryset 进行排序。
    排序依据的字段是 created_time，即文章的创建时间。- 号表示逆序，如果不加 - 则是正序
    '''
    post_list = Post.objects.all().order_by('-created_time')
    #这里我们不再是直接把字符串传给 HttpResponse 了，而是调用 Django 提供的 render 函数。这个函数根据我们传入的参数来构造 HttpResponse。
    #我们首先把 HTTP 请求传了进去，然后 render 根据第二个参数的值 blog/index.html 
    #找到这个模板文件并读取模板中的内容。之后 render 根据我们传入的 context 参数的值把模板中的变量替换为我们传递的变量的值，
    #{{ title }} 被替换成了 context 字典中 title 对应的值，同理 {{ welcome }} 也被替换成相应的值
    return render(request,'blog/index.html',context={'post_list': post_list})
    


def detail(request, pk):  
    post = get_object_or_404(Post, pk=pk)
    
    
    
    #阅读量 +1
    post.increase_views()
    #记得在顶部引入 markdown 模块
    
    post.body = markdown.markdown(post.body,
                                  extensions=[
                                     'markdown.extensions.extra',
                                     'markdown.extensions.codehilite',
                                     'markdown.extensions.toc',
                                     ])
    form = CommentForm()
    comment_list = post.comment_set.all()
    context = {'post':post,
               'form':form,
               'comment_list':comment_list
               
               }
    return render(request, 'blog/detail.html', context=context)


def archives(request,year,month):
    post_list = Post.objects.filter(created_time__year=year,
                                    created_time__month=month
                                    ).order_by('-created_time')
    return render(request,'blog/index.html',context={'post_list':post_list})

def category(request,pk):
    cate = get_object_or_404(Category,pk=pk)
    post_list = Post.objects.filter(category=cate).order_by('-created_time')
    return render(request,'blog/index.html',context={'post_list':post_list})
    
