//
//  ViewController.m
//  NotificationTEST
//
//  Created by EE Lab on 12/6/21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController
@synthesize lbl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 螢幕轉向
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Changed:)
                                                 name:@"UIApplicationWillChangeStatusBarOrientationNotification"
                                               object:nil];
    
    lbl.text = [NSString stringWithFormat:@"%d", count++];
}

- (void)viewDidUnload
{   
    [self setLbl:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)Changed:(NSNotification *) notification
{
    printf("count = %d\n", count);
    lbl.text = [NSString stringWithFormat:@"%d", count++];    
    
    // 1.傳送 NSString
    [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotification"
                                                        object:@"123"];
    
    // 2.傳送 NSDictionary
    NSDictionary *myDict = [NSDictionary dictionaryWithObjectsAndKeys:@"v1", @"k1", @"v2", @"k2", @"v3", @"k3", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotification"
                                                        object:self
                                                      userInfo:myDict]; // userInfo 只能送出 NSDictionary
    
    // 3.傳送 NSArray
    NSArray *myArray = [NSArray arrayWithObjects:@"aa", @"bb", @"cc", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotification"
                                                        object:myArray];
}

@end
