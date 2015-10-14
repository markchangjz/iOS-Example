//
//  ResultViewController.h
//  NavigationController
//
//  Created by JzChang on 12/9/28.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (copy, nonatomic) NSString *message;

@end
