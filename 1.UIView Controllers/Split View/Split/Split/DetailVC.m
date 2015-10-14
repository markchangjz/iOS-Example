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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"顯示資料";
    self.view.backgroundColor = [UIColor whiteColor];
    
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
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    self.showData.center = self.view.center;
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
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
}

#pragma mark - ShowDataDelegate

- (void)ShowDataAtDetailView:(NSString *)data
{
    self.showData.text = data;
}

@end
