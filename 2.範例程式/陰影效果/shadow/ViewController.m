//
//  ViewController.m
//  shadow
//
//  Created by JzChang on 13/1/24.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

/*
 陰影效果
 參考網址:http://furnacedigital.blogspot.tw/2011/03/uiview.html
 */

#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize shadowButton, shadowLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];

    //1.UIButton
    //陰影的實體路徑設定
    CGMutablePathRef shadowPath = CGPathCreateMutable();
    CGPathMoveToPoint(shadowPath, NULL, 0.0, 0.0);          // 起點
    CGPathAddLineToPoint(shadowPath, NULL, 0.0, 120.0);     // 路徑1
    CGPathAddLineToPoint(shadowPath, NULL, 120.0, 120.0);   // 路徑2
    CGPathAddLineToPoint(shadowPath, NULL, 180.0, 0.0);     // 路徑2
    CGPathAddLineToPoint(shadowPath, NULL, 0.0, 0.0);       // 回到起點
    
    /*
     
     按鈕左上角為(0, 0)
     
     ----------> X (+)
     |
     |
     |
     |
     ˇ
     Y (+)
     
     */
    
    // 右下角陰影
//    CGPathMoveToPoint(shadowPath, NULL, 120.0, 0.0);
//    CGPathAddLineToPoint(shadowPath, NULL, 20.0, 0.0);
//    CGPathAddLineToPoint(shadowPath, NULL, 0.0, 120.0);
//    CGPathAddLineToPoint(shadowPath, NULL, 120.0, 120.0);
//    CGPathAddLineToPoint(shadowPath, NULL, 120.0, 0.0);
    
    //陰影的位移量
    [shadowButton.layer setShadowOffset:CGSizeMake(15.0, 15.0)];
    
    //陰影的散射半徑（緊實程度）
    [shadowButton.layer setShadowRadius:10.0];
    
    //陰影的透明度1為不透明
    [shadowButton.layer setShadowOpacity:0.8];
    
    //陰影實體路徑
    [shadowButton.layer setShadowPath:shadowPath];
    
    //陰影顏色
    [shadowButton.layer setShadowColor:[UIColor blackColor].CGColor];
    
    
    //2.UILabel
    [shadowLabel.layer setShadowOffset:CGSizeMake(3.0, 3.0)];
    [shadowLabel.layer setShadowRadius:2.0];
    [shadowLabel.layer setShadowOpacity:0.8];
    [shadowLabel.layer setShadowColor:[UIColor purpleColor].CGColor];
}

@end
