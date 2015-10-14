//
//  ViewController.h
//  PageView
//
//  Created by JzChang on 12/12/13.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIScrollView *scrollView;

@end
