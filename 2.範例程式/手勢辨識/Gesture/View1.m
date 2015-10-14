//
//  View1.m
//  Gesture
//
//  Created by JzChang on 13/1/10.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "View1.h"
#import "UIImageResizing.h"

@interface View1 ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeUp;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeDown;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeLeft;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeRight;

@end

@implementation View1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title = @"Swipe";
        self.tabBarItem.badgeValue = @"1";             
        self.tabBarItem.image = [UIImageResizing imageFromImage:[UIImage imageNamed:@"1"] resizeToHeight:40 andWidth:40];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.imageView];
    
    // 加入手勢
    [self.view addGestureRecognizer:self.swipeUp];
    [self.view addGestureRecognizer:self.swipeDown];
    [self.view addGestureRecognizer:self.swipeLeft];
    [self.view addGestureRecognizer:self.swipeRight];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    self.imageView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
}

#pragma mark - lazy instantiation

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 0, 150, 150);
        _imageView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    }
    return _imageView;
}

- (UISwipeGestureRecognizer *)swipeUp
{
    if (!_swipeUp) {
        _swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp:)];
        _swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    }
    return _swipeUp;
}

- (UISwipeGestureRecognizer *)swipeDown
{
    if (!_swipeDown) {
        _swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
        _swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    }
    return _swipeDown;
}

- (UISwipeGestureRecognizer *)swipeLeft
{
    if (!_swipeLeft) {
        _swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
        _swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    }
    return _swipeLeft;
}

- (UISwipeGestureRecognizer *)swipeRight
{
    if (!_swipeRight) {
        _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
        _swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    }
    return _swipeRight;
}

#pragma mark - selector

- (void)handleSwipeUp:(UISwipeGestureRecognizer *)gesture
{
    self.imageView.image = [UIImage imageNamed:@"direction_up.png"];
}

- (void)handleSwipeDown:(UISwipeGestureRecognizer *)gesture
{
    self.imageView.image = [UIImage imageNamed:@"direction_down.png"];
}

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)gesture
{
    self.imageView.image = [UIImage imageNamed:@"direction_left.png"];
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)gesture
{
    self.imageView.image = [UIImage imageNamed:@"direction_right.png"];
}

@end
