//
//  main.m
//  Delegate Example
//
//  Created by JzChang on 12/9/8.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyWallet.h"
#import "OmniExamer.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        MyWallet *wallet = [MyWallet new];
        wallet.title = @"My Wallet";
        wallet.money = 500.0;
        OmniExamer *oe = [OmniExamer new];
        wallet.delegate = oe;
        // 委託關係的建立 (oe 把位址給 wallet.delegate)
        // 將 printWallet:withMoney: 方法委託給 OmniExamer 實作        
        // NSLog(@"%@", wallet.delegate == oe ? @"YES" : @"NO");        
        [wallet showTheMoney];       
    }
    return 0;
}

