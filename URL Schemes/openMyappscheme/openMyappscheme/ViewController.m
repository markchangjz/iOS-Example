//
//  ViewController.m
//  openMyappscheme
//
//  Created by JzChang on 14/1/5.
//  Copyright (c) 2014年 JzChang. All rights reserved.
//

// 參考網址：http://www.idev101.com/code/Objective-C/custom_url_schemes.html

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)openMyappschemeURL:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"myappscheme://test_page/one?token=12345&domain=foo.com"]];
}

@end
