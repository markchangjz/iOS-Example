//
//  main.m
//  ReverseString
//
//  Created by JzChang on 13/1/9.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "reverse.c"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSString *oriStr = @"XYZabc123";
        
        NSString *revStr = [[NSString alloc] initWithUTF8String:reverseStr([oriStr UTF8String])];
        
        NSLog(@"Reverse String = %@", revStr);
    }
    return 0;
}

