//
//  ViewController.m
//  Animation
//
//  Created by JzChang on 12/12/28.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

bool isTap = false;

- (void)viewDidLoad
{
    [super viewDidLoad];
	      
    [self toRed];
}

- (void)toRed
{
    self.view.backgroundColor = [UIColor blackColor];
    [UIView animateWithDuration:1
                          delay:0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.view.backgroundColor = [UIColor redColor];
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self toBlack];
                         }
                     }];
}

- (void)toBlack
{
    self.view.backgroundColor = [UIColor redColor];
    [UIView animateWithDuration:1
                          delay:0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.view.backgroundColor = [UIColor blackColor];                         
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self toRed];
                         }
                     }];
}

#pragma mark - CALayer 需要 import <QuartzCore/QuartzCore.h>

-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

- (IBAction)tap:(UITapGestureRecognizer *)sender
{    
    if (!isTap) {
        // 暫停動畫
        [self pauseLayer:self.view.layer];
        isTap = true;
    }
    else {
        // 恢復動畫
        [self resumeLayer:self.view.layer];
        isTap = false;
    }
}
@end
