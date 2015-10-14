//
//  S_menuTVC.h
//  myPlayer
//
//  Created by JzChang on 13/1/5.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModalViewControllerDelegate.h"

@interface S_menuTVC : UITableViewController

@property (weak, nonatomic) id <ModalViewControllerDelegate> delegate;

@end
