//
//  ViewController.m
//  NSThread Example
//
//  Created by JzChang on 13/1/14.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

/*
 1.(IOS)NSThread Example @ 初心者(My Program) :: 隨意窩 Xuite日誌
 http://blog.xuite.net/programer/1/61839711-(IOS)NSThread+Example
 
 2.Cocoa Multithread - NSThread - Kelp Code
 http://kelp.phate.org/2011/09/cocoa-multithread-nsthread.html
 */

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate, UITextViewDelegate>

@property (strong, nonatomic) NSThread *threadA;
@property (strong, nonatomic) NSThread *threadB;

@end

BOOL isStart1 = NO, isStart2 = NO;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

// 執行/取消 threadA
- (IBAction)launchText1:(id)sender
{
    if (isStart1) {
        [self.btn1 setTitle:@"GO 1" forState:UIControlStateNormal];
        
        [self.threadA cancel]; // 取消 Thread
    }
    else {
        [self.btn1 setTitle:@"STOP 1" forState:UIControlStateNormal];
                
        self.threadA = [[NSThread alloc] initWithTarget:self
                                          selector:@selector(thread1)
                                            object:nil];
        [self.threadA start]; // 執行 Thread
    }
    
    isStart1 = !isStart1;
}

// 執行/取消 threadB
- (IBAction)launchText2:(id)sender
{
    if (isStart2) {
        [self.btn2 setTitle:@"GO 2" forState:UIControlStateNormal];
        
        [self.threadB cancel]; // 取消 Thread
    }
    else {
        [self.btn2 setTitle:@"STOP 2" forState:UIControlStateNormal];
        
        self.threadB = [[NSThread alloc] initWithTarget:self
                                          selector:@selector(thread2)
                                            object:nil];
        [self.threadB start]; // 執行 Thread
    }
    
    isStart2 = !isStart2;
}

// 一起取消 threadA 和 threadB
- (IBAction)cancelThread:(id)sender 
{
    [self.btn1 setTitle:@"GO 1" forState:UIControlStateNormal];
    isStart1 = NO;
    [self.threadA cancel]; // 取消 Thread
    
    [self.btn2 setTitle:@"GO 2" forState:UIControlStateNormal];
    isStart2 = NO;
    [self.threadB cancel]; // 取消 Thread  
}

#pragma mark - selector

- (void)thread1
{
    for (int i = 1; i <= 20; i++) {
        /*
         需要自己在 Thread 中檢測取消，然後適時退出該 Thread
         */
        if ([[NSThread currentThread] isCancelled]) {
            [NSThread exit]; // 當此 thread 被標記 cancel 時自行結束
        }
        
        // waitUntilDone = YES, 直到執行結束之前現行執行緒會等待之
        [self performSelectorOnMainThread:@selector(updateThread1:) withObject:[NSNumber numberWithInt:i] waitUntilDone:YES];
                
        [NSThread sleepForTimeInterval:0.3];
    }
    
    [self.btn1 setTitle:@"GO 1" forState:UIControlStateNormal];
    isStart1 = NO;
}

- (void)updateThread1:(NSNumber *)n
{
    NSMutableString *temp=[[NSMutableString alloc] initWithString:self.text1.text];
    
    [temp appendString:[NSMutableString stringWithFormat:@"2 * %d = %d\n",[n intValue],(2 * [n intValue])]];
    
    self.text1.text = temp;
    
    // 自動捲動
    [self.text1 scrollRectToVisible:CGRectMake(0, self.text1.contentSize.height-1, 1, 1) animated:YES];
}

- (void)thread2
{
    for (int i = 1; i <= 20; i++) {
        /*
         需要自己在 Thread 中檢測取消，然後適時退出該 Thread
         */
        if ([[NSThread currentThread] isCancelled]) {
            [NSThread exit]; // 當此 thread 被標記 cancel 時自行結束
        }
        
        // waitUntilDone = YES, 直到執行結束之前現行執行緒會等待之
        [self performSelectorOnMainThread:@selector(updateThread2:) withObject:[NSNumber numberWithInt:i] waitUntilDone:YES];
        
        [NSThread sleepForTimeInterval:0.6];
    }
    
    [self.btn2 setTitle:@"GO 2" forState:UIControlStateNormal];
    isStart2 = NO;
}

- (void)updateThread2:(NSNumber *)n
{
    NSMutableString *temp = [[NSMutableString alloc] initWithString:self.text2.text];
    
    [temp appendString:[NSMutableString stringWithFormat:@"5 * %d = %d\n",[n intValue],(5 * [n intValue])]];
    
    self.text2.text = temp;
    
    // 自動捲動
    [self.text2 scrollRectToVisible:CGRectMake(0, self.text2.contentSize.height-1, 1, 1) animated:YES];
}

@end
