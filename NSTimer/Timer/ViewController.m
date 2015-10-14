//
//  ViewController.m
//  Timer
//
//  Created by JzChang on 12/9/16.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize display;
@synthesize ctrlBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    pause = YES;
    data = 1;
}

- (void)viewDidUnload
{
    [self setDisplay:nil];
    [self setCtrlBtn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) myMethod:(NSTimer *) aTimer
{
    display.text = [NSString stringWithFormat:@"%d", data++];
}

- (IBAction)StartAndPause:(UIButton *)sender
{    
    if (pause) {
        // 啓動 Timer
        myTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                   target:self
                                                 selector:@selector(myMethod:)
                                                 userInfo:nil
                                                  repeats:YES];
        
        [ctrlBtn setTitle:@"暫停" forState:UIControlStateNormal];
    }
    else {        
        // 關掉 Timer
        [myTimer invalidate];
        
        [ctrlBtn setTitle:@"繼續" forState:UIControlStateNormal];
    }
    
    pause = !pause;    
}
@end
