//
//  TableViewController.m
//  Novel2
//
//  Created by EE Lab on 12/7/4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"
#import "ContentViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    DatabaseHelper *helper = [DatabaseHelper new];
    titles = [helper categories];
    searchResults = [NSMutableArray new];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    titles = nil;
    searchResults = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// 搜尋相關 title
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [searchResults removeAllObjects];
    [searchResults addObjectsFromArray:titles];
    [searchResults filterUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    // Return the number of rows in the section.
    NSInteger rows = 0;
    
    if (tableView == [[self searchDisplayController] searchResultsTableView]) {
        rows = [searchResults count];
    }
    else {
        rows = [titles count];
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (tableView == [[self searchDisplayController] searchResultsTableView]) {
        cell.textLabel.text = [searchResults objectAtIndex:[indexPath row]];
    }
    else {
        cell.textLabel.text = [titles objectAtIndex:[indexPath row]];        
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{   
    ContentViewController *contentView = (ContentViewController *)segue.destinationViewController;
    DatabaseHelper *helper = [DatabaseHelper new];

    NSIndexPath *indexPath;

    if ([self searchDisplayController].searchResultsTableView.frame.size.height > 0) {       
        indexPath = [[self searchDisplayController] searchResultsTableView].indexPathForSelectedRow;
    }
    else {        
        indexPath = self.tableView.indexPathForSelectedRow;
    }
    
    NSString *selectCellText = [titles objectAtIndex:indexPath.row];
    contentView.bookID = [helper indexForTitle:selectCellText];
    contentView.bookTitle = selectCellText;
    
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {       
        //刪除對應的陣列元素
        DatabaseHelper *helper = [DatabaseHelper new];
        NSString *selectCellText;
        NSString *bookID;
        
        //刪除對應的表格項目      
               
        if (tableView == [[self searchDisplayController] searchResultsTableView]) {
            selectCellText = [searchResults objectAtIndex:indexPath.row];
            bookID = [helper indexForTitle:selectCellText];            
            [helper deleteBookForIndex:bookID];            
            [searchResults removeObjectAtIndex:indexPath.row];            
            
            titles = [helper categories];
            
            [[[self searchDisplayController] searchResultsTableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
       
            [self.tableView reloadData];    // 重新載入資料
        }
        else {
            selectCellText = [titles objectAtIndex:indexPath.row];
            bookID = [helper indexForTitle:selectCellText];
            [helper deleteBookForIndex:bookID];
            [titles removeObjectAtIndex:indexPath.row];            
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
        }
         
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    [self performSegueWithIdentifier:@"ContentViewSegue" sender:nil];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    
}

@end
