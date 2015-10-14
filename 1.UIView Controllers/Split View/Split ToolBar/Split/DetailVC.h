//
//  DetailVC.h
//  Split
//
//  Created by JzChang on 13/1/19.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailDataSource <NSObject>

- (void)getMasterData:(NSString *)op; // 取得 Master 的資料

@end

@interface DetailVC : UIViewController <UISplitViewControllerDelegate>

@property (weak, nonatomic) id <DetailDataSource> dataSource;

@end
