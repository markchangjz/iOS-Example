//
//  ViewController.m
//  FMDB
//
//  Created by EE Lab on 12/6/30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"

@interface ViewController () {    
    NSString *databasePtah;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.   
    
    [self initilizeDatabase:@"mydb"]; 
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

- (void)doInsert
{      
    FMDatabase *db = [FMDatabase databaseWithPath:databasePtah];
    [db open];    
    [db executeUpdate:@"INSERT INTO AddressBook (name,age,company,address) VALUES(?,?,?,?)", @"JzChang", [NSNumber numberWithInt:23], @"ABC", @"Tainan"];
    NSLog(@"%d", [db changes]);
    [db close];
}

- (void)doSelect
{
    FMDatabase *db = [FMDatabase databaseWithPath:databasePtah];
    
    [db open];
    
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM AddressBook"];   
    
    while ([rs next]) {
        NSString *name = [rs stringForColumn:@"name"];
        NSString *age = [rs stringForColumn:@"age"];
        NSString *company = [rs stringForColumn:@"company"];
        NSString *address = [rs stringForColumn:@"address"];
        
        NSLog(@"%@, %@, %@, %@", name, age, company, address);
    }
    
    [db close];
}

//- (void)viewDidUnload
//{
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}

@end
