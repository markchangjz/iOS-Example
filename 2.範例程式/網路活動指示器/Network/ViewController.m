//
//  ViewController.m
//  Network
//
//  Created by JzChang on 13/2/25.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "ViewController.h"

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

- (IBAction)networkAction:(UIBarButtonItem *)sender
{
    // 請確認變更這個屬性時必須處於主執行緒裡, 這樣 GUI 才能正確更新
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = !app.networkActivityIndicatorVisible;
    
    // 設定APP 的 Badge 值, 如果要隱藏標記就設為 0
    app.applicationIconBadgeNumber = 1;    
}

@end
