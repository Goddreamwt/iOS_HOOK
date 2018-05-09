//
//  NSURL+HOOK.m
//  003-HOOK
//
//  Created by mac on 2018/4/23.
//  Copyright © 2018年 mac. All rights reserved.
//  哪里HOOK？load
/**
 利用Runtime运行时改变方法调用的顺序
 */

#import "NSURL+HOOK.h"
#import <objc/runtime.h>

@implementation NSURL (HOOK)

+(void)load{
    //获取两个Method
    Method URLWithStr = class_getClassMethod(self, @selector(URLWithString:));
    Method HKWithStr = class_getClassMethod(self, @selector(HK_URLWithString:));
    //交换方法的IMP
    method_exchangeImplementations(URLWithStr, HKWithStr);
}

//重写URLWithString  ？
//+(instancetype)URLWithString:(NSString *)URLString{
//    NSURL * 
//}

+(instancetype)HK_URLWithString:(NSString *)URLString{
    NSURL * url = [NSURL HK_URLWithString:URLString];
    if(url ==nil){
        NSLog(@"空了");
    }
    return url;
}
@end
