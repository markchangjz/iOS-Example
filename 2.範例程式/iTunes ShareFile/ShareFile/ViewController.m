//
//  ViewController.m
//  ShareFile
//
//  Created by EE Lab on 12/7/16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize fileInDocument;

/*
在 info.plist中加入
Application supports iTunes file sharing = YES
讓使用者可以透過 iTunes 把資料放進 Document 資料夾
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // 取的Document目錄
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    // 列出Document目錄裡的檔案
    NSError * error;
    NSArray * directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:docPath error:&error];
    
    for (NSString *fileName in directoryContents) {
        NSLog(@"1.檔案全名：%@", fileName);
        NSLog(@"2.檔案名稱：%@", [fileName stringByDeletingPathExtension]);
        NSLog(@"3.檔案副檔名：%@", [fileName pathExtension]);
        
        fileInDocument.text = [fileInDocument.text stringByAppendingFormat:@"%@\n", fileName];
    }    
    
}

- (void)viewDidUnload
{
    [self setFileInDocument:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
