//
//  MovieViewController.m
//  NavigationController
//
//  Created by JzChang on 12/9/28.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "MovieViewController.h"
#import "ResultViewController.h"

@interface MovieViewController ()

@property (strong, nonatomic) ResultViewController *childController;

@end

@implementation MovieViewController

@synthesize movieList;
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
    
    self.navigationItem.prompt = @"Movie List";
    
    // 設定 RightBarButtonItem =====================================================================    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"A", @"B"]];
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.momentary = YES;
    UIBarButtonItem *segmentBarItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    self.navigationItem.rightBarButtonItem = segmentBarItem;    

    // 設定 toolbar ================================================================================
    NSArray *itemArray = @[@"Movie 1", @"Movie 2", @"Movie 2"];
    UISegmentedControl *mySegment = [[UISegmentedControl alloc] initWithItems:itemArray];
    mySegment.segmentedControlStyle = UISegmentedControlStyleBar;
    mySegment.frame = CGRectMake(0, 0, 250, mySegment.frame.size.height);
    mySegment.selectedSegmentIndex = 1;
    
    [mySegment addTarget:self action:@selector(changeSegment:) forControlEvents:UIControlEventValueChanged];
    
    // 將 UISegmentedControl 封裝為 UIBarButtonItem
    UIBarButtonItem *segmentBtn = [[UIBarButtonItem alloc] initWithCustomView:mySegment];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    self.toolbarItems = @[flexibleSpace, segmentBtn, flexibleSpace];
    
    // 設定 tableView 資料 =========================================================================    
    NSArray *array = [[NSArray alloc] initWithObjects:@"肖申克的救贖", @"教父", @"教父：II",
                      @"低俗小說", @"黃金三鏢客", @"十二怒漢", @"辛德勒名單",
                      @"蝙蝠俠前傳2：黑闇騎士", @"指環王：王者歸來", @"飛越瘋人院",
                      @"星球大戰Ⅴ：帝國反擊戰", @"搏擊俱樂部", @"盜夢空間", @"七武士",
                      @"指環王：護戒使者", @"好傢伙", @"星球大戰IV：新希望", @"上帝之城",
                      @"卡薩布蘭卡", @"黑客帝國", @"西部往事", @"後窗", @"奪寶奇兵",
                      @"沉默的羔羊", @"非常嫌疑犯", @"七宗罪", @"指環王：雙塔奇兵", @"阿甘正傳",
                      @"驚魂記", @"美好人生", nil];
    
    self.movieList = array;
}

- (void)viewDidUnload
{
    self.movieList = nil;
    self.childController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - selector

- (void)segmentAction:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            NSLog(@"A");
            break;
        case 1:
            NSLog(@"B");
            break;
    }
}

- (void)changeSegment:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0: // Movie 1
            NSLog(@"Movie 1");
            break;
        case 1: // Movie 2
            NSLog(@"Movie 2");
            break;
        case 2: // Movie 3
            NSLog(@"Movie 3");
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [movieList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MovieTableViewCell = @"MovieTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MovieTableViewCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: MovieTableViewCell];
    }
    
    NSString *movieTitle = [movieList objectAtIndex:indexPath.row];
    //這裡設置每一行顯示的文本為所對應的View Controller的標題
    cell.textLabel.text = movieTitle;
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
    
    NSString *selectedMovie = [movieList objectAtIndex:indexPath.row];
    NSString *detailMessage = [[NSString alloc] initWithFormat:@"你選擇了電影：%@.", selectedMovie];
    childController.message = detailMessage;
    childController.title = selectedMovie;
    [self.navigationController pushViewController:childController animated:YES];
}

@end
