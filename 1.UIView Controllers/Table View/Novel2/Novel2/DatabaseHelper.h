//
//  DatabaseHelper.h
//  Novel
//
//  Created by EE Lab on 12/7/4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface DatabaseHelper : NSObject {
    @private
    FMDatabase *database;
}

- (void)openDatabase;
- (NSMutableArray *)categories;
- (NSMutableArray *)bookIDs;
- (NSString *)indexForTitle:(NSString *)title;
- (NSString *)contentForIndex:(NSString *)index;
- (NSString *)titleForIndex:(NSString *)index;
- (void)deleteBookForIndex:(NSString *)index;

@end
