//
//  Furnace.h
//  Protocol
//
//  Created by JzChang on 12/9/8.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FurnaceDelegate.h"

@interface Furnace : NSObject
@property (weak) id <FurnaceDelegate> delegate;
- (void) delegateFunction;
@end
