//
//  Foo.m
//  NSCoder
//
//  Created by Mac on 13/10/22.
//  Copyright (c) 2013年 KKBOX. All rights reserved.
//

#import "Foo.h"

@implementation Foo

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.strVal forKey:@"FooStrVal"];
    [aCoder encodeInt:self.intVal forKey:@"FooIntVal"];
    [aCoder encodeFloat:self.floatVal forKey:@"FooFloatVal"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.strVal = [aDecoder decodeObjectForKey:@"FooStrVal"];
    self.intVal = [aDecoder decodeIntForKey:@"FooIntVal"];
    self.floatVal = [aDecoder decodeFloatForKey:@"FooFloatVal"];
    
    return self;
}

@end
