//
//  DetailVC.m
//  Split
//
//  Created by JzChang on 13/1/19.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "DetailVC.h"
#import "MasterTVC.h"

@interface DetailVC () <ShowDataDelegate>

@property (strong, nonatomic) UILabel *showData;
@property (strong, nonatomic) UIToolbar *toolBar;
@property (strong, nonatomic) UIBarButtonItem *segmentItem, *flexibleSpace, *fixedSpace;
@property (strong, nonatomic) UISegmentedControl *segment; // 上一個 ｜ 下一個

@end

@implementation DetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    // 設定 dataSource (delegate) 存取 Master View 資料
    self.dataSource = (id)[[self.splitViewController.viewControllers objectAtIndex:0] topViewController];

    self.showData = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    self.showData.backgroundColor = [UIColor grayColor];
    self.showData.font = [UIFont boldSystemFontOfSize:60];
    self.showData.textAlignment = NSTextAlignmentCenter;
    
    self.showData.center = self.view.center;
    
    self.showData.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin  |
                                      UIViewAutoresizingFlexibleRightMargin |
                                      UIViewAutoresizingFlexibleTopMargin   |
                                      UIViewAutoresizingFlexibleBottomMargin);
    
    [self.view addSubview:self.showData];
    
    // 設定 tool bar
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"上 一 個", @"下 一 個"]];
    self.segment.segmentedControlStyle = UISegmentedControlStyleBar;
    self.segment.momentary = YES;
    
    [self.segment addTarget:self action:@selector(changedSegment:) forControlEvents:UIControlEventValueChanged];
    self.segmentItem = [[UIBarButtonItem alloc] initWithCustomView:self.segment];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(clickItem1)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(clickItem2)];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(clickItem3)];
        
    [self.toolBar setItems:@[self.flexibleSpace, item1, self.fixedSpace, item2, self.fixedSpace, item3, self.fixedSpace] animated:YES];
    
    [self.view addSubview:self.toolBar];
}

#pragma mark - lazy instantiation

- (UIToolbar *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        _toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return _toolBar;
}

- (UIBarButtonItem *)flexibleSpace
{
    if (!_flexibleSpace) {
        _flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    }
    return _flexibleSpace;
}

- (UIBarButtonItem *)fixedSpace
{
    if (!_fixedSpace) {
        _fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        _fixedSpace.width = 10;
    }
    return _fixedSpace;
}

#pragma mark - selector

- (void)changedSegment:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            if ([self.dataSource conformsToProtocol:@protocol(DetailDataSource)]) {
                [self.dataSource getMasterData:@"-"];
            }
            break;
        case 1:
            if ([self.dataSource conformsToProtocol:@protocol(DetailDataSource)]) {
                [self.dataSource getMasterData:@"+"];
            }
            break;
    }
}

- (void)clickItem1
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)clickItem2
{
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)clickItem3
{
    self.view.backgroundColor = [UIColor redColor];
}

#pragma mark - Split View Controller delegate

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return UIInterfaceOrientationIsPortrait(orientation);
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = @"選 單";

    NSMutableArray *toolBarItems = [self.toolBar.items mutableCopy];
    
    // 新增 ToolBar Item
    [toolBarItems insertObject:barButtonItem atIndex:0];
    [toolBarItems insertObject:self.segmentItem atIndex:1];
    
    self.toolBar.items = toolBarItems;   
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    NSMutableArray *toolBarItems = [self.toolBar.items mutableCopy];
    
    // 刪除 ToolBar Item
    [toolBarItems removeObject:barButtonItem];
    [toolBarItems removeObject:self.segmentItem];
    
    self.toolBar.items = toolBarItems;
}

#pragma mark - MasterTVC - ShowDataDelegate

- (void)ShowDataAtDetailView:(NSString *)data
{
    self.showData.text = data;
}

- (void)SegmentDisable:(NSUInteger)index
{
    // 關閉 segment 第 index 個按鈕失效
    [self.segment setEnabled:NO forSegmentAtIndex:index];
}

- (void)SegmentEnble:(NSUInteger)index
{
    // 開啟 segment 第 index 個按鈕作用
    [self.segment setEnabled:YES forSegmentAtIndex:index];
}

@end
