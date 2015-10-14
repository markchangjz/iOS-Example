//
//  ViewController.m
//  image
//
//  Created by JzChang on 12/12/13.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

UIImageView *imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"htc.png"]];
    
    //取得工作區域的位置和大小
    CGRect workSpaceRect = [[UIScreen mainScreen] applicationFrame];
    
    //取得圖片設置的左上角坐標
    CGPoint imagePosition = CGPointMake(CGRectGetWidth(workSpaceRect) - CGRectGetWidth(imageView.frame), CGRectGetHeight(workSpaceRect) - CGRectGetHeight(imageView.frame));
    
    //設定圖片在畫面右下角
    [imageView setFrame:CGRectMake(imagePosition.x, imagePosition.y, CGRectGetWidth(imageView.frame), CGRectGetHeight(imageView.frame))];
    
    [self.view addSubview:imageView];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGRect workSpaceRect = [[UIScreen mainScreen] applicationFrame];
    CGFloat H = workSpaceRect.size.height;
    CGFloat W = workSpaceRect.size.width;
    CGFloat currentH, currentW; // 取得目前螢幕轉向的 高度＆寬度
    
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
//        NSLog(@"|");
        currentH = H;
        currentW = W;
    }
    else {
//        NSLog(@"-");
        currentH = W;
        currentW = H;
    }    
    
    //取得圖片設置的左上角坐標
    CGPoint imagePosition = CGPointMake(currentW - CGRectGetWidth(imageView.frame), currentH - CGRectGetHeight(imageView.frame));
    
    //設定圖片在畫面右下角
    [imageView setFrame:CGRectMake(imagePosition.x, imagePosition.y, CGRectGetWidth(imageView.frame), CGRectGetHeight(imageView.frame))];    
}

@end
