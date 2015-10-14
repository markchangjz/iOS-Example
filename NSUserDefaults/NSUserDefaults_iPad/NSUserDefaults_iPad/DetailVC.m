//
//  DetailVC.m
//  NSUserDefaults_iPad
//
//  Created by JzChang on 12/9/29.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "DetailVC.h"
#import "showDataTVC.h"
#import "NSUserDefaults_KEY.h"

@interface DetailVC () <showDataTVCDelegate>

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) UIPopoverController *showPopover;
// UIPopoverController 幾乎是 strong, 所有顯示的東西都不會有 strong 指向你的 Popover Controller

@end

@implementation DetailVC

@synthesize toolBar = _toolBar;
@synthesize showData = _showData;
@synthesize showDataLbl = _showDataLbl;
@synthesize splitViewBarButtonItem = _splitViewBarButtonItem;
@synthesize showPopover = _showPopover;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Setter

- (void)setSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem
{
    if (_splitViewBarButtonItem != splitViewBarButtonItem) {
        NSMutableArray *toolbarItems = [self.toolBar.items mutableCopy];
        
        if (_splitViewBarButtonItem) {
            [toolbarItems removeObject:_splitViewBarButtonItem];
        }
        if (splitViewBarButtonItem) {
            [toolbarItems insertObject:splitViewBarButtonItem atIndex:0]; // 放到第一個位置
        }
        
        self.toolBar.items = toolbarItems;
        _splitViewBarButtonItem = splitViewBarButtonItem;
    }
}

- (void)setShowData:(NSString *)showData
{
    _showData = showData;
    self.showDataLbl.text = showData; // 在設定資料時顯示資料
}

#pragma mark - IBAction

// 點選儲存資料
- (IBAction)clickSaveData:(UIButton *)sender
{    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favorites = [[defaults objectForKey:STORE_KEY] mutableCopy];

    if (!favorites) {
        favorites = [NSMutableArray array];
    }
    
    [favorites addObject:self.showDataLbl.text];
    [defaults setObject:favorites forKey:STORE_KEY];
    [defaults synchronize];    
}

// 清除所有紀錄的資料
- (IBAction)clickCleanData:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:STORE_KEY];
}

// 顯示目前儲存的資料, 使用 Table View
- (IBAction)clickShowSavedData:(UIBarButtonItem *)sender
{
    // showPopover 目前是否已經顯示
    if (!self.showPopover.isPopoverVisible) {
        showDataTVC *show = [[showDataTVC alloc] init];
        show.storeData = [[[NSUserDefaults standardUserDefaults] objectForKey:STORE_KEY] mutableCopy];
        
        // 設定 Table View 的 delegate !
        show.delegate = self; 
        
        // 1. 設定要放到 popover 的 View Controller
        self.showPopover = [[UIPopoverController alloc] initWithContentViewController:show];
        
        // 2. 設定 popover 顯示的大小
        [self.showPopover setPopoverContentSize:CGSizeMake(200, 250)];
        // 或是在步驟1.前 show.contentSizeForViewInPopover = CGSizeMake(200, 250);
        
        // 3. 顯示 popover
        [self.showPopover presentPopoverFromBarButtonItem:sender
                                 permittedArrowDirections:UIPopoverArrowDirectionAny
                                                 animated:YES];
    }
    else {
        // 關閉 popover
        [self.showPopover dismissPopoverAnimated:YES]; 
    }
}

#pragma mark - Protocol

// 實作點選 Table View 中的 Protocol
- (void)showDataProtocol:(showDataTVC *)sender choseData:(id)data
{
    self.showDataLbl.text = data;
}

@end
