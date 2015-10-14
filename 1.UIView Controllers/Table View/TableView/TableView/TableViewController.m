//
//  TableViewController.m
//  TableView
//
//  Created by EE Lab on 12/7/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"
#import "ShowView.h"

@interface TableViewController ()
@property (strong, nonatomic) NSMutableDictionary *data;
@end

@implementation TableViewController
@synthesize data;

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

    data = [[NSMutableDictionary alloc] init];    
    // 初始化資料
    [data setValue:[NSMutableArray arrayWithObjects:@"1a", @"1b", @"1c", @"1d", @"1e", @"1f", nil] forKey:@"KEY 1"];
    [data setValue:[NSMutableArray arrayWithObjects:@"2a", @"2b", @"2c", nil] forKey:@"KEY 2"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 回傳key的數量
    return [[data allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 回傳key裡的資料數量
    return [[data objectForKey:[[data allKeys] objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [[data objectForKey:[[data allKeys] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"306.png"];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[data allKeys] objectAtIndex:section];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 刪除對應的陣列資料
        [[data objectForKey:[[data allKeys] objectAtIndex:indexPath.section]] removeObjectAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    
        [self.tableView reloadData];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ShowDetailSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ShowView *showView = (ShowView *)segue.destinationViewController;
    
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    
    NSString *sectionName = [[data allKeys] objectAtIndex:indexPath.section];
    NSString *cellName = [[data objectForKey:[[data allKeys] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];    
    
    showView.postData = [NSString stringWithFormat:@"%@ , %@", sectionName, cellName];
}

@end