//
//  ViewA.m
//  tabbarStoryboard
//
//  Created by EE Lab on 12/7/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewA.h"

@interface ViewA ()

@end

@implementation ViewA

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
    myImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"a.png"]];
    myImage.frame = CGRectMake(0, 0, 320, 320);
    [self.view addSubview:myImage];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
