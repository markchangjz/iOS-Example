//
//  RootViewController.h
//  NavigationController
//
//  Created by JzChang on 12/9/28.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController

// Root View Controller中是一個表格，它的每一行對應一個Sub View Controller
@property (strong, nonatomic) NSArray *controllerList;

@end
