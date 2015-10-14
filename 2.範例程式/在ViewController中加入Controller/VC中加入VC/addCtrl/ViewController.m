//
//  ViewController.m
//  addCtrl
//
//  Created by JzChang on 13/3/5.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

/*
 參考網址：http://wangjun.easymorse.com/?p=1630
 */

#import "ViewController.h"

#import "FirstViewController.h"

#import "SecondViewController.h"

#import "ThirdViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FirstViewController *firstViewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    [self addChildViewController:firstViewController];
    
    SecondViewController *secondViewController = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    [self addChildViewController:secondViewController];    
    
    ThirdViewController *thirdViewController = [[ThirdViewController alloc] initWithNibName:@"ThirdViewController" bundle:nil];
    [self addChildViewController:thirdViewController];
    
    [self.contentView addSubview:thirdViewController.view];
    
    currentViewController = thirdViewController; // 起始畫面設為 thirdViewController
}

- (IBAction)onClickbutton:(id)sender
{
    FirstViewController *firstViewController = [self.childViewControllers objectAtIndex:0];
    SecondViewController *secondViewController = [self.childViewControllers objectAtIndex:1];
    ThirdViewController *thirdViewController = [self.childViewControllers objectAtIndex:2];
    
    // 一樣就不轉畫面
    if (([sender tag] == 1 && currentViewController == firstViewController)  ||
        ([sender tag] == 2 && currentViewController == secondViewController) ||
        ([sender tag] == 3 && currentViewController == thirdViewController)) {
        return;
    }
    
    UIViewController *oldViewController = currentViewController;
    
    switch ([sender tag]) {
        case 1:
        {
            NSLog(@"Click 1");
            
            [self transitionFromViewController:currentViewController
                              toViewController:firstViewController
                                      duration:1
                                       options:UIViewAnimationOptionTransitionFlipFromLeft
                                    animations:^{ }
                                    completion:^(BOOL finished) {
                                        if (finished) {
                                            currentViewController = firstViewController;
                                        }
                                        else{
                                            currentViewController = oldViewController;
                                        }
                                    }];            
            break;
        }
            
        case 2:
        {
            NSLog(@"Click 2");
            
            [self transitionFromViewController:currentViewController
                              toViewController:secondViewController
                                      duration:1
                                       options:UIViewAnimationOptionTransitionFlipFromTop
                                    animations:^{ }
                                    completion:^(BOOL finished) {
                                        if (finished) {
                                            currentViewController = secondViewController;
                                        }
                                        else{
                                            currentViewController = oldViewController;
                                        }
                                    }];            
            break;
        }
        case 3:
        {
            NSLog(@"Click 3");
            
            [self transitionFromViewController:currentViewController
                              toViewController:thirdViewController
                                      duration:1
                                       options:UIViewAnimationOptionTransitionFlipFromBottom
                                    animations:^{ }
                                    completion:^(BOOL finished) {
                                        if (finished) {
                                            currentViewController = thirdViewController;
                                        }
                                        else{
                                            currentViewController = oldViewController;
                                        }
                                    }];            
            break;
        }
        default:
            break;
    }   
}
@end
