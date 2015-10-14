//
//  MainTableViewController.m
//  RSS Reader
//
//  Created by JzChang on 13/2/26.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

/*
 點選 UIModalPresentationFormSheet 以外的畫面 dismissViewController
 http://stackoverflow.com/questions/4946767/how-to-dismiss-a-modal-view-controller-presented-as-form-sheet-when-a-touch-oc
 http://stackoverflow.com/questions/10104706/present-modal-form-sheet-over-modal-page-sheet
 
 */

#import "MainTableViewController.h"
#import "RSSParser.h"
#import "WebViewController.h"

@interface MainTableViewController () <RSSdelegate> {
    NSArray *result;
    NSXMLParser *parser;
    NSString *parserString; // 需要parser的URL
    RSSParser *rssParser;
}

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

@implementation MainTableViewController

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
    
    // 設定 Navigation Controller Style
    [self.navigationController.toolbar setBarStyle:UIBarStyleBlackOpaque];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    
    // 設定表格下拉更新
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshRSS) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    // 設定 toolbar 按鈕
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"科      技", @"財      經", @"運      動", @"天      氣", @"健      康"]];
    [self.segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self.segmentedControl setSelectedSegmentIndex:0];
    [self.segmentedControl setSegmentedControlStyle:UISegmentedControlStyleBar];
    [self.segmentedControl setFrame:CGRectMake(0, 0, 700, self.segmentedControl.frame.size.height)];
    [[self.segmentedControl.subviews objectAtIndex:0] setTintColor:[UIColor colorWithRed:0.078 green:0.682 blue:0.851 alpha:1.0]];

    
    UIBarButtonItem *segmentBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.segmentedControl];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.toolbarItems = @[flexibleSpace, segmentBarItem, flexibleSpace];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationItem.title = @"Yahoo!奇摩新聞";
    
    parserString = @"http://tw.news.yahoo.com/rss/technology";     
    [self parserRSS:parserString];
}

- (void)updateTable
{
    // 重載 tableView 資料
    [UIView transitionWithView:self.tableView
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^{
                        [self.tableView reloadData];
                    }
                    completion: ^(BOOL finished) {
                        // 停止 indicator 轉動
                        [self.refreshControl endRefreshing];                        
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    }];
}

- (void)xmlParserEnd
{
    // XML Parser 結束(parserDidEndDocument:)後觸發
    result = [[NSArray alloc] initWithArray:rssParser.result];
    
    [self updateTable];
}

#pragma mark - selector

- (void)refreshRSS
{
    // 下拉更新執行動作
    [self parserRSS:parserString];
}

- (void)tappedOutsideView:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)parserRSS:(NSString *)urlString
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    rssParser = [[RSSParser alloc] init];
    rssParser.delegate = self;   
  
    [rssParser initParserURL:urlString];
}

- (void)segmentAction:(UISegmentedControl *)sender
{    
    // 設定 Segment 所選擇的顏色
    for (int i = 0; i < [self.segmentedControl.subviews count]; i++) {
        [[self.segmentedControl.subviews objectAtIndex:i] setTintColor:nil];
        if ([[self.segmentedControl.subviews objectAtIndex:i] isSelected]) {
            // 設定選擇的顏色
            [[self.segmentedControl.subviews objectAtIndex:i] setTintColor:[UIColor colorWithRed:0.078 green:0.682 blue:0.851 alpha:1.0]];
        }
        else {
            // 設定回原本的顏色
            //[[self.videoTypeSegment.subviews objectAtIndex:i] setTintColor:[UIColor grayColor]];
        }
    }   
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            parserString = @"http://tw.news.yahoo.com/rss/technology";
            break;
        case 1:
            parserString = @"http://tw.news.yahoo.com/rss/finance";
            break;
        case 2:
            parserString = @"http://tw.news.yahoo.com/rss/sports";
            break;
        case 3:
            parserString = @"http://tw.news.yahoo.com/rss/weather";
            break;
        case 4:
            parserString = @"http://tw.news.yahoo.com/rss/health";
            break;
    }
    
    [self performSelector:@selector(parserRSS:) withObject:parserString afterDelay:0.1];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return result.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"Cell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    
    NSDictionary *item = [result objectAtIndex:indexPath.row];
    cell.textLabel.text = [item objectForKey:@"title"];
    cell.detailTextLabel.text = [item objectForKey:@"pubDate"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    WebViewController *wvc = [[WebViewController alloc] init];
    
    wvc.showWebURL = [[result objectAtIndex:indexPath.row] objectForKey:@"link"];
    
    [wvc setModalPresentationStyle:UIModalPresentationFormSheet];
    [wvc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        
    [self presentViewController:wvc animated:YES completion:nil];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOutsideView:)];
    [tapGesture setNumberOfTapsRequired:1];
    [tapGesture setNumberOfTapsRequired:1];
    
    UIView *dimmingView = [self.view.window.subviews objectAtIndex:1];
    [dimmingView addGestureRecognizer:tapGesture];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 設定 Cell 顏色
    cell.backgroundColor = (indexPath.row % 2) ? [UIColor whiteColor] : [UIColor colorWithRed:0.9 green:0.95 blue:1.0 alpha:1.0];
}

@end
