//
//  ViewController.m
//  chkNetwork
//
//  Created by JzChang on 13/3/22.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "ViewController.h"
#import "CheckNetwork.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLbl;

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

- (IBAction)clickRefresh:(UIBarButtonItem *)sender
{
    if ([CheckNetwork connectedToNetwork]) {
        self.resultLbl.text = @"YES";
    }
    else {
        self.resultLbl.text = @"NO";
    }
}

@end
