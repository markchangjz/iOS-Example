//
//  ViewController.m
//  WebViewTEST
//
//  Created by EE Lab on 12/7/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.webView = [[UIWebView alloc] init];

    // 讓網頁符合螢幕的大小
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        // | 方向
        self.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    else {
        // - 方向
        self.webView.frame = CGRectMake(0, 0, self.view.frame.size.height+20, self.view.frame.size.width);
    }
    
    // 設定連結網頁
    NSURL *url =[[NSURL alloc] initWithString:@"https://www.google.com.tw/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];    
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGRect workSpaceRect = [[UIScreen mainScreen] applicationFrame];
    CGFloat H = workSpaceRect.size.height;
    CGFloat W = workSpaceRect.size.width;
    CGFloat currentH, currentW; // 取得目前螢幕轉向的 高度＆寬度
    
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        currentH = H;
        currentW = W;
    }
    else {
        currentH = W;
        currentW = H;
    }
    
    self.webView.frame = CGRectMake(0, 0, currentW, currentH);    
}

- (NSUInteger)supportedInterfaceOrientations
{
    BOOL iPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
    
    if (iPad) {
        // iPad
        return UIInterfaceOrientationMaskAll;
    }
    else {
        // iPhone
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
}

@end
