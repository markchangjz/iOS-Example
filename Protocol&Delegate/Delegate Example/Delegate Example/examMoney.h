//
//  examMoney.h
//  Delegate Example
//
//  Created by JzChang on 12/9/8.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol examMoney <NSObject>
- (void)printWallet:(NSString *)wallet withMoney:(float)money;
@end
