//
//  MyLogActivity.m
//  UIActivity
//
//  Created by Mac on 2013/11/12.
//  Copyright (c) 2013年 KKBOX. All rights reserved.
//

#import "MyLogActivity.h"

NSArray *inItems;

@implementation MyLogActivity

-(NSString *)activityTitle
{
    return @"Log";
}

- (UIViewController *)activityViewController
{
	return nil;
}

-(UIImage *)activityImage
{
    // Replace the file name with the one of the file you imported into your project
    return [UIImage imageNamed:@"log_icon.png"];
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
	// UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:customServices];
	// 檢查 items 送進來的資料 (activityItems)

    for (NSObject *item in activityItems) {
        if (![item isKindOfClass:[NSString class]] && ![item isKindOfClass:[NSURL class]]) {
            return NO;
        }
    }

	inItems = activityItems;

    return YES;
}

-(void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (NSObject *item in activityItems) {
        NSLog(@"%@", item);
    }
}

-(void)performActivity
{
    NSLog(@"performActivity");

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:inItems[0]
                                                    message:[inItems[1] absoluteString]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

	// 關閉 activity
    [self activityDidFinish:YES];
}

@end
