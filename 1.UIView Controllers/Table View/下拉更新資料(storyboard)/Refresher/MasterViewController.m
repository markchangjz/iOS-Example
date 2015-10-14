//
//  MasterViewController.m
//  Refresher
//
//  Created by JzChang on 13/2/16.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

/*
 TableView Pull-to-Refresh
 參考網址:http://www.lextech.com/2012/10/ios-6-pull-to-refresh-tutorial/
 
 Alert View 加上 TextField
 參考網址:http://mobile.tutsplus.com/tutorials/iphone/ios-5-sdk-uialertview-text-input-and-validation/
 
 移動 Cell
 參考網址:http://furnacedigital.blogspot.tw/2012/02/uitableview_13.html
 */

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () <UIAlertViewDelegate> {
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
}

@property (strong, nonatomic) NSArray *objects, *filteredArray;
@property (assign, nonatomic) BOOL ascending;

@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 設定表格下拉更新
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor magentaColor];
    [refreshControl addTarget:self action:@selector(changeSorting) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    //self.navigationItem.rightBarButtonItem = self.editButtonItem; // 可直接用 self.editButtonItem 就不用實作 enterEditMode leaveEditMode

    [self setBarButtonItems];
    
    // 設定搜尋    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    [searchBar sizeToFit];
    self.tableView.tableHeaderView = searchBar;
    
    // searchDisplayController 必須是全域變數 !
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    // 當 Cell 資料比螢幕多時把 searchBar 隱藏
//    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
//}

- (void)setBarButtonItems
{
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    UIBarButtonItem *editBtn = [[UIBarButtonItem alloc] initWithTitle:@"編輯" style:UIBarButtonItemStyleBordered target:self action:@selector(enterEditMode)];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(leaveEditMode)];
    
    self.navigationItem.leftBarButtonItem = addBtn;
    self.navigationItem.rightBarButtonItem = self.tableView.isEditing ? doneBtn : editBtn;
}

- (void)enterEditMode
{
    // 進入編輯模式
    [self.tableView setEditing:YES animated:YES];
    [self setBarButtonItems];
}

- (void)leaveEditMode
{
    // 離開編輯模式
    [self.tableView setEditing:NO animated:YES];
    [self setBarButtonItems];
}

- (void)addItem
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"新增項目"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"新增", nil];
    
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput]; // 設定 Alert View 顯示一個 TextField
    [alertView show];
}

- (void)changeSorting
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:nil ascending:self.ascending];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    self.objects = [self.objects sortedArrayUsingDescriptors:sortDescriptors];
    
    self.ascending = !self.ascending;
    
    [self performSelector:@selector(updateTable) withObject:nil afterDelay:1];
}

- (void)updateTable
{
    [self.tableView reloadData];    
    
    [self.refreshControl endRefreshing]; // 停止 indicator 轉動 
}

- (void)storeCell
{
    // 儲存 Cell 資料
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.objects forKey:@"STORE_KEY"];
    [defaults synchronize];
}

#pragma mark - lazy instantiation

- (NSArray *)objects
{
    if (!_objects) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if ([defaults objectForKey:@"STORE_KEY"]) {
            // 如果有新增, 刪除, 調整 Cell 順序, 就使用調整後的順序
            _objects = [defaults objectForKey:@"STORE_KEY"];
        }
        else {
            _objects = @[@"Argentina", @"Australia", @"Brazil", @"Ecuador", @"England", @"Germany", @"Italy", @"Japan", @"New Zealand", @"United States"];
        }
    }
    
    return _objects;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger rows = 0;
    
    if (tableView == self.tableView) {
        rows = self.objects.count;
    }
    else if (tableView == self.searchDisplayController.searchResultsTableView) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchBar.text];
        self.filteredArray = [self.objects filteredArrayUsingPredicate:predicate];
        rows = self.filteredArray.count;
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (tableView == self.tableView) {
        cell.textLabel.text = [self.objects objectAtIndex:indexPath.row];
    }
    else if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [self.filteredArray objectAtIndex:[indexPath row]];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 判斷編輯表格的類型為「刪除」
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (tableView == self.tableView) {
            // 刪除對應的陣列元素
            NSMutableArray *mObjects = [self.objects mutableCopy];
            [mObjects removeObjectAtIndex:indexPath.row];
            self.objects = [mObjects copy];
        }
        else if (tableView == self.searchDisplayController.searchResultsTableView) {
            /*
             self.tableView 和 self.searchDisplayController.searchResultsTableView 兩邊資料都要一起刪除
             否則 self.searchDisplayController.searchResultsTableView 在刪除 Cell 會有錯誤
             */
        
            NSMutableArray *mObjects = [self.objects mutableCopy];
            NSMutableArray *mFilteredArray = [self.filteredArray mutableCopy];
            
            [mObjects removeObject:[mFilteredArray objectAtIndex:indexPath.row]];
            [mFilteredArray removeObjectAtIndex:indexPath.row];
            
            self.objects = [mObjects copy];
            self.filteredArray = [mFilteredArray copy];
            
            // 刪除 searchResultsTableView 的 Cell 後要重載 self.tableView 否則資料還是舊的
            [self.tableView reloadData];
        }
        
        // 刪除後儲存資料
        [self storeCell];
        
        // 刪除對應的表格項目
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 開啟表格項目的移動功能
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 調整移動後的資料
    NSString *item = [self.objects objectAtIndex:sourceIndexPath.row];
    
    NSMutableArray *mObjects = [self.objects mutableCopy];

    [mObjects removeObjectAtIndex:sourceIndexPath.row];
    [mObjects insertObject:item atIndex:destinationIndexPath.row];
        
    self.objects = [mObjects copy];
    
    // 調整順序後儲存資料    
    [self storeCell];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetail" sender:nil];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = (indexPath.row % 2) ? [UIColor whiteColor] : [UIColor colorWithRed:0.9 green:0.95 blue:1.0 alpha:1.0];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
            NSLog(@"新增 %@", [[alertView textFieldAtIndex:0] text]);
            
            // 新增在 Alert View 上所輸入的字串
            NSMutableArray *mObjects = [self.objects mutableCopy];
            [mObjects addObject:[[alertView textFieldAtIndex:0] text]];
            self.objects = [mObjects copy];
            
            self.objects = [self.objects sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:nil ascending:!self.ascending]]];
            
            // 新增資料後儲存資料
            [self storeCell];
            
            [self.tableView reloadData];
            
            break;
    }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    NSString *inputText = [[alertView textFieldAtIndex:0] text];
    
    // 確保有輸入資料
    if(inputText.length > 0) {
        return YES;
    }
    else {
        return NO;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath;
        NSString *selectItem;
        
        if (self.searchDisplayController.searchResultsTableView.frame.size.height > 0) {
            indexPath = self.searchDisplayController.searchResultsTableView.indexPathForSelectedRow;
            selectItem = [self.filteredArray objectAtIndex:indexPath.row];
        }
        else {
            indexPath = self.tableView.indexPathForSelectedRow;
            selectItem = [self.objects objectAtIndex:indexPath.row];
        }
        
        [[segue destinationViewController] setDetailItem:selectItem];
    }
}

@end
