//
//  PlistHelper.m
//  Zookeeper
//
//  Created by JzChang on 12/12/24.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "PlistHelper.h"

@implementation PlistHelper

+ (NSString *)plistFilePath
{
    // 取得 Document 檔案路徑
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // plist 檔名
    NSString *plistPath = [docPath stringByAppendingPathComponent:@"Zookeeper.plist"];
    return plistPath;
}

@end
