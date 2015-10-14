//
//  showDataTVC.h
//  NSUserDefaults_iPad
//
//  Created by JzChang on 12/9/29.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class showDataTVC;

@protocol showDataTVCDelegate

- (void)showDataProtocol:(showDataTVC *)sender choseData:(id)data;

@end

@interface showDataTVC : UITableViewController
@property (strong, nonatomic) NSMutableArray *storeData;
@property (weak, nonatomic) id <showDataTVCDelegate> delegate;

@end
