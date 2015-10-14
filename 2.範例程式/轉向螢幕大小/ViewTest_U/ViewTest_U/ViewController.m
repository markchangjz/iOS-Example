//
//  ViewController.m
//  ViewTest_U
//
//  Created by JzChang on 13/1/12.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIView *MyView;
@property (strong, nonatomic) UIView *AddView1;
@property (strong, nonatomic) UIView *AddView2;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
     self.view 的 W * H 不會因為轉向而調整大小
     此範例為 MyView 根據 self.view 調整大小
     MyView 疊上 AddView1
     AddView1 疊上 AddView2
     */
        
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        // | 方向
        self.MyView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 40, self.view.frame.size.height - 40)];
    }
    else {
        // - 方向
        self.MyView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.height - 40, self.view.frame.size.width - 40)];
    }
    
    self.MyView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.MyView];

    self.AddView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, self.MyView.frame.size.width - 40, self.MyView.frame.size.height - 40)];
    self.AddView1.backgroundColor = [UIColor greenColor];
    [self.MyView addSubview:self.AddView1];
    
    self.AddView2 = [[UIView alloc] initWithFrame:CGRectMake(self.AddView1.frame.size.width - 70, self.AddView1.frame.size.height - 70, 50, 50)];
    self.AddView2.backgroundColor = [UIColor blueColor];
    [self.AddView1 addSubview:self.AddView2];
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
    
    self.MyView.frame = CGRectMake(20, 20, currentW - 40, currentH - 40);
    self.AddView1.frame = CGRectMake(20, 20, self.MyView.frame.size.width - 40, self.MyView.frame.size.height - 40);
    self.AddView2.frame = CGRectMake(self.AddView1.frame.size.width - 70, self.AddView1.frame.size.height - 70, 50, 50);
}

@end
