//
//  ViewController.m
//  Emoji
//
//  Created by JzChang on 13/1/24.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

/*
 使用 Emoji 繪文字
 需要 #import <QuartzCore/QuartzCore.h>
 
 參考網址:http://furnacedigital.blogspot.tw/2012/07/emoji.html
 */

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    //製作一個繪文字的UILabel
    UILabel *label = [[UILabel alloc] init];
    NSString *unicode = @"\uE408\uE415\uE001\uE002\uE411";
    [label setText:unicode];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setOpaque:NO];
    
    //將取得文字大小後繪至ImageContext
    CGSize textSize = [unicode sizeWithFont:label.font];
    label.frame = CGRectMake(0, 0, textSize.width, textSize.height);
    
    UIGraphicsBeginImageContextWithOptions(label.bounds.size, NO, 0.0);
    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //設定imageView
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.image = img;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.center = self.view.center;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |
                                 UIViewAutoresizingFlexibleLeftMargin   |
                                 UIViewAutoresizingFlexibleRightMargin  |
                                 UIViewAutoresizingFlexibleTopMargin;
    
    [self.view addSubview:imageView];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

@end
