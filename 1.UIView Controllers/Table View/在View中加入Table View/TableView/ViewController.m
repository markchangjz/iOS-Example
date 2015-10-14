//
//  ViewController.m
//  TableView
//
//  Created by JzChang on 13/2/21.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSArray *data1, *data2, *tableData, *sectionData;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    data1 = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G"];
    data2 = @[@"a", @"b", @"c", @"d", @"e"];
    tableData = @[data1, data2];
    sectionData = @[@"大寫", @"小寫"];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(30, 40, 260, 300) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor colorWithRed:0.5 green:1 blue:1 alpha:0.35];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [self.view addSubview:tableView];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[tableData objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    cell.textLabel.text = [[tableData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionData objectAtIndex:section];
}

@end
