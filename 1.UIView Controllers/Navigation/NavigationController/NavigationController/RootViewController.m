//
//  RootViewController.m
//  NavigationController
//
//  Created by JzChang on 12/9/28.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "RootViewController.h"
#import "MovieViewController.h"
#import "SongViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

@synthesize controllerList;

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
        
    // 設定 toolbar ================================================================================   
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(clickBtn1)];
    btn1.style = UIBarButtonItemStyleBordered;
    UIBarButtonItem *btn2 = [[UIBarButtonItem alloc] initWithTitle:@"按鈕2" style:UIBarButtonItemStylePlain target:self action:@selector(clickBtn2)];
    UIBarButtonItem *btn3 = [[UIBarButtonItem alloc] initWithTitle:@"按鈕3" style:UIBarButtonItemStyleBordered target:self action:@selector(clickBtn3)];
   
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 50;
    
    // 設定 toolbar 按鈕
    self.toolbarItems = @[btn1, flexibleSpace, btn2, fixedSpace, btn3];                                   
    
    // 設定 tableView 資料 ==========================================================================    
    self.navigationItem.title = @"分類";
    NSMutableArray *VC_array = [[NSMutableArray alloc] init];
    
    // 1.電影
    MovieViewController *movieViewController = [[MovieViewController alloc] initWithStyle:UITableViewStylePlain];
    movieViewController.navigationItem.title = @"電影";
    [VC_array addObject:movieViewController];
    
    // 2.音樂
    SongViewController *songViewController = [[SongViewController alloc] initWithStyle:UITableViewStylePlain];
    songViewController.navigationItem.title = @"音樂";
    [VC_array addObject:songViewController];
    
    self.controllerList = VC_array;
}

- (void)viewDidUnload
{
    self.controllerList = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - selector

- (void)clickBtn1
{
    NSLog(@"clickBtn1");
}

- (void)clickBtn2
{
    NSLog(@"clickBtn2");
}

- (void)clickBtn3
{
    NSLog(@"clickBtn3");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [controllerList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RootTableViewCell = @"RootTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RootTableViewCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RootTableViewCell];
    }
    
    UITableViewController *controller = [controllerList objectAtIndex:indexPath.row];
    //這裡設置每一行顯示的文本為所對應的View Controller的標題
    cell.textLabel.text = controller.navigationItem.title;
    //accessoryType就表示每行右邊的圖標
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewController *nextController = [self.controllerList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:nextController animated:YES];
}

@end
