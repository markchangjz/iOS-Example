//
//  MasterTVC.h
//  Split
//
//  Created by JzChang on 13/1/19.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShowDataDelegate <NSObject>

- (void)ShowDataAtDetailView:(NSString *)data;

@end

@interface MasterTVC : UITableViewController

@property (weak, nonatomic) id <ShowDataDelegate> delegate;

@end
