//
//  ViewController.m
//  Capture
//
//  Created by JzChang on 13/1/24.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

/*
 螢幕截圖
 參考網址:http://furnacedigital.blogspot.tw/2011/05/blog-post_22.html
 */

#import <QuartzCore/QuartzCore.h> 
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

//自行定義的函式用來取得UIView中的UIImage
- (UIImage *)captureImageFromView:(UIView *)theView
{
    //theView截取區域    
    //設定邊界大小和影像透明度與比例
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, theView.opaque, 0.0);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    //取得影像
    UIImage *captureImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return captureImage;
}

- (IBAction)clickCapture:(UIBarButtonItem *)sender
{
    self.imageView.image = [self captureImageFromView:self.view];
}

- (IBAction)clickClean:(UIBarButtonItem *)sender
{
    [self.imageView setImage:nil];
}

@end
