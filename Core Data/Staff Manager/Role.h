//
//  Role.h
//  Staff Manager
//
//  Created by EE Lab on 12/7/10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Role : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *heldBy;
@end

@interface Role (CoreDataGeneratedAccessors)

- (void)addHeldByObject:(NSManagedObject *)value;
- (void)removeHeldByObject:(NSManagedObject *)value;
- (void)addHeldBy:(NSSet *)values;
- (void)removeHeldBy:(NSSet *)values;

@end
