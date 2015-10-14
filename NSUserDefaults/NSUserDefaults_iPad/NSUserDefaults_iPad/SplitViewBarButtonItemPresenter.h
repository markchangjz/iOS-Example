//
//  SplitViewBarButtonItemPresenter.h
//  NSUserDefaults_iPad
//
//  Created by JzChang on 12/10/7.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h> // 要修正為 UIKit/UIKit.h

@protocol SplitViewBarButtonItemPresenter <NSObject>

@property (strong, nonatomic) UIBarButtonItem *splitViewBarButtonItem;

@end
