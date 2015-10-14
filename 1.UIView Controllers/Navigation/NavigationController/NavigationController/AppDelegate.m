//
//  AppDelegate.m
//  NavigationController
//
//  Created by JzChang on 12/9/28.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h" // 加入root view

@implementation AppDelegate

@synthesize navController; // 新增 NavigationController

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 將 RootViewController 設為 Root View Controller 
    RootViewController *root = [[RootViewController alloc] initWithStyle:UITableViewStylePlain];
    self.navController = [[UINavigationController alloc] initWithRootViewController:root];
    
    self.navController.toolbarHidden = NO;                          // 設定為 NO 才會顯示 toolbar, YES(預設值)
    
    self.navController.navigationBar.translucent = YES;             // 導航欄內容區域, YES:透明, NO:不透明(預設值)
    self.navController.toolbar.translucent = YES;                   // 工具欄內容區域, YES:透明, NO:不透明(預設值)    
    self.navController.navigationBar.barStyle = UIBarStyleDefault;  // 設定 navigationBar style
    self.navController.toolbar.barStyle = UIBarStyleDefault;        // 設定 toolbar style
    
    self.window.rootViewController = self.navController;
    
    [self.window makeKeyAndVisible];
    
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
