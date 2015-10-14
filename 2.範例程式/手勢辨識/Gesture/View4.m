//
//  View4.m
//  Gesture
//
//  Created by JzChang on 13/3/25.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "View4.h"
#import "UIImageResizing.h"

@interface View4 () {
    UILabel *lbl_locationInView, *lbl_velocityInView, *lbl_translationInView;
}

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

@end

@implementation View4

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarItem.title = @"Pan";
        self.tabBarItem.badgeValue = @"4";
        self.tabBarItem.image = [UIImageResizing imageFromImage:[UIImage imageNamed:@"4"] resizeToHeight:40 andWidth:40];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.view addGestureRecognizer:self.panGesture];
    
    lbl_locationInView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    lbl_locationInView.center = CGPointMake(self.view.center.x, 50);
    lbl_locationInView.backgroundColor = [UIColor grayColor];
    lbl_locationInView.textAlignment = NSTextAlignmentCenter;
    lbl_locationInView.numberOfLines = 2;
    [self.view addSubview:lbl_locationInView];
    
    lbl_velocityInView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    lbl_velocityInView.center = CGPointMake(self.view.center.x, 150);
    lbl_velocityInView.backgroundColor = [UIColor grayColor];
    lbl_velocityInView.textAlignment = NSTextAlignmentCenter;
    lbl_velocityInView.numberOfLines = 2;
    [self.view addSubview:lbl_velocityInView];
    
    lbl_translationInView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    lbl_translationInView.center = CGPointMake(self.view.center.x, 250);
    lbl_translationInView.backgroundColor = [UIColor grayColor];
    lbl_translationInView.textAlignment = NSTextAlignmentCenter;
    lbl_translationInView.numberOfLines = 2;
    [self.view addSubview:lbl_translationInView];
}

#pragma mark - lazy instantiation

- (UIPanGestureRecognizer *)panGesture
{
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    }
    return _panGesture;
}

#pragma mark - selector

- (void)handlePan:(UIPanGestureRecognizer *)gesture
{
//    if (gesture.state != UIGestureRecognizerStateEnded) {
//        return;
//    }
    
    NSLog(@"locationInView = (%f, %f)", [gesture locationInView:self.view].x, [gesture locationInView:self.view].y);
    lbl_locationInView.text = [NSString stringWithFormat:@"locationInView\n(%.2f, %.2f)", [gesture locationInView:self.view].x, [gesture locationInView:self.view].y];
    
    NSLog(@"velocityInView = (%f, %f)", [gesture velocityInView:self.view].x, [gesture velocityInView:self.view].y);
    lbl_velocityInView.text = [NSString stringWithFormat:@"velocityInView\n(%.2f, %.2f)", [gesture velocityInView:self.view].x, [gesture velocityInView:self.view].y];

    NSLog(@"translationInView = (%f, %f)", [gesture translationInView:self.view].x, [gesture translationInView:self.view].y);
    lbl_translationInView.text = [NSString stringWithFormat:@"translationInView\n(%.2f, %.2f)", [gesture translationInView:self.view].x, [gesture translationInView:self.view].y];

}

@end
