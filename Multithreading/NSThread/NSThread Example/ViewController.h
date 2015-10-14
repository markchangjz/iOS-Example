//
//  ViewController.h
//  NSThread Example
//
//  Created by JzChang on 13/1/14.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *text1;
@property (weak, nonatomic) IBOutlet UITextView *text2;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

- (IBAction)launchText1:(id)sender;
- (IBAction)launchText2:(id)sender;
- (IBAction)cancelThread:(id)sender;

- (void)thread1;
- (void)thread2;
- (void)updateThread1:(NSNumber *)n;
- (void)updateThread2:(NSNumber *)n;

@end
