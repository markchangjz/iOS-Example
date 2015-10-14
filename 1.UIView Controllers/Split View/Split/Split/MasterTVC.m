//
//  MasterTVC.m
//  Split
//
//  Created by JzChang on 13/1/19.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "MasterTVC.h"

@interface MasterTVC ()

@property (strong, nonatomic) NSMutableArray *tableViewData;

@end

@implementation MasterTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    
    self.navigationItem.title = @"選單";
    
    // 設定 delegate
    self.delegate = (id)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    /*
     或是 #import "AppDelegate.h" 取得 splitViewController 的 property
     
     AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
     self.delegate = (id)[[appDelegate.splitViewController.viewControllers lastObject] topViewController];
     */    
    
    self.tableViewData = [[NSMutableArray alloc] init];
    
    for (int i = 'A'; i <= 'Z'; i++) {
        NSString *obj = [NSString stringWithFormat:@"%c ( %d )", i, i];
        [self.tableViewData addObject:obj];
    }    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableViewData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.tableViewData objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectCellData = [self.tableViewData objectAtIndex:indexPath.row];    
    
    [self.delegate ShowDataAtDetailView:selectCellData];
}

@end
