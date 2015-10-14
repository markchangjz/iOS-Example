//
//  MasterVC.m
//  NSUserDefaults_iPad
//
//  Created by JzChang on 12/9/29.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "MasterVC.h"
#import "DetailVC.h"
#import "SplitViewBarButtonItemPresenter.h"

@interface MasterVC ()

@end

@implementation MasterVC

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 啓動後設定 Split View Controller 的 delegate !
    self.splitViewController.delegate = self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

// 設定按下Master View的按鈕後的動作
- (DetailVC *)getDetailVC
{
    id dvc = [self.splitViewController.viewControllers lastObject];
    if (![dvc isKindOfClass:[DetailVC class]]) {
        dvc = nil;        
    }
    return dvc;
}

- (IBAction)clickBtn:(UIButton *)sender
{
    [self getDetailVC].showData = sender.currentTitle;
}

#pragma mark - 設定 SplitViewController

- (BOOL)splitViewController:(UISplitViewController *)svc
   shouldHideViewController:(UIViewController *)vc
              inOrientation:(UIInterfaceOrientation)orientation
{
    // 回傳 YES 總是隱藏 MasterView, 回傳 NO 總是顯示 MasterView
    return UIInterfaceOrientationIsPortrait(orientation);
}

// 回傳資料型態 id <SplitViewBarButtonItemPresenter> 代表回傳的資料要實作 SplitViewBarButtonItemPresenter 的 protocol
- (id <SplitViewBarButtonItemPresenter>)splitViewBarButtonItemPresenter
{
    // 取得 Detail View (右邊)
    id detailVC = [self.splitViewController.viewControllers lastObject];
    
    // 如果 detailVC 沒有實作 SplitViewBarButtonItemPresenter 的 protocol 就設定成 nil
    if (![detailVC conformsToProtocol:@protocol(SplitViewBarButtonItemPresenter)]) {
        detailVC = nil;
    }
    
    return detailVC;
}

- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    // 畫面 | (垂直) => 隱藏MasterView後, 加入按鈕可以讓它在顯示出來
    barButtonItem.title = self.navigationItem.title; // 按鈕標題
    [[self splitViewBarButtonItemPresenter] setSplitViewBarButtonItem:barButtonItem];
}

- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // 畫面 - (水平) => 顯示MasterView後, 移除按鈕
    [[self splitViewBarButtonItemPresenter] setSplitViewBarButtonItem:nil];
}

@end
