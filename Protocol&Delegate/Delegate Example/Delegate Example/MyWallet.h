//
//  MyWallet.h
//  Delegate Example
//
//  Created by JzChang on 12/9/8.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "examMoney.h"

@interface MyWallet : NSObject

- (void)showTheMoney;
@property (weak) id <examMoney> delegate;
// delegate 變數要存放的實體必須要實作 <examMoney> 這個 protocol
@property (nonatomic, strong) NSString *title;
@property (nonatomic) float money;

@end
