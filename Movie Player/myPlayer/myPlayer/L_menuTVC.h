//
//  L_menuTVC.h
//  myPlayer
//
//  Created by JzChang on 13/1/4.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalViewControllerDelegate.h"

@interface L_menuTVC : UITableViewController

@property (weak, nonatomic) id <ModalViewControllerDelegate> delegate;

@end
