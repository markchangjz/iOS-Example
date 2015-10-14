//
//  View2.m
//  Gesture
//
//  Created by JzChang on 13/1/10.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "View2.h"
#import "UIImageResizing.h"
#import <QuartzCore/QuartzCore.h>

@interface View2 ()

@property (strong, nonatomic) UILongPressGestureRecognizer *longPress;
@property (strong, nonatomic) UIView *touchPositionView;

@end

@implementation View2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title = @"Long Press";
        self.tabBarItem.badgeValue = @"2";
        self.tabBarItem.image = [UIImageResizing imageFromImage:[UIImage imageNamed:@"2"] resizeToHeight:40 andWidth:40];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	[self.view addGestureRecognizer:self.longPress];
}

#pragma mark - lazy instantiation

- (UILongPressGestureRecognizer *)longPress
{
    if (!_longPress) {
        _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        _longPress.minimumPressDuration = 1; // 設定長按幾秒後觸發事件
    }
    return _longPress;
}

- (UIView *)touchPositionView
{
    if (!_touchPositionView) {
        _touchPositionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _touchPositionView.backgroundColor = [UIColor greenColor];
        
        _touchPositionView.layer.masksToBounds = YES;
        _touchPositionView.layer.cornerRadius = 50;
    }
    return _touchPositionView;
}

#pragma mark - selector

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan){
        //NSLog(@"UIGestureRecognizerStateBegan."); //Do Whatever You want on Began of Gesture        
        self.touchPositionView.backgroundColor = [UIColor redColor];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded) {
        //NSLog(@"UIGestureRecognizerStateEnded"); //Do Whatever You want on End of Gesture        
        self.touchPositionView.backgroundColor = [UIColor greenColor];
        [self.touchPositionView removeFromSuperview];
    }
}

#pragma mark - touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    self.touchPositionView.center = CGPointMake(location.x, location.y);
    [self.view addSubview:self.touchPositionView];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    self.touchPositionView.center = CGPointMake(location.x, location.y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.touchPositionView removeFromSuperview];
}

@end
