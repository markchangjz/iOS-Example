//
//  ViewController.m
//  ADBannerView
//
//  Created by JzChang on 12/12/13.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

/*
 ADBannerView 的基本使用方法
 http://furnacedigital.blogspot.tw/2011/09/adbannerview.html
 */

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initializeBanner];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//自定義的函式 Banner初始化（以畫面直立）
- (void)initializeBanner
{
    //以畫面直立的方式設定Banner於畫面底部
    NSLog(@"%f", self.view.bounds.size.width);
    bannerView = [[ADBannerView alloc]initWithFrame:CGRectMake(0.0, 410, self.view.frame.size.width, 50.0)];
    
    //此Banner所能支援的類型
    bannerView.requiredContentSizeIdentifiers = [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil];
    
    //目前的Banner 類型
    bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    
    //設定代理
    bannerView.delegate = self;
    
    //無法按下觸發廣告
    bannerView.userInteractionEnabled = NO;
    
    //設定偏位移量
    bannerView.frame = CGRectOffset(bannerView.frame, 0, 50);
    
    [self.view addSubview:bannerView];
}

- (void)bannerViewAnimation
{
    //動畫設定
    [UIView beginAnimations:@"BannerViewAnimation" context:NULL];
    
    //以userInteractionEnabled狀態排判斷bannerView是否在畫面內
    if (bannerView.userInteractionEnabled) {
        bannerView.frame = CGRectOffset(bannerView.frame, 0, 50);
    }
    else {
        bannerView.frame = CGRectOffset(bannerView.frame, 0, -50);
    }
    
    //開始動畫
    [UIView commitAnimations];
    
    //將userInteractionEnabled做反向設定
    bannerView.userInteractionEnabled = !bannerView.userInteractionEnabled;
}

- (IBAction)onButtonPress:(id)sender
{
    [self bannerViewAnimation];
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [self bannerViewAnimation];
}

//畫面轉動時呼叫的內建函式
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{    
    //還原bannerView預設值
    bannerView.userInteractionEnabled = NO;
    bannerView.frame = CGRectOffset(bannerView.frame, 0,0);
    
    //判斷畫面是否傾置
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
        bannerView.frame = CGRectMake(0.0, 270.0, self.view.frame.size.width, 50.0);
    }
    else {
        bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
        bannerView.frame = CGRectMake(0.0, 410.0, self.view.frame.size.width, 50.0);
    }
    
    //重新設定偏移量
    bannerView.frame = CGRectOffset(bannerView.frame, 0, 50);
}

//ADBannerView發生錯誤時會觸發
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
}

//按下廣告時會觸發的函式
-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{    
    //這裡可以放置暫停你應用程式的程式碼
    return YES;
}

//重廣告中按下返回應用程式按鈕時所觸發的函式
- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    //這裡可以放置重啟你應用程式的程式碼
}

@end
