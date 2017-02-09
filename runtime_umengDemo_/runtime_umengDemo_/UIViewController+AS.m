//
//  UIViewController+AS.m
//  Runtime_umengDome
//
//  Created by niuting on 2017/2/9.
//  Copyright © 2017年 niuNaruto. All rights reserved.
//

#import "UIViewController+AS.h"
#import <objc/runtime.h>
#import <UMMobClick/MobClick.h>

@interface UIViewController ()

@property (copy, nonatomic) NSString *umengLog;
@end


@implementation UIViewController (AS)
+ (void)load{
        
        Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
        Method new_viewWillAppear = class_getInstanceMethod(self, @selector(new_viewWillAppear:));
        method_exchangeImplementations(viewWillAppear, new_viewWillAppear);
        
        Method viewWillDisappear = class_getInstanceMethod(self, @selector(viewWillDisappear:));
        Method new_viewWillDisappear = class_getInstanceMethod(self, @selector(new_viewWillDisappear:));
        method_exchangeImplementations(viewWillDisappear, new_viewWillDisappear);
    
    
}

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

- (void)setUmengLogAs:(NSString *)umengLogAs{
    
    objc_setAssociatedObject(self, @selector(umengLogAs), umengLogAs, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)umengLogAs
{
    // 根据关联的key，获取关联的值。
    return objc_getAssociatedObject(self,  _cmd) ;
}

@end
