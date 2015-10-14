//
//  MyComputeTask.m
//  Multithreading
//
//  Created by JzChang on 13/1/30.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "MyComputeTask.h"

@implementation MyComputeTask

- (void)computeInBackground:(id)data
{
    operationQueue = [[NSOperationQueue alloc] init];
    computeOp = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(compute:) object:data];
    
    // 加到 Queue 開始執行
    [operationQueue addOperation:computeOp];
}

- (void)compute:(id)data
{
    for (int i = 1; i < [data intValue]; i++) {
        NSLog(@"Computing %d", i);
    }    
}

@end
