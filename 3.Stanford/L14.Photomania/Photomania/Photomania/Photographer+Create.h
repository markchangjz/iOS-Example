//
//  Photographer+Create.h
//  Photomania
//
//  Created by JzChang on 12/12/16.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "Photographer.h"

@interface Photographer (Create)

+ (Photographer *)photoWithName:(NSString *)name
         inManagedObjectContext:(NSManagedObjectContext *)context;

@end
