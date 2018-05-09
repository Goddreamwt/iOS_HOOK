//
//  UIWebView+Hook.m
//  XCWebViewHookDemo
//
//  Created by Cai,Tengyuan on 2017/9/1.
//  Copyright © 2017年 Cai,Tengyuan. All rights reserved.
//

#import "UIWebView+Hook.h"
#import "HookWebViewDelegateMonitor.h"
#import <objc/runtime.h>

@implementation UIWebView (Hook)

- (void)hook_setDelegate:(id<UIWebViewDelegate>)delegate{
    [self hook_setDelegate:delegate];
    Class aClass = [delegate class];
    [HookWebViewDelegateMonitor exchangeUIWebViewDelegateMethod:aClass];
}


+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod([UIWebView class], @selector(setDelegate:));
        Method swizzledMethod = class_getInstanceMethod([UIWebView class], @selector(hook_setDelegate:));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

@end
