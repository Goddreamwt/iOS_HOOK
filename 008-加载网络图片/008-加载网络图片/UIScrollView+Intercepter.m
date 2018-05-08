//
//  UIScrollView+Intercepter.m
//  008-加载网络图片
//
//  Created by mac on 2018/5/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UIScrollView+Intercepter.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "UIScrollViewDelegateHook.h"

@implementation UIScrollView_Intercepter

- (void)hook_setDelegate:(id<UIScrollViewDelegate>)delegate{
    [self hook_setDelegate:delegate];
    // 获得delegate的实际调用类
    Class aClass = [self.delegate class];
    // 传递给UIScrollViewDelegateHook来交互方法
    [UIScrollViewDelegateHook exchangeUIScrollViewDelegateMethod:aClass];
}

#pragma mark - Method Swizzling
// 在load中交换系统的setDelegate 和我们要hook的代理方法
+ (void)load{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        Class class = [super class];
        SEL originalSelector = @selector(setDelegate:);
        SEL swizzledSelector = @selector(hook_setDelegate:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

@end
