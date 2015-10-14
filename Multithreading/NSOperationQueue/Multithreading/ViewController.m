//
//  ViewController.m
//  Multithreading
//
//  Created by JzChang on 13/1/30.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "ViewController.h"
#import "MyComputeTask.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *computeBtn;

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
- (IBAction)clickCompute:(UIButton *)sender
{
    MyComputeTask *myComputeTask = [[MyComputeTask alloc] init];
    
    [myComputeTask computeInBackground:[NSNumber numberWithInt:100000]];
    //[myComputeTask compute:[NSNumber numberWithInt:100000]]; // 沒有背景執行會使 TableView 無法拖動
}

@end
