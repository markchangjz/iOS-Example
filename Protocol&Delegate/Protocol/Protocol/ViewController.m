//
//  ViewController.m
//  Protocol
//
//  Created by JzChang on 12/9/8.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// *************************************************
- (void)whenCalledDelegeteFunction
{
    NSLog(@"Hi~ Delegate!!");
}
// *************************************************

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // *************************************************
    Furnace *iOS = [[Furnace alloc] init];
    iOS.delegate = self;
    [iOS delegateFunction];
    // *************************************************
}

@end
