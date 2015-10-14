//
//  OmniExamer.m
//  Delegate Example
//
//  Created by JzChang on 12/9/8.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "OmniExamer.h"

@implementation OmniExamer

- (void)printWallet:(NSString *)wallet withMoney:(float)money
{
    NSLog(@"*** The wallet: \"%@\" with Money \"%f\" ***", wallet, money);
}

@end
