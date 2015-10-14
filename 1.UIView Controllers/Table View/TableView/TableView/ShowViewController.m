//
//  ShowView.m
//  TableView
//
//  Created by EE Lab on 12/7/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShowViewController.h"

@implementation ShowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.iDisplay.text = self.postData;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
