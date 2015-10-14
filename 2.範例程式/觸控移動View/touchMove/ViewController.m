//
//  ViewController.m
//  touchMove
//
//  Created by JzChang on 13/3/28.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIView *panningView1, *panningView2;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 任意移動
    self.panningView1 = [[UIView alloc] initWithFrame:CGRectMake(300, 350, 100, 100)];
    [self.panningView1 setBackgroundColor:[UIColor greenColor]];
    
    UIPanGestureRecognizer *pgr1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan1:)];
    [self.panningView1 addGestureRecognizer:pgr1];
    
    // 水平移動
    self.panningView2 = [[UIView alloc] initWithFrame:CGRectMake(20, 50, 200, 400)];
    [self.panningView2 setBackgroundColor:[UIColor darkGrayColor]];
    
    UIPanGestureRecognizer *pgr2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan2:)];
    [self.panningView2 addGestureRecognizer:pgr2];
    
    [self.view addSubview:self.panningView1];
    [self.view addSubview:self.panningView2];    
}

-(void)handlePan1:(UIPanGestureRecognizer*)pgr;
{
    if (pgr.state == UIGestureRecognizerStateChanged) {
        CGPoint center = pgr.view.center;
        CGPoint translation = [pgr translationInView:pgr.view];
        
        center = CGPointMake(center.x + translation.x, center.y + translation.y);
        pgr.view.center = center;
        [pgr setTranslation:CGPointZero inView:pgr.view];
    }
}

-(void)handlePan2:(UIPanGestureRecognizer*)pgr;
{
    if (pgr.state == UIGestureRecognizerStateChanged) {
        CGPoint origin = pgr.view.frame.origin;
        CGPoint translation = [pgr translationInView:pgr.view];
        
        origin = CGPointMake(origin.x + translation.x, 0);
        pgr.view.frame = CGRectMake(origin.x, pgr.view.frame.origin.y, pgr.view.frame.size.width, pgr.view.frame.size.height);
        [pgr setTranslation:CGPointZero inView:pgr.view];
    }
}

-(void)dragging:(UIPanGestureRecognizer *)gesture
{
    CGPoint panCoord;
    
    if(gesture.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Received a pan gesture");
        panCoord = [gesture locationInView:gesture.view];
    }
    
    CGPoint newCoord = [gesture locationInView:gesture.view];
    float dX = newCoord.x - panCoord.x;
    float dY = newCoord.y - panCoord.y;
    
    gesture.view.frame = CGRectMake(gesture.view.frame.origin.x+dX, gesture.view.frame.origin.y+dY, gesture.view.frame.size.width, gesture.view.frame.size.height);
}

@end
