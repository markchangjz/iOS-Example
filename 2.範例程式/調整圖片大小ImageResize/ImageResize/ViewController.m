//
//  ViewController.m
//  ImageResize
//
//  Created by JzChang on 13/1/24.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

/*
 調整 Image 大小
 
 參考網址:
 http://furnacedigital.blogspot.tw/2011/03/calayer.html
 http://stackoverflow.com/questions/3454356/uiimage-from-calayer-iphone-sdk
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
    
    //宣告image物件
    UIImage *aImage = [UIImage imageNamed:@"pic.jpg"];
    
    //使用"layer" class method建立CALayer物件
    CALayer *layer1 = [CALayer layer];
    
    //設定CALayer的frame大小
    layer1.frame = CGRectMake(110, 20, 100, 66);
    
    //設定CALayer的內容為image物件
    layer1.contents = (id)aImage.CGImage;
    
    //將CALayer置入view
    [self.view.layer addSublayer:layer1];
    
    //以下用同樣方式設定大小不同的CALayer
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(85, 106, 150, 100);
    layer2.contents = (id)aImage.CGImage;
    [self.view.layer addSublayer:layer2];
    
    CALayer *layer3 = [CALayer layer];
    layer3.frame = CGRectMake(0, 226, 320, 213);
    layer3.contents = (id)aImage.CGImage;
    [self.view.layer addSublayer:layer3];
    
    //將 CALayer 轉成 UIImage 再放到 View
    UIImageView *myView = [[UIImageView alloc] initWithImage:[self imageFromLayer:layer2]];
    myView.center = CGPointMake(80, 100);
    [self.view addSubview:myView];
}

// 將 CALayer 轉成 UIImage
- (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

// 將 UIImage 調整成指定的 H 和 W
- (UIImage *)imageFromImage:(UIImage *)oriImage resizeToHeight:(NSUInteger)H andWidth:(NSUInteger)W
{    
    CALayer *layer = [CALayer layer];       //使用"layer" class method建立CALayer物件
    layer.frame = CGRectMake(0, 0, H, W);   //設定CALayer的frame大小    
    layer.contents = (id)oriImage.CGImage;  //設定CALayer的內容為image物件
    
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end
