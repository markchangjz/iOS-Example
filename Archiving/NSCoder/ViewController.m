//
//  ViewController.m
//  NSCoder
//
//  Created by Mac on 13/10/22.
//  Copyright (c) 2013年 KKBOX. All rights reserved.
//

#import "ViewController.h"
#import "Foo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Test 1: ==========");
    [self test1_ArchiveObject];
    
    NSLog(@"Test 2: ==========");
    [self test2_ArchiveData];
    [self test2_unArchiveData];
    
    NSLog(@"Test 3: ==========");
    [self test3_UsingArchiveToDeepCopy];
}

// 將物件 Archive 與 unArchive
- (void)test1_ArchiveObject
{
    Foo *myFoo1 = [[Foo alloc] init];
    Foo *myFoo2;
    
    [myFoo1 setStrVal:@"This is the string"];
    [myFoo1 setIntVal:12345];
    [myFoo1 setFloatVal:98.6];
    
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [Path stringByAppendingPathComponent:@"foo.arch"];
    
    [NSKeyedArchiver archiveRootObject:myFoo1 toFile:filename];
    
    myFoo2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
    NSLog(@"%@\n%i\n%g", [myFoo2 strVal], [myFoo2 intVal], [myFoo2 floatVal]);
}

// 將資料物件 Archive 到 Data，再將 Data 寫入檔案儲存
- (void)test2_ArchiveData
{
    Foo *myFoo1 = [[Foo alloc] init];
    NSMutableData *dataArea;
    NSKeyedArchiver *archiver;
    
    [myFoo1 setStrVal:@"This is the string"];
    [myFoo1 setIntVal:12345];
    [myFoo1 setFloatVal:98.6];
    
    dataArea = [NSMutableData data];
    
    archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:dataArea];
    
    [archiver encodeObject:myFoo1 forKey:@"myfoo1"];
    [archiver finishEncoding];
    
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [Path stringByAppendingPathComponent:@"myArchive"];
    
    if ([dataArea writeToFile:filename atomically:YES] == NO) {
        NSLog(@"Archiving failed!");
    }
}

// 讀取儲存的 Data 檔案，讀出後再 unArchive 還原回原本物件
- (void)test2_unArchiveData
{
    NSData *dataArea;
    NSKeyedUnarchiver *unarchiver;
    Foo *myFoo1;
    
    NSString *Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [Path stringByAppendingPathComponent:@"myArchive"];
    
    dataArea = [NSData dataWithContentsOfFile:filename];
    
    if (!dataArea) {
        NSLog(@"Can't read back archive file!");
        return;
    }
    
    unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:dataArea];
    
    myFoo1 = [unarchiver decodeObjectForKey:@"myfoo1"];
    [unarchiver finishDecoding];
    
    NSLog(@"%@\n%i\n%g", [myFoo1 strVal], [myFoo1 intVal], [myFoo1 floatVal]);
}

// 透過 Archive 來做 deep copy 處理
- (void)test3_UsingArchiveToDeepCopy
{
    /*
     1.shallow copy: 只複製其 array 開頭 (該說是動態指標之 address 較為適宜)，對同一份資料進行修改，故執行完時會影響原本之資料；
     2.deep copy:    為本身再複製一份相同之 array 出來，所有運算和結果存在副本裡面，不影響原本之資料。
     */
    
    NSData *data;
    NSMutableArray *dataArray = [NSMutableArray arrayWithObjects:
                                 [NSMutableString stringWithString:@"one"],
                                 [NSMutableString stringWithString:@"two"],
                                 [NSMutableString stringWithString:@"three"],
                                 nil];
    NSMutableArray *dataArray2;
    
    // Make a deep copy using the archiver
    data = [NSKeyedArchiver archivedDataWithRootObject:dataArray];

    dataArray2 = [NSKeyedUnarchiver unarchiveObjectWithData:data]; // deep copy
//    dataArray2 = dataArray; // shallow copy
    
    dataArray2[0] = @"ONE";
    
    NSLog(@"dataArray:");
    for (NSString *elem in dataArray) {
        NSLog(@"%@", elem);
    }
    
    NSLog(@"dataArray2:");
    for (NSString *elem in dataArray2) {
        NSLog(@"%@", elem);
    }
}

@end
