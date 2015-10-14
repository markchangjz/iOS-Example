//
//  main.m
//  Regular Expression
//
//  Created by JzChang on 13/3/27.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // 檢查 IP
        // http://answers.oreilly.com/topic/318-how-to-match-ipv4-addresses-with-regular-expressions/
        
        NSString *ipRegExp = @"^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$";
        NSPredicate *ipTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ipRegExp];
        
        if ([ipTest evaluateWithObject:@"140.118.7.9"]) {
            NSLog(@"IP YES");
        }
        else {
            NSLog(@"IP NO");
        }
        
      
        // 檢查目錄
        // http://godspeedlee.myweb.hinet.net/regex/2/make_output.htm
        
        //@"([^\\/:*?\"<>|]+/?)+";
        //@"(\\w+/?)+\\w+";
        
        NSString *dirRegExp = @"([^\\/:*?\"<>|]+/?)+[^\\/:*?\"<>|]+";
        NSPredicate *dirTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", dirRegExp];
        
        if ([dirTest evaluateWithObject:@"aa/bb"]) {
            NSLog(@"DIR YES");
        }
        else {
            NSLog(@"DIR NO");
        }
        
    }
    return 0;
}

