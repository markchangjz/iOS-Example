//
//  DetailVC.m
//  Split
//
//  Created by JzChang on 13/1/19.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "DetailVC.h"

@interface DetailVC ()

@property (strong, nonatomic) UILabel *showData;
@property (strong, nonatomic) UIBarButtonItem *hideButton;
@property (strong, nonatomic) UIBarButtonItem *showButton;

@end

@implementation DetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
        self.navigationItem.title = @"顯示資料";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.showData = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    self.showData.backgroundColor = [UIColor grayColor];
    self.showData.font = [UIFont boldSystemFontOfSize:60];
    self.showData.textAlignment = NSTextAlignmentCenter;
    
    self.showData.center = self.view.center;
    
    self.showData.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                      UIViewAutoresizingFlexibleRightMargin |
                                      UIViewAutoresizingFlexibleTopMargin |
                                      UIViewAutoresizingFlexibleBottomMargin);
    
    [self.view addSubview:self.showData];
    
    // 設定 隱藏 & 顯示 Master    
    self.hideButton = [[UIBarButtonItem alloc] initWithTitle:@"<"
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(hide:)];
    
    self.showButton = [[UIBarButtonItem alloc] initWithTitle:@">"
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(show:)];
    
    self.navigationItem.leftBarButtonItem = self.hideButton;    
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    self.showData.center = self.view.center;
    
    if (self.navigationItem.leftBarButtonItem == self.showButton) {
        [self.navigationItem setLeftBarButtonItem:self.hideButton animated:YES];
    }
}

#pragma mark - Split View Controller delegate

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return UIInterfaceOrientationIsPortrait(orientation);
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = @"選單";
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:self.hideButton animated:YES];
}

#pragma mark - selector

- (void)hide:(id)sender
{
    __block CGRect selfFrame = self.splitViewController.view.frame;
    
    UIViewController *masterController = [[self.splitViewController.viewControllers objectAtIndex:0] topViewController];
    CGFloat aWidth = masterController.view.frame.size.width; // 取得 Master View 的寬度
    
    UIDeviceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation]; // 取得目前螢幕方向
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         if(orientation == UIDeviceOrientationLandscapeLeft) {
                             selfFrame.size.height += aWidth;
                             selfFrame.origin.y -= aWidth;
                         }
                         else if(orientation == UIDeviceOrientationLandscapeRight) {
                             selfFrame.size.height += aWidth;
                         }
                         
                         [self.splitViewController.view setFrame:selfFrame];                         
                     }
                     completion:nil];
    
    [self.navigationItem setLeftBarButtonItem:self.showButton animated:YES];
}

- (void)show:(id)sender
{
    __block CGRect selfFrame = self.splitViewController.view.frame;
    
    UIViewController *masterController = [[self.splitViewController.viewControllers objectAtIndex:0] topViewController];
    CGFloat aWidth = masterController.view.frame.size.width; // 取得 Master View 的寬度
    
    UIDeviceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation]; // 取得目前螢幕方向
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationCurveEaseInOut
                     animations:^{
                         if(orientation == UIDeviceOrientationLandscapeLeft) {
                             selfFrame.size.height -= aWidth;
                             selfFrame.origin.y += aWidth;
                         }
                         else if(orientation == UIDeviceOrientationLandscapeRight) {
                             selfFrame.size.height -= aWidth;
                         }
                                                  
                         [self.splitViewController.view setFrame:selfFrame];                         
                     }
                     completion:nil];
    
    [self.navigationItem setLeftBarButtonItem:self.hideButton animated:YES];
}

#pragma mark - ShowDataDelegate

- (void)ShowDataAtDetailView:(NSString *)data
{
    self.showData.text = data;
}

@end
