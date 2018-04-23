//
//  ViewController.m
//  003-HOOK
//
//  Created by mac on 2018/4/20.
//  Copyright © 2018年 mac. All rights reserved.

#import "ViewController.h"
//#import "NSURL+HOOK.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL * url =[NSURL URLWithString:@"http://www.baidu.com/中文"];
    NSURLRequest * request =[NSURLRequest requestWithURL:url];
    NSLog(@"%@",request);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
