//
//  ThirdView.m
//  tabbarXIB
//
//  Created by EE Lab on 12/7/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ThirdView.h"

@interface ThirdView ()

@end

@implementation ThirdView

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
    myImage03 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"c.png"]];
    myImage03.frame = CGRectMake(0, 0, 320, 320);
    [self.view addSubview:myImage03];
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
