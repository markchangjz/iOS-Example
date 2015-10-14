//
//  MyComputeTask.h
//  Multithreading
//
//  Created by JzChang on 13/1/30.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyComputeTask : NSObject {
    NSInvocationOperation *computeOp; // 作業物件
    NSOperationQueue *operationQueue; // 運算佇列
}

- (void)computeInBackground:(id)data;
- (void)compute:(id)data;

@end
