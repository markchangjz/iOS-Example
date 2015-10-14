//
//  MasterTVC.h
//  Split
//
//  Created by JzChang on 13/1/19.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShowDataDelegate <NSObject>

- (void)ShowDataAtDetailView:(NSString *)data;  // 將點選資料顯示到 Detail View
- (void)SegmentDisable:(NSUInteger)index;       // 關閉 segment 第 index 個按鈕失效
- (void)SegmentEnble:(NSUInteger)index;         // 開啟 segment 第 index 個按鈕作用

@end

@interface MasterTVC : UITableViewController

@property (weak, nonatomic) id <ShowDataDelegate> delegate;

@end
