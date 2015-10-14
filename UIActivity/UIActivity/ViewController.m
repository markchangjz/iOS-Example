//
//  ViewController.m
//  UIActivity
//
//  Created by Mac on 2013/11/12.
//  Copyright (c) 2013年 KKBOX. All rights reserved.
//

#import "ViewController.h"
#import "MyLogActivity.h"
#import "MyLogActivity2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)_tapActionButton:(UIBarButtonItem *)sender
{
    NSString *text = @"self.messageTextView.text";
    NSURL *url = [NSURL URLWithString:@"self.urlTextField.text"];
    NSArray *items = @[text, url];
    MyLogActivity *myLogService = [[MyLogActivity alloc] init];
    MyLogActivity2 *myLogService2 = [[MyLogActivity2 alloc] init];
    NSArray *customServices = @[myLogService, myLogService2];
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:customServices];
    vc.excludedActivityTypes = @[UIActivityTypeMail, UIActivityTypeCopyToPasteboard, UIActivityTypeMessage];

    [self presentViewController:vc animated:YES completion:nil];
}

@end
