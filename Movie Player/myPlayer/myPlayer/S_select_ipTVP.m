//
//  S_select_ipTVP.m
//  myPlayer
//
//  Created by JzChang on 13/1/5.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "S_select_ipTVP.h"

@interface S_select_ipTVP ()

@property (strong, nonatomic) NSOrderedSet *ipList;

@end

@implementation S_select_ipTVP

NSIndexPath *checkedCell; // 設定 Checkmark

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.ipList = [[NSOrderedSet alloc] initWithObjects:@"http://192.168.0.103", @"http://140.118.7.9", nil];
    
    [self setupView];
}

#pragma mark - code

- (void)setupView
{
    self.title = @"選擇網路位址";
    
    self.tableView.rowHeight = 60; // 設定 Table View 每個 Cell 的高度
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.ipList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil]; // 要修正成自己 alloc init
    
    
    // Configure the cell...
    cell.textLabel.text = [self.ipList objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    
    // 設定 Checkmark
    if (checkedCell != nil && checkedCell.row == indexPath.row && checkedCell.section == indexPath.section) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 設定 Checkmark
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (checkedCell != nil) { // Uncheck previously selected cell
        UITableViewCell *prevSelectedCell = [tableView cellForRowAtIndexPath:checkedCell];
        prevSelectedCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    checkedCell = indexPath;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.delegate selectIP:self withIP:[self.ipList objectAtIndex:indexPath.row]];
}

@end
