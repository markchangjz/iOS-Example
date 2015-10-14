//
//  Furnace.m
//  Protocol
//
//  Created by JzChang on 12/9/8.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "Furnace.h"

@implementation Furnace

@synthesize delegate;

- (void)delegateFunction
{
    [delegate whenCalledDelegeteFunction];
}

@end
