//
//  HookWebViewDelegateMonitor.h
//  XCWebViewHookDemo
//
//  Created by Cai,Tengyuan on 2017/9/1.
//  Copyright © 2017年 Cai,Tengyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HookWebViewDelegateMonitor : NSObject <UIWebViewDelegate>

+ (void)exchangeUIWebViewDelegateMethod:(Class)class;

@end
