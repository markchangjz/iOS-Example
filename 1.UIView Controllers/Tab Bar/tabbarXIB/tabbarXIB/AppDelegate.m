//
//  AppDelegate.m
//  tabbarXIB
//
//  Created by EE Lab on 12/7/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstView.h"
#import "SecondView.h"
#import "ThirdView.h"
#import "FourthView.h"
#import "FifthView.h"
#import "SixthView.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 將 view 加入 tab bar
    self.tabBarController = [[UITabBarController alloc] init];
    FirstView *firstView = [[FirstView alloc] init];
    SecondView *secondView = [[SecondView alloc] init];
    ThirdView *thirdView = [[ThirdView alloc] init];
    FourthView *fourthView = [[FourthView alloc] init];
    FifthView *fifthView = [[FifthView alloc] init];
    SixthView *sixView = [[SixthView alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:firstView, secondView, thirdView, fourthView, fifthView, sixView, nil];
    
    // 1. 設定 tab bar 文字 (使用者自訂)
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"First" image:[UIImage imageNamed:@"301.png"] tag:0];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"Second" image:[UIImage imageNamed:@"302.png"] tag:0];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"Third" image:[UIImage imageNamed:@"303.png"] tag:0];
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"Fourth" image:[UIImage imageNamed:@"304.png"] tag:0];
    UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:@"Fifth" image:[UIImage imageNamed:@"305.png"] tag:0];
    UITabBarItem *item6 = [[UITabBarItem alloc] initWithTitle:@"Sixth" image:[UIImage imageNamed:@"306.png"] tag:0];
    
    // 2. 設定 tab bar 文字 (使用系統設定,無法設定title文字)
//    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:0];
//    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:0];
//    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
//    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:0];
//    UITabBarItem *item5 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemSearch tag:0];
//    UITabBarItem *item6 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:0];
    
    firstView.tabBarItem = item1;    
    secondView.tabBarItem = item2;    
    thirdView.tabBarItem = item3;   
    fourthView.tabBarItem = item4;
    fifthView.tabBarItem = item5;
    sixView.tabBarItem = item6;    

    self.window.rootViewController = self.tabBarController;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
