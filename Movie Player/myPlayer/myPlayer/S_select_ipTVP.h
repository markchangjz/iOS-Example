//
//  S_select_ipTVP.h
//  myPlayer
//
//  Created by JzChang on 13/1/5.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class S_select_ipTVP;

@protocol selectIPDelegate <NSObject>

- (void)selectIP:(S_select_ipTVP *)sender withIP:(NSString *)ipAddress;

@end

@interface S_select_ipTVP : UITableViewController

@property (weak, nonatomic) id <selectIPDelegate> delegate;

@end
