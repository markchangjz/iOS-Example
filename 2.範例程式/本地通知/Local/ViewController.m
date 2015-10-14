//
//  ViewController.m
//  Local
//
//  Created by JzChang on 13/2/25.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

/*
 程式不再執行的狀態下, 可以使用本地通知(Local Notification)將資訊丟給使用者, 排程後, 在指定的日期時間顯示通知
 
 與推播通知(Push Notification)不同, 本地通知不需要任何網路連線, 也不必跟遠端伺服器溝通
 
 當程式處於活動狀態時, 系統不會顯示本地通知, 只有當程式處於凍結或在背景執行時才會動作
 */

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

- (IBAction)clickAction:(UIBarButtonItem *)sender
{
    UIApplication *app = [UIApplication sharedApplication];
    
    // 移除所有先前的通知
    NSArray *scheduled = [app scheduledLocalNotifications];
    if (scheduled.count) {
        [app cancelAllLocalNotifications];
    }
    
    // 建立新通知
    UILocalNotification *alarm = [[UILocalNotification alloc] init];
    
    if (alarm) {
        alarm.fireDate = [NSDate dateWithTimeIntervalSinceNow:3.0f];
        alarm.timeZone = [NSTimeZone defaultTimeZone];
        alarm.repeatInterval = 0;
        alarm.alertBody = @"Local Notification Test!";
        [app scheduleLocalNotification:alarm];
        
        // 強制退出, 有要發佈到 App Store 不可這麼做
        exit(0);
    }
    
}

@end
