//
//  Foo.h
//  NSCoder
//
//  Created by Mac on 13/10/22.
//  Copyright (c) 2013年 KKBOX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Foo : NSObject <NSCoding>

@property (copy, nonatomic) NSString *strVal;
@property int intVal;
@property float floatVal;

@end
