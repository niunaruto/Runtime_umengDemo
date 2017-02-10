# Runtime_umengDemo
Using the runtime to realize the function of accessing the app page of.利用runtime实现友盟app页面访问路径功能 

### 简书博客地址：http://www.jianshu.com/p/90c1d676d27c

>上个版本产品说运营有这样的需求，苦逼的程序员敲代码了，然后赶紧打开友盟看到如下文档：[图片看不到点我](http://upload-images.jianshu.io/upload_images/609618-c76e6f85902c7f6a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



![屏呵呵](https://github.com/NiuNaruto/Runtime_umengDemo/raw/master/609618-c76e6f85902c7f6a.png)

>文档的意思是要在每个VC的viewWillAppear和viewWillDisAppear添加对应的代码来实现统计功能，看着这里想想我们的app，这么多模块和VC，如果每个界面都这样写势必工作量会很大，那有没有简单可行的办法呢？有啊，要不我写这篇文章干嘛




![6767C6CA1343747E7A943E26F088E99E.gif](http://upload-images.jianshu.io/upload_images/609618-32c61923515879d5.gif?imageMogr2/auto-orient/strip)


>实现思路 使用runtime：
1：拦截系统的viewWillAppear和viewWillDisAppear
2：交换为我们自己定义的方法
3：执行对应的统计方法beginLogPageView和endLogPageView
4: 继续执行原来方法

## 不想看文章的直接可以下载代码Demo，觉得不错的请给我star谢谢😀

- 创建UIViewController的分类UIViewController+AS.h
- 在.m里实现load类方法

        + (void)load
        {

        Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
        Method new_viewWillAppear = class_getInstanceMethod(self, @selector(new_viewWillAppear:));
        method_exchangeImplementations(viewWillAppear, new_viewWillAppear);

        Method viewWillDisappear = class_getInstanceMethod(self, @selector(viewWillDisappear:));
        Method new_viewWillDisappear = class_getInstanceMethod(self, @selector(new_viewWillDisappear:));
        method_exchangeImplementations(viewWillDisappear, new_viewWillDisappear);
        }
- 实现替换的方法 （self.title就是每个导航栏上的title，对于没有使用导航栏或者是导航栏title并不能区分是哪个模块的那个页面，（都是商品详情页，但是一个是品牌馆模块，一个是超市模块）[这种情况需要给系统的UIViewController添加自定义属性]()）标记问题1
      
        - (void)new_viewWillAppear:(BOOL)animated{
        if (self.title.length) {

        [MobClick beginLogPageView:self.title];
        NSLog(@"路径开始%@==%@  %s",NSStringFromClass(self.class),self.title,__func__);
        }
        [self new_viewWillAppear:animated];
        }

        - (void)new_viewWillDisappear:(BOOL)animated{
            if (self.title.length) {

                NSLog(@"路径结束%@==%@ == %s",NSStringFromClass(self.class),self.title,__func__);
                [MobClick endLogPageView:self.title];
            }
                [self new_viewWillDisappear:animated];
        }

- 我们的代码规范是在每个VC的loadView方法里去写一些当前vc显示的相关的代码.比如在AViewController里，可以这样：
        - (void)loadView{
             [super loadView];
           self.title = @"我是AVC界面";
        }
#以上就可以少量代码实现行为路径的统计，具体可以看代码，毕竟代码才是程序员沟通的语言😀

>使用runtime给系统类添加属性
接上边的问题1，给ViewController添加自定义属性：

- 在分类UIViewController+AS.h 中声明一个属性为@property (copy, nonatomic) NSString *umengLogAs;
- 重写set get方法

        - (void)setUmengLogAs:(NSString *)umengLogAs{

                objc_setAssociatedObject(self, @selector(umengLogAs), umengLogAs, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }

        - (NSString *)umengLogAs
        {
        // 根据关联的key，获取关联的值。
        return objc_getAssociatedObject(self,  _cmd) ;
        }
打完，收工！

> _cmd 是什么： 在Apple的官方介绍里看到轻描淡写的说了一句：“The _cmd variable is a hidden argument passed to every method that is the current selector”，其实说的就是_cmd在Objective-C的方法中表示当前方法的selector，正如同self表示当前方法调用的对象实例一样。
