//
//  DetailVC.h
//  NSUserDefaults_iPad
//
//  Created by JzChang on 12/9/29.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplitViewBarButtonItemPresenter.h"

@interface DetailVC : UIViewController <SplitViewBarButtonItemPresenter> // 實作 Protocol

@property (strong, nonatomic) NSString *showData;
@property (weak, nonatomic) IBOutlet UILabel *showDataLbl;
- (IBAction)clickSaveData:(UIButton *)sender;
- (IBAction)clickCleanData:(UIButton *)sender;
- (IBAction)clickShowSavedData:(UIBarButtonItem *)sender;

@end
