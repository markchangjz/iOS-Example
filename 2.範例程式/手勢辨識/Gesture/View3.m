//
//  View3.m
//  Gesture
//
//  Created by JzChang on 13/1/10.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "View3.h"
#import "UIImageResizing.h"

@interface View3 ()

@property (strong, nonatomic) UITapGestureRecognizer *tapTouch;
@property (strong, nonatomic) UIImageView *imageView;
@property (nonatomic) BOOL switchTap;

@end

@implementation View3


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title = @"Tap";
        self.tabBarItem.badgeValue = @"3";
        self.tabBarItem.image = [UIImageResizing imageFromImage:[UIImage imageNamed:@"3"] resizeToHeight:40 andWidth:40];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.switchTap = YES;
	
    [self.view addSubview:self.imageView];
    [self.view addGestureRecognizer:self.tapTouch];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    self.imageView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
}

#pragma mark - lazy instantiation

- (UITapGestureRecognizer *)tapTouch
{
    if (!_tapTouch) {
        _tapTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        _tapTouch.numberOfTouchesRequired = 1;  // 手指數
        _tapTouch.numberOfTapsRequired = 2;     // 連續點擊次數
    }
    return _tapTouch;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"close"]];
        _imageView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    }
    return _imageView;
}

#pragma mark - selector

- (void)handleTap:(UITapGestureRecognizer *)gesture
{
    if (self.switchTap) {
        self.imageView.image = [UIImage imageNamed:@"open"];
        self.switchTap = NO;
    }
    else {
        self.imageView.image = [UIImage imageNamed:@"close"];
        self.switchTap = YES;
    }
}

@end
