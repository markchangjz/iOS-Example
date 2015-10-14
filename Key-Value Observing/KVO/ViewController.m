//
//  ViewController.m
//  KVO
//
//  Created by JzChang on 13/2/5.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

/*
 Key-Value Observing (KVO)
 */

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableDictionary *dic;

@end

@implementation ViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];    
 
    self.dic = [[NSMutableDictionary alloc] init];
    
    [self.dic addObserver:self
               forKeyPath:@"Key"
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:nil];
    
    /*
     options => 可指定字典資料要包含何種值
     NSKeyValueObservingOptionNew: 提供屬性被更改後的值
     NSKeyValueObservingOptionOld: 提供屬性被更改前的值
     */
    
    [self.dic setValue:@"oldValue" forKey:@"Key"];
    [self.dic setValue:@"newValue" forKey:@"Key"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeTilte:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.textField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeTilte2)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.textField2];
}

- (void)viewWillDisappear:(BOOL)animated
{        
    [self.dic removeObserver:self forKeyPath:@"Key"];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewWillDisappear:animated];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    NSLog(@"--- Received by %@ ---", self);
    NSLog(@"Object=%@, Path=%@", object, keyPath);
    NSLog(@"Change=%@", change);
}

- (void)changeTilte:(NSNotification *)notification
{
    UITextField *sender = [notification object];
    self.navigationItem.title = sender.text;
}

- (void)changeTilte2
{
    self.navigationItem.title = self.textField2.text;
}

@end
