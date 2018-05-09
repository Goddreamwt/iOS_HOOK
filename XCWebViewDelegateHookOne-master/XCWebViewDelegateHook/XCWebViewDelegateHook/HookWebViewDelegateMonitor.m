//
//  HookWebViewDelegateMonitor.m
//  XCWebViewHookDemo
//
//  Created by Cai,Tengyuan on 2017/9/1.
//  Copyright © 2017年 Cai,Tengyuan. All rights reserved.
//

#import "HookWebViewDelegateMonitor.h"
#import <objc/runtime.h>
#import <objc/message.h>

static void hook_exchangeMethod(Class originalClass, SEL originalSel, Class replacedClass, SEL replacedSel){
    Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
//    assert(originalMethod);
    
    Method replacedMethod = class_getInstanceMethod(replacedClass, replacedSel);
//    assert(replacedMethod);
    IMP replacedMethodIMP = method_getImplementation(replacedMethod);
    
    BOOL didAddMethod =
    class_addMethod(originalClass,
                    replacedSel,
                    replacedMethodIMP,
                    method_getTypeEncoding(replacedMethod));
    
    if (didAddMethod) {
        NSLog(@"class_addMethod succeed --> (%@)", NSStringFromSelector(replacedSel));
        Method newMethod = class_getInstanceMethod(originalClass, replacedSel);
        method_exchangeImplementations(originalMethod, newMethod);
    }
//    else {
//        NSLog(@"class_addMethod fail --> (%@)", NSStringFromSelector(replacedSel));
//    }
    
    
    
}

@implementation HookWebViewDelegateMonitor

+ (void)exchangeUIWebViewDelegateMethod:(Class)aClass{
    hook_exchangeMethod(aClass, @selector(webViewDidStartLoad:), [self class], @selector(replaced_webViewDidStartLoad:));
    hook_exchangeMethod(aClass, @selector(webViewDidFinishLoad:), [self class], @selector(replaced_webViewDidFinishLoad:));
    hook_exchangeMethod(aClass, @selector(webView:didFailLoadWithError:), [self class], @selector(replaced_webView:didFailLoadWithError:));
    hook_exchangeMethod(aClass, @selector(webView:shouldStartLoadWithRequest:navigationType:), [self class], @selector(replaced_webView:shouldStartLoadWithRequest:navigationType:));
    
}

- (BOOL)replaced_webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"-------replaced_webView-shouldStartLoadWithRequest---------");
    return [self replaced_webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
}

- (void)replaced_webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"-------replaced_webViewDidStartLoad--------");
    [self replaced_webViewDidStartLoad:webView];
}

- (void)replaced_webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"-------replaced_webViewDidFinishLoad--------");
    [self replaced_webViewDidFinishLoad:webView];
}

- (void)replaced_webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"--------replaced_webView-didFailLoadWithError--------");
    [self replaced_webView:webView didFailLoadWithError:error];
}

@end
