//
//  ResultViewController.m
//  NavigationController
//
//  Created by JzChang on 12/9/28.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController
@synthesize detailLabel, message;

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
        
    // 設定 toolbar ================================================================================    
    UIBarButtonItem *homeBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(backToRootView)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.toolbarItems = @[flexibleSpace, homeBtn, flexibleSpace];   
}

- (void)viewWillAppear:(BOOL)animated
{
    detailLabel.text = message;
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
    [self setDetailLabel:nil];
    [super viewDidUnload];
 
    self.detailLabel = nil;
    self.message = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - selector

- (void)backToRootView
{
    // 返回到 Root View
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
