//
//  ViewController.m
//  NSUserDefaults
//
//  Created by JzChang on 12/9/27.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

/*
 應用程式內部狀態的存取
 參考網址: http://furnacedigital.blogspot.tw/2010/12/blog-post.html
 */

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize TxtField;
@synthesize State1Switch;
@synthesize State2Switch;
@synthesize State3Switch;

//宣告一個指標（Key），此指標必須是NSString型態，這個指標將在應用程式結束時儲存變數值。
NSString *TxtFieldKey = @"TxtKey";
NSString *State1Key = @"stateKey1";
NSString *State2Key = @"stateKey2";
NSString *State3Key = @"stateKey3";

NSString *TxtFieldData = @"";
BOOL onState1, onState2, onState3;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self LoadStateData];
}

- (void)viewDidUnload
{
    [self setState1Switch:nil];
    [self setState2Switch:nil];
    [self setState3Switch:nil];
    [self setTxtField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)ClickBtn:(UIButton *)sender
{
    NSLog(@"%@", TxtField.text);
    TxtFieldData = TxtField.text;
    [[NSUserDefaults standardUserDefaults] setObject:TxtFieldData forKey:TxtFieldKey];
}

- (IBAction)State1Switched:(UISwitch *)sender
{
    onState1 = State1Switch.on;
    //將BOOL型態變數，存入指標（Key）內永久保存，直到該應用程式被移除
    [[NSUserDefaults standardUserDefaults] setBool:onState1 forKey:State1Key];
}

- (IBAction)State2Switched:(UISwitch *)sender
{
    onState2 = State2Switch.on;
    //將BOOL型態變數，存入指標（Key）內永久保存，直到該應用程式被移除
    [[NSUserDefaults standardUserDefaults] setBool:onState2 forKey:State2Key];
}

- (IBAction)State3Switched:(UISwitch *)sender
{
    onState3 = State3Switch.on;
    //將BOOL型態變數，存入指標（Key）內永久保存，直到該應用程式被移除
    [[NSUserDefaults standardUserDefaults] setBool:onState3 forKey:State3Key];
}

//自行定義的函式，目的是在程式一開始執行時就取得上次執行結束前的相關狀態
-(void) LoadStateData
{    
    //從指標（Key）中取出先前所保留的BOOL參數值
    TxtFieldData = [[NSUserDefaults standardUserDefaults] stringForKey:TxtFieldKey];
    onState1 = [[NSUserDefaults standardUserDefaults] boolForKey:State1Key];
    onState2 = [[NSUserDefaults standardUserDefaults] boolForKey:State2Key];
    onState3 = [[NSUserDefaults standardUserDefaults] boolForKey:State3Key];
    
    //將取出的參數值賦予Switch
    TxtField.text = TxtFieldData;
    State1Switch.on = onState1;
    State2Switch.on = onState2;
    State3Switch.on = onState3;
}

@end
