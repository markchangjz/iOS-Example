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
@property (nonatomic) int hideMaster;
@property (strong, nonatomic) UIBarButtonItem *hideButton;
@property (strong, nonatomic) UIBarButtonItem *showButton;


@end

@implementation DetailVC

enum Master {
    hideMaster = 1,
    showMaster
};

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
    
    [self.view addSubview:self.showData];
    
    self.showData.center = self.view.center;
    
    self.showData.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                      UIViewAutoresizingFlexibleRightMargin |
                                      UIViewAutoresizingFlexibleTopMargin |
                                      UIViewAutoresizingFlexibleBottomMargin);
    
    // 設定 隱藏 & 顯示 Master
    self.hideButton = [[UIBarButtonItem alloc] initWithTitle:@"<"
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(hide_show:)];
    
    self.showButton = [[UIBarButtonItem alloc] initWithTitle:@">"
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(hide_show:)];
    
    self.navigationItem.leftBarButtonItem = self.hideButton;    
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    self.showData.center = self.view.center;
}

#pragma mark - Split View Controller delegate

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{  
    if (self.hideMaster == hideMaster) {
        return YES; // YES:隱藏
    }
    else if (self.hideMaster == showMaster){
        return NO;  // NO:顯示
    }
    else {
        return UIInterfaceOrientationIsPortrait(orientation);
    }    
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

-(void)hide_show:(UIBarButtonItem *)sender
{
    NSString *operator = [sender title];
    
    if ([operator isEqualToString:@"<"]) {
        self.hideMaster = hideMaster;
        [self.navigationItem setLeftBarButtonItem:self.showButton animated:YES];
    }
    else if ([operator isEqualToString:@">"]) {
        self.hideMaster = showMaster;
        [self.navigationItem setLeftBarButtonItem:self.hideButton animated:YES];
    }
        
    UISplitViewController *spv = self.splitViewController;    
    
    [spv.view setNeedsLayout];
    
    [spv willRotateToInterfaceOrientation:self.interfaceOrientation duration:0];    
}

#pragma mark - ShowDataDelegate

- (void)ShowDataAtDetailView:(NSString *)data
{
    self.showData.text = data;
}

@end
