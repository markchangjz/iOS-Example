//
//  SongViewController.m
//  NavigationController
//
//  Created by JzChang on 12/9/28.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "SongViewController.h"
#import "ResultViewController.h"

@interface SongViewController ()

@property (strong, nonatomic) ResultViewController *childController;

@end

@implementation SongViewController

@synthesize songList;
@synthesize childController;

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
    
    self.navigationItem.prompt = @"Song List";
    
    // 設定 toolbar ================================================================================
    UILabel *lbl = [[UILabel alloc] init];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.text = @"我的音樂";
    [lbl sizeToFit];
    
    UIBarButtonItem *myLabelBtn = [[UIBarButtonItem alloc] initWithCustomView:lbl];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    self.toolbarItems = @[flexibleSpace, myLabelBtn, flexibleSpace];

    // 設定 tableView 資料 =========================================================================    
    NSArray *array = [[NSArray alloc] initWithObjects:@"A song", @"B song", @"C song", nil];
    self.songList = array;
}

- (void)viewDidUnload
{
    self.songList = nil;
    self.childController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [songList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SongTableViewCell = @"SongTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SongTableViewCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: SongTableViewCell];
    }
    
    NSString *songTitle = [songList objectAtIndex:indexPath.row];
    //這裡設置每一行顯示的文本為所對應的View Controller的標題
    cell.textLabel.text = songTitle;
    //accessoryType就表示每行右邊的圖標
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消選擇
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (childController == nil) {
        childController = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
    }
    
    NSString *selectedSong = [songList objectAtIndex:indexPath.row];
    NSString *detailMessage = [[NSString alloc] initWithFormat:@"你選擇了音樂：%@.", selectedSong];
    childController.message = detailMessage;
    childController.title = selectedSong;
    [self.navigationController pushViewController:childController animated:YES];
}

@end
