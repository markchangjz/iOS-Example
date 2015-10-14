//
//  ViewController.m
//  sqliteTEST
//
//  Created by EE Lab on 12/6/29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>

@interface ViewController () {
    NSString *databasePtah;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initilizeDatabase:@"mydb"];
    
    // 1. 讀取資料
    [self readDataFromPath:databasePtah];
    
    // 2. 新增資料
    [self addDataToPath:databasePtah withName:@"newName" company:@"newCompany" age:60 andAddress:@"newAddress"];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)initilizeDatabase:(NSString *) databaseName
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *source = [[NSBundle mainBundle] pathForResource:databaseName ofType:@"db"];
    // 取得 <Home>/Documents 路徑
    NSString *docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *target = [[docPath stringByAppendingPathComponent:databaseName] stringByAppendingString:@".db"];
    databasePtah = target;
    
    // 檢查資料庫使否以存在 Documents 路徑內
    BOOL isSuccess = [fm fileExistsAtPath:target];
    
    // 如果已經存在不用從應用程式的資源檔內拷貝到 Documents
    if (isSuccess) {
        return;
    }
    
    // 否則從應用程式裡面複製到 Documents 目錄
    [fm copyItemAtURL:[[NSURL alloc] initFileURLWithPath:source] toURL:[[NSURL alloc] initFileURLWithPath:target] error:nil];      
}

// 讀取
- (void)readDataFromPath:(NSString *) databasePath
{
    sqlite3 *database;
    
    if (sqlite3_open([databasePtah UTF8String], &database) == SQLITE_OK) {
        const char *sql = "SELECT name,age,address FROM AddressBook WHERE age>? AND company!=?";
        sqlite3_stmt *stm;
        
        if (sqlite3_prepare(database, sql, -1, &stm, NULL) == SQLITE_OK) {
            sqlite3_bind_int(stm, 1, 20);
            sqlite3_bind_text(stm, 2, [@"Grandex" UTF8String], -1, SQLITE_TRANSIENT);
            
            while (sqlite3_step(stm) == SQLITE_ROW) {
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 0)];
                NSString *age = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 1)];
                NSString *address = [NSString stringWithUTF8String:(char *)sqlite3_column_text(stm, 2)];
                
                NSLog(@"%@, %@, %@", name, age, address);              

            }
        }
        
        sqlite3_finalize(stm);
    }
    
    sqlite3_close(database);    
}

// 新增
- (void)addDataToPath:(NSString *) databasePath withName:(NSString *) aName company:(NSString *) aCompany age:(int) aAge andAddress:(NSString *) aAddress
{
    sqlite3 *database;
    
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        NSString *sql = [[NSString alloc] initWithFormat:@"INSERT INTO AddressBook VALUES('%@', %d, '%@', '%@')", aName, aAge, aCompany, aAddress];
        
        sqlite3_exec(database, [sql UTF8String], NULL, NULL, NULL);
    }
    
    sqlite3_close(database);
}


@end
