//
//  AppDelegate.m
//  myappscheme
//
//  Created by JzChang on 14/1/5.
//  Copyright (c) 2014年 JzChang. All rights reserved.
//

// 參考網址：http://www.idev101.com/code/Objective-C/custom_url_schemes.html

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}

- (NSDictionary *)parseQueryString:(NSString *)query
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    // handler code here
    NSLog(@"url recieved: %@", url);            // "myappscheme://test_page/one?token=12345&domain=foo.com"
    NSLog(@"query string: %@", [url query]);    // "token=12345&domain=foo.com"
    NSLog(@"host: %@", [url host]);             // "test_page"
    NSLog(@"url path: %@", [url path]);         // "/one"
    NSDictionary *dict = [self parseQueryString:[url query]];
    NSLog(@"query dict: %@", dict);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[url absoluteString]
                                                        message:[NSString stringWithFormat:@"%@", dict]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    
    return YES;
}

@end
