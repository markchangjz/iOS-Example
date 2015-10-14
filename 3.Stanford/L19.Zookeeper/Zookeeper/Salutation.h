//
//  Salutation.h
//  Zookeeper
//
//  Created by JzChang on 12/12/24.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Salutation;

@protocol SalutationDelegate <NSObject>

- (void)salutationTVC:(Salutation *)sender setSalutation:(NSString *)selectalutation; // 回傳所點選的 Salutation

@end

@interface Salutation : UITableViewController

@property (nonatomic, strong) NSString *selectSalutation;
@property (nonatomic, weak) id <SalutationDelegate> delegate;

@end
