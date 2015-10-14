//
//  ModalViewController.m
//  Modal View
//
//  Created by JzChang on 13/2/25.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation ModalViewController

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *theView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
    theView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:theView];
}

@end
