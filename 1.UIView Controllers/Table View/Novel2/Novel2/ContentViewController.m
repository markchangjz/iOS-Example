//
//  ContentViewController.m
//  Novel2
//
//  Created by EE Lab on 12/7/4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ContentViewController.h"
#import "DatabaseHelper.h"

@interface ContentViewController ()

@end

@implementation ContentViewController
@synthesize myScrollView;
@synthesize myTextView;
@synthesize bookID;
@synthesize bookTitle;

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
	// Do any additional setup after loading the view.
    myScrollView.minimumZoomScale = 1;
    myScrollView.maximumZoomScale = 3;
    
    DatabaseHelper *helper = [DatabaseHelper new];
    
    self.title = self.bookTitle;
    self.myTextView.text = [helper contentForIndex:self.bookID];
}

- (void)viewDidUnload
{
    [self setMyScrollView:nil];
    [self setMyTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return myTextView;
}

@end
