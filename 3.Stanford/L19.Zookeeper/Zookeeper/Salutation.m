//
//  Salutation.m
//  Zookeeper
//
//  Created by JzChang on 12/12/24.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "Salutation.h"

@interface Salutation ()

@property (strong, nonatomic) NSArray *selectMeun; // Table View 的資料, Salutation 選項

@end

@implementation Salutation

@synthesize selectMeun = _selectMeun;
@synthesize selectSalutation = _selectSalutation;

NSIndexPath *checkedCell; // 設定 Checkmark

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    checkedCell = nil;
    NSArray *sec1 = @[@"none"];
    NSArray *sec2 = @[@"Mr.", @"Sir", @"Madam", @"General", @"Sergeant", @"Archdeacon", @"His Excellency", @"Premier"];
    self.selectMeun = @[sec1, sec2];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.selectMeun count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.selectMeun objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Salutation Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *tableViewString = [[self.selectMeun objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }  
    
    // 設定 Checkmark    
//    if (checkedCell != nil && checkedCell.row == indexPath.row && checkedCell.section == indexPath.section) {        
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;       
//    }
//    else {        
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    
    if ([tableViewString isEqualToString:self.selectSalutation]) {
        self.selectSalutation = nil;
        checkedCell = indexPath;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.textLabel.textColor = [UIColor blueColor];
    }
    
    cell.textLabel.text = tableViewString;    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (checkedCell != nil) { // Uncheck previously selected cell        
        UITableViewCell *prevSelectedCell = [tableView cellForRowAtIndexPath:checkedCell];
        prevSelectedCell.accessoryType = UITableViewCellAccessoryNone;
        prevSelectedCell.textLabel.textColor = [UIColor blackColor];
    }
    
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    selectedCell.textLabel.textColor = [UIColor blueColor];
    checkedCell = indexPath;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    // 選擇 Cell 的 Label
    NSString *selectCellLabelText = [[self.selectMeun objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [self.delegate salutationTVC:self setSalutation:selectCellLabelText]; // 使用 delegate
}

@end
