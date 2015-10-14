//
//  Zoo.m
//  Zookeeper
//
//  Created by JzChang on 12/12/24.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "Zoo.h"
#import "Animal.h"
#import "PlistHelper.h"

@interface Zoo ()

@property (strong, nonatomic) NSMutableDictionary *storeData; // 存放 plist 的資料
@property (nonatomic) BOOL autoPerformBySegue; // Y:自動執行 Segue, N:手動 performSegueWithIdentifier 執行 Segue

@end

@implementation Zoo

@synthesize storeData = _storeData;
@synthesize autoPerformBySegue = _autoPerformBySegue;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.autoPerformBySegue = YES;
    
    self.storeData = [[NSMutableDictionary alloc] initWithContentsOfFile:[PlistHelper plistFilePath]]; // 讀取 plist 資料
    [self.tableView reloadData]; // 重新載入 Table View
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    Animal *animal = (Animal *)segue.destinationViewController;
    
    if ([[segue identifier] isEqualToString:@"Show Segue"] && self.autoPerformBySegue) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow]; // 點選位置的 index path
        NSString *key = [[self.storeData allKeys] objectAtIndex:indexPath.row];
        NSDictionary *selectData = [[NSDictionary alloc] initWithObjectsAndKeys:[self.storeData objectForKey:key], key, nil];
        animal.showSelectData = selectData;        
        self.autoPerformBySegue = YES;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.storeData allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Zoo Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *storeDataKey = [[self.storeData allKeys] objectAtIndex:indexPath.row];
    NSString *firstName = [[self.storeData objectForKey:storeDataKey] objectForKey:@"firstName"];
    NSString *lastName = [[self.storeData objectForKey:storeDataKey] objectForKey:@"lastName"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    return cell;
}

// 要可刪除 Cell 必需回傳 YES
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {        
        // 1. 必需先刪除變數資料
        NSString *selectKey = [[self.storeData allKeys] objectAtIndex:indexPath.row];
        [self.storeData removeObjectForKey:selectKey]; 
        
        // 2. 刪除相對在 plist 中的資料欄位
        NSString *plistPath = [PlistHelper plistFilePath];
        [[NSFileManager defaultManager] removeItemAtPath:plistPath error:nil]; // 刪除舊的plist
        [self.storeData writeToFile:plistPath atomically:YES];        
        
        // 3. 刪除 cell
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];        
    }  
}

#pragma mark - target-action

- (IBAction)addData:(UIBarButtonItem *)sender
{
    self.autoPerformBySegue = NO;
    [self performSegueWithIdentifier:@"Show Segue" sender:self];
}

@end
