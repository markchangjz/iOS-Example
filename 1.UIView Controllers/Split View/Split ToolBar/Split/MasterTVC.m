//
//  MasterTVC.m
//  Split
//
//  Created by JzChang on 13/1/19.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "MasterTVC.h"
#import "DetailVC.h"

@interface MasterTVC () <DetailDataSource>

@property (strong, nonatomic) NSMutableArray *tableViewData;
@property (nonatomic) NSInteger selectCellIndex;

@end

@implementation MasterTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"選 單";   
     
    // 設定 delegate
    self.delegate = [self.splitViewController.viewControllers lastObject];
}

#pragma mark - lazy instantiation

- (NSMutableArray *)tableViewData
{
    if (!_tableViewData) {
        _tableViewData = [[NSMutableArray alloc] init];
        
        for (int i = 'A'; i <= 'Z'; i++) {
            NSString *obj = [NSString stringWithFormat:@"%c ( %d )", i, i];
            [_tableViewData addObject:obj];
        }
    }
    return _tableViewData;
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
    self.selectCellIndex = indexPath.row;
    NSString *selectCellData = [self.tableViewData objectAtIndex:indexPath.row];
    
    if ([self.delegate conformsToProtocol:@protocol(ShowDataDelegate)]) {
        [self.delegate ShowDataAtDetailView:selectCellData];
    }
}

#pragma mark - DetailVC- DetailDataSource

- (void)getMasterData:(NSString *)op;
{
    if ([self.delegate conformsToProtocol:@protocol(ShowDataDelegate)]) {
        if ([op isEqualToString:@"-"]) {
            if (self.selectCellIndex - 1 >= 0) {
                NSString *prevData = [self.tableViewData objectAtIndex:--self.selectCellIndex];
                [self.delegate ShowDataAtDetailView:prevData];
                [self.delegate SegmentEnble:1];
                
            }
            else {
                // 至最前面(A)後關閉上一個按鈕作用
                [self.delegate SegmentDisable:0];
            }
        }
        else if ([op isEqualToString:@"+"]) {
            if (self.selectCellIndex + 1 < [self.tableViewData count]) {
                NSString *nextData = [self.tableViewData objectAtIndex:++self.selectCellIndex];
                [self.delegate ShowDataAtDetailView:nextData];
                [self.delegate SegmentEnble:0];
            }
            else {
                // 至最後面(Z)後關閉下一個按鈕作用
                [self.delegate SegmentDisable:1];
            }
        }
    } 
}

@end
