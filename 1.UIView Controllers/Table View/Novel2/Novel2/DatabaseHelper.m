//
//  DatabaseHelper.m
//  Novel
//
//  Created by EE Lab on 12/7/4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DatabaseHelper.h"

@implementation DatabaseHelper

- (void)openDatabase
{
    // 資料庫名稱
    NSString *dabaseName = @"myNovel";
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:dabaseName ofType:@"db"];
    
    NSString *docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *databasePath  = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db", dabaseName]];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isExist = [fm fileExistsAtPath:databasePath];
    
    if (!isExist) {
        [fm copyItemAtURL:[[NSURL alloc] initFileURLWithPath:resourcePath] toURL:[[NSURL alloc] initFileURLWithPath:databasePath] error:nil];
    }
    else {
//        NSLog(@"Exist");
    }
    
    database = [FMDatabase databaseWithPath:databasePath];
    [database open];
}

- (NSMutableArray *)categories
{
    [self openDatabase];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMResultSet *rs = [database executeQuery:@"SELECT title FROM book"];
    
    while ([rs next]) {
        [result addObject:[rs stringForColumn:@"title"]];
    }
    
    return result;
}

- (NSMutableArray *)bookIDs
{
    [self openDatabase];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMResultSet *rs = [database executeQuery:@"SELECT bookID FROM book"];
    
    while ([rs next]) {
        [result addObject:[rs stringForColumn:@"bookID"]];
    }
    
    return result;
}

- (NSString *)indexForTitle:(NSString *)title
{
    [self openDatabase];
    NSString *bookID = [database stringForQuery:@"SELECT bookID FROM book WHERE title = ?", title];
    return bookID;
}

- (NSString *)contentForIndex:(NSString *)index
{
    [self openDatabase];
    NSString *content = [database stringForQuery:@"SELECT content FROM book WHERE bookID = ?", index];
    return content;
}

- (NSString *)titleForIndex:(NSString *)index
{
    [self openDatabase];
    NSString *title = [database stringForQuery:@"SELECT title FROM book WHERE bookID = ?", index];
    return title;
}

- (void)deleteBookForIndex:(NSString *)index
{
    [self openDatabase];
    [database executeUpdate:@"DELETE FROM book WHERE bookID = ?", index];
}

@end
