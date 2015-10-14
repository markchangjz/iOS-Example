//
//  MyWallet.m
//  Delegate Example
//
//  Created by JzChang on 12/9/8.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "MyWallet.h"

@implementation MyWallet
@synthesize delegate, title, money;

- (void)showTheMoney
{
    // respondsToSelector 判斷 delegate 是否有實作 printWallet:withMoney: 方法
    if ([delegate respondsToSelector:@selector(printWallet:withMoney:)]) {
        [delegate printWallet:self.title withMoney:money];
    }
    else {
        NSLog(@"Please implement printWallet:withMoney:");
    }
    
}
@end
