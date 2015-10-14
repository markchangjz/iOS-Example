//
//  ShowView.m
//  TableView
//
//  Created by EE Lab on 12/7/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShowView.h"

@interface ShowView ()

@end

@implementation ShowView
@synthesize postData;
@synthesize iDisplay;

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
    iDisplay.text = self.postData;
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setIDisplay:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
