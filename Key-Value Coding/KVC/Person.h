//
//  Person.h
//  KVC
//
//  Created by JzChang on 13/1/30.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *allies;
@property (strong, nonatomic) Person *lover;
@property (strong, nonatomic) NSNumber *price;

- (id)initWithName:(NSString *)theName;

@end
