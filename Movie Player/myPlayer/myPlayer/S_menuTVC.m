//
//  S_menuTVC.m
//  myPlayer
//
//  Created by JzChang on 13/1/5.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "S_menuTVC.h"
#import "S_select_ipTVP.h"

@interface S_menuTVC () <selectIPDelegate> {
    NSMutableArray *video1, *video2, *video1_Title, *video2_Title;
}

@property (strong, nonatomic) NSOrderedSet *tableViewSection;
@property (strong, nonatomic) NSMutableDictionary *ipToVideo;
@property (strong, nonatomic) NSString *selectedIP;
@property (strong, nonatomic) NSString *selectedMovie;

@end

@implementation S_menuTVC

NSIndexPath *checkedCell; // 設定 Checkmark
UIBarButtonItem *cancelBtn;
UIBarButtonItem *finishBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableViewSection = [[NSOrderedSet alloc] initWithObjects:@"網路位址", @"影片", nil];
    
    self.ipToVideo = [[NSMutableDictionary alloc] init];
    video1 = [[NSMutableArray alloc] initWithArray:@[@"/HLS/101/101.mp4", @"/HLS/101/variant.m3u8", @"/HLS/101/low/low-list_file.m3u8", @"/HLS/101/med/med-list_file.m3u8", @"/HLS/101/high/high-list_file.m3u8", @"/HLS/Wildlife/Wildlife.mp4", @"/HLS/Wildlife/variant.m3u8", @"/HLS/Wildlife/low/prog_index.m3u8", @"/HLS/Wildlife/med/prog_index.m3u8", @"/HLS/Wildlife/high/prog_index.m3u8"]];
    video1_Title = [[NSMutableArray alloc] initWithArray:@[@"MP4 A", @"自動A", @"低品質A", @"中品質A", @"高品質A",@"MP4 B", @"自動B", @"低品質B", @"中品質B", @"高品質B"]];
    
    video2 = [[NSMutableArray alloc] initWithArray:@[@"/HLS/101/101.mp4", @"/HLS/101/variant.m3u8", @"/HLS/101/low/low-list_file.m3u8", @"/HLS/101/med/med-list_file.m3u8", @"/HLS/101/high/high-list_file.m3u8", @"/HLS/Wildlife/Wildlife.mp4", @"/HLS/Wildlife/variant.m3u8", @"/HLS/Wildlife/low/prog_index.m3u8", @"/HLS/Wildlife/med/prog_index.m3u8", @"/HLS/Wildlife/high/prog_index.m3u8"]];
    video2_Title = [[NSMutableArray alloc] initWithArray:@[@"MP4 A", @"自動A", @"低品質A", @"中品質A", @"高品質A",@"MP4 B", @"自動B", @"低品質B", @"中品質B", @"高品質B"]];

//    video2 = [[NSMutableArray alloc] initWithArray:@[@"/m3u8/app/app.m3u8", @"/m3u8/hls/hls.m3u8", @"/m3u8/test_file/test_file.m3u8", @"/outputSegment/variant.m3u8"]];
    
    
    [self.ipToVideo setObject:@[video1, video1_Title] forKey:@"http://192.168.0.103"];
    [self.ipToVideo setObject:@[video2, video2_Title] forKey:@"http://140.118.7.9"];
    
    [self setupView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

#pragma mark - code

- (void)setupView
{
    self.navigationItem.title = @"網路串流";
    
    cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                 style:UIBarButtonItemStylePlain
                                                target:self
                                                action:@selector(clickCnacel)];
    
    finishBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                 style:UIBarButtonItemStyleDone
                                                target:self
                                                action:@selector(clickFinish)];    
    
    self.navigationItem.leftBarButtonItem = cancelBtn;
    self.navigationItem.rightBarButtonItem = finishBtn;
    
    self.tableView.rowHeight = 60; // 設定 Table View 每個 Cell 的高度
}

#pragma mark - selector

- (void)clickCnacel
{
    [self.delegate didDismissModalView];
}

- (void)clickFinish
{
    if (!self.selectedMovie) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                            message:@"尚未選擇影片"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"好", nil];
        [alertView show];
    }
    else {
        NSString *urlPath = [self.selectedIP stringByAppendingString:self.selectedMovie];
        [self.delegate playURL:[NSURL URLWithString:urlPath]];
        [self.delegate setViewTitle:urlPath];
        [self.delegate didDismissModalView];
    }   
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.tableViewSection count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.tableViewSection objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else {
        if (self.selectedIP) {
            return [[[self.ipToVideo objectForKey:self.selectedIP] objectAtIndex:0] count];
        }
        else {
            return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil]; // 要修正成自己 alloc init
    
    // Configure the cell...
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;        
        cell.detailTextLabel.text = self.selectedIP ? self.selectedIP : @"請選擇網路位址";
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    else if (self.selectedIP) {
        cell.textLabel.text = [[[self.ipToVideo objectForKey:self.selectedIP] objectAtIndex:1] objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.detailTextLabel.text = [[[self.ipToVideo objectForKey:self.selectedIP] objectAtIndex:0] objectAtIndex:indexPath.row];
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:18];
        
        // 設定 Checkmark  
        if (checkedCell != nil && checkedCell.row == indexPath.row && checkedCell.section == indexPath.section) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        S_select_ipTVP *s_select_ipTVP = [[S_select_ipTVP alloc] initWithStyle:UITableViewStyleGrouped];
        s_select_ipTVP.delegate = self;
        [self.navigationController pushViewController:s_select_ipTVP animated:YES];
    }
    else {
        // 設定 Checkmark
        UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        
        // 對於 checkedCell.section == 0 && checkedCell.row == 0 不作用
        if (checkedCell != nil && !(checkedCell.section == 0 && checkedCell.row == 0)) { // Uncheck previously selected cell
            UITableViewCell *prevSelectedCell = [tableView cellForRowAtIndexPath:checkedCell];           
            prevSelectedCell.accessoryType = UITableViewCellAccessoryNone;           
        }
        
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        checkedCell = indexPath;
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        self.selectedMovie = [[[self.ipToVideo objectForKey:self.selectedIP] objectAtIndex:0] objectAtIndex:indexPath.row];
    }
}

#pragma mark - selectIPDelegate

- (void)selectIP:(S_select_ipTVP *)sender withIP:(NSString *)ipAddress
{
    self.selectedIP = ipAddress;
    [self.tableView reloadData];
}

@end
