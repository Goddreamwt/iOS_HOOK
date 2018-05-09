//
//  ViewController.m
//  XCWebViewDelegateHook
//
//  Created by Cai,Tengyuan on 2018/5/8.
//  Copyright © 2018年 Cai,Tengyuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"WebView";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize size = self.view.frame.size;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 170, size.width, size.height - 80)];
    _webView.layer.borderWidth = 1;
    _webView.layer.borderColor = [UIColor blackColor].CGColor;
    _webView.delegate = self;
    [self.view addSubview: _webView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 50, 100, 50);
    [btn setTitle:@"load" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(load) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)load {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.qq.com"]];
    [_webView loadRequest:request];
    
}

#pragma mark - webView delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"shouldStartLoadWithRequest");
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    //    NSLog(@"error -- %@\n\n%@\n%@",error,webView.request.URL.absoluteString,[webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
    NSLog(@"didFailLoadWithError");
}

@end
