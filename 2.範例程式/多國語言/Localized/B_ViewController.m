//
//  B_ViewController.m
//  Localized
//
//  Created by JzChang on 13/1/18.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "B_ViewController.h"

@interface B_ViewController ()

@end

@implementation B_ViewController

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

	self.navigationItem.title = NSLocalizedString(@"畫面 B", @"View B");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
