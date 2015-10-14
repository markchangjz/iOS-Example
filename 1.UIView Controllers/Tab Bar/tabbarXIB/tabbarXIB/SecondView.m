//
//  SecondView.m
//  tabbarXIB
//
//  Created by EE Lab on 12/7/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SecondView.h"

@interface SecondView () <UITabBarControllerDelegate>

@end

int progressValue = 0;
BOOL isLoading = YES;

@implementation SecondView

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
    
    // 設定 UITabBarControllerDelegate 為 self
    self.tabBarController.delegate = self;
        
    myImage02 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"b.png"]];
    myImage02.frame = CGRectMake(0, 0, 320, 320);
    [self.view addSubview:myImage02];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    progressValue = 0;
    isLoading = YES;
    
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 10, self.view.frame.size.width, 10)];

    [self.view addSubview:progressView];
    [progressView setProgressViewStyle:UIProgressViewStyleDefault];
    [progressView setProgress:progressValue/10.0];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeValue:) userInfo:progressView repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarItem.badgeValue = nil;
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - selector

- (void)changeValue:(NSTimer *)sender
{
    if (progressValue++ >= 10) {
        // sender: NSTimer
        [sender invalidate];
        isLoading = NO;
    }
    else {
        // [sender userInfo]: progressView
        [[sender userInfo] setProgress:progressValue/10.0 animated:YES];
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", progressValue];
    }
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    // YES: 可以選其他 Tab
    // NO:  不可以選其他 Tab
    
    if (isLoading) {
        return NO;
    }
    else {
        return YES;
    }    
}

@end
