//
//  ViewController.m
//  TableView
//
//  Created by JzChang on 13/2/8.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

/*
 參考網址:http://stackoverflow.com/questions/6058233/checkmarks-in-a-uitableview
 */

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *dataAry;

@end

NSMutableArray *marks, *selectArray; // marks:紀錄是否有選擇 Checkmark, selectArray:儲存選擇的資料

@implementation ViewController

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
//    self.tableView.allowsMultipleSelection = YES;
    
    selectArray = [[NSMutableArray alloc] init];
    
    marks = [[NSMutableArray alloc] init];
    
    // YES:已選擇, NO:未選擇
    for (int i = 0 ; i < [self.dataAry count]; i++) {
        [marks addObject:@"NO"];
    }    
}

- (NSMutableArray *)dataAry
{
    if (!_dataAry) {
        _dataAry = [[NSMutableArray alloc] init];
        
        for (int i = 'A'; i <= 'Z'; i++) {
            [_dataAry addObject:[NSString stringWithFormat:@"%c", i]];
        }
    }
    return _dataAry;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"Cell";    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if ([[marks objectAtIndex:indexPath.row] isEqualToString:@"YES"]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    // Configure the cell.    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %@", [self.dataAry objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *thisCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (thisCell.accessoryType == UITableViewCellAccessoryCheckmark) {
        [thisCell setAccessoryType:UITableViewCellAccessoryNone];
        [selectArray removeObject:[self.dataAry objectAtIndex:indexPath.row]];
        [marks replaceObjectAtIndex:indexPath.row withObject:@"NO"];
    }
    else {
        [thisCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [selectArray addObject:[self.dataAry objectAtIndex:indexPath.row]];
        [marks replaceObjectAtIndex:indexPath.row withObject:@"YES"];
    }
    
    self.navigationItem.title = [self.dataAry objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%@", selectArray);
}

@end
