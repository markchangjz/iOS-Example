//
//  Person.m
//  KVC
//
//  Created by JzChang on 13/1/30.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)initWithName:(NSString *)theName
{
    if (self = [super init]) {
        _name = theName;
    }
    return self;
}

@end
