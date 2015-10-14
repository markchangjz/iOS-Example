//
//  ViewController.m
//  Modal View
//
//  Created by JzChang on 13/2/25.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)clickPresent:(UIBarButtonItem *)sender
{    
    NSLog(@"%@", self.view.window.subviews);
    
    ModalViewController *mvc = [[ModalViewController alloc] init];
    UINavigationController *navMvc = [[UINavigationController alloc] initWithRootViewController:mvc];
    [navMvc.navigationBar setBarStyle:UIBarStyleBlack];
    [navMvc setModalPresentationStyle:UIModalPresentationFormSheet];
    [navMvc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [self presentViewController:navMvc animated:YES completion:nil];
    
    NSLog(@"%@", self.view.window.subviews);    
    
    // Move the dimmingview to just below the dropshadow.    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedOutsideView:)];
    [tapGesture setNumberOfTapsRequired:1];
    [tapGesture setNumberOfTapsRequired:1];
//    [tapGesture setCancelsTouchesInView:NO];
    
    UIView *dimmingView = [self.view.window.subviews objectAtIndex:1];
    [dimmingView addGestureRecognizer:tapGesture];
}

- (void)tappedOutsideView:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
