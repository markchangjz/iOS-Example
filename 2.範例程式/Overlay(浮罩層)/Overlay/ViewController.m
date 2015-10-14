//
//  ViewController.m
//  Overlay
//
//  Created by JzChang on 13/2/25.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@property (strong, nonatomic) UITapGestureRecognizer *tapTouch;

@end

UIView *overlayView;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

// 顯示 Overlay
- (void)presentOverlay
{    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         overlayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             //
                         }
                     }];    
    
}

// 隱藏 Overlay
- (void)removeOverlay
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         overlayView.backgroundColor = [UIColor clearColor];
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [overlayView removeFromSuperview];
                             overlayView = nil;
                         }
                     }];
}

- (IBAction)clickAction:(UIBarButtonItem *)sender
{
    UIWindow *window = self.view.window;
    overlayView = [[UIView alloc] initWithFrame:window.bounds];
    
    overlayView.backgroundColor = [UIColor clearColor];
    overlayView.userInteractionEnabled = YES;
    
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    aiv.center = CGPointMake(CGRectGetMidX(overlayView.bounds), CGRectGetMidY(overlayView.bounds)); // overlayView.center;
    [aiv startAnimating];
    
    [overlayView addSubview:aiv];
    
    [window addSubview:overlayView];
    
    // 加入手勢控制
    [overlayView addGestureRecognizer:self.tapTouch];
    
    [self presentOverlay];
    
    [self performSelector:@selector(removeOverlay) withObject:nil afterDelay:5.0f];
}

#pragma mark - lazy instantiation

- (UITapGestureRecognizer *)tapTouch
{
    if (!_tapTouch) {
        _tapTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        _tapTouch.numberOfTouchesRequired = 1;  // 手指數
        _tapTouch.numberOfTapsRequired = 1;     // 連續點擊次數
    }
    return _tapTouch;
}

#pragma mark - selector

- (void)handleTap:(UITapGestureRecognizer *)gesture
{
    if (overlayView) {
        [self removeOverlay];
    }
}

@end
