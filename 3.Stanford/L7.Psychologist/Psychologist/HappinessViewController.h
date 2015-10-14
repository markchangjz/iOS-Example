//
//  HappinessViewController.h
//  Happiness
//
//  Created by JzChang on 12/9/2.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplitViewBarButtonItemPresenter.h"

@interface HappinessViewController : UIViewController <SplitViewBarButtonItemPresenter>

@property (nonatomic) int happiness; // 0 is sad; 100 is very happy

@end
