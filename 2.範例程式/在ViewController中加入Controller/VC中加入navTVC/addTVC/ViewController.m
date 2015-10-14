//
//  ViewController.m
//  addTVC
//
//  Created by JzChang on 13/3/5.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "ViewController.h"
#import "TVC.h"

@interface ViewController () {
    UITableViewController *currentViewController;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    TVC *tvc = [[TVC alloc] initWithStyle:UITableViewStylePlain];
    tvc.navigationItem.title = @"Title";
    
    UINavigationController *navTVC = [[UINavigationController alloc] initWithRootViewController:tvc];
    navTVC.view.frame = CGRectMake(0, 0, 300, 400);
//    [navTVC.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self addChildViewController:navTVC];
    [self.contentView addSubview:navTVC.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
