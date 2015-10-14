//
//  MyLogActivity2.m
//  UIActivity
//
//  Created by Mac on 2013/11/12.
//  Copyright (c) 2013年 KKBOX. All rights reserved.
//

#import "MyLogActivity2.h"

@implementation MyLogActivity2

-(NSString *)activityTitle
{
    return @"Log2";
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
    for (NSObject *item in activityItems) {

        if (![item isKindOfClass:[NSString class]] && ![item isKindOfClass:[NSURL class]]) {
            return NO;
        }
    }
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
    NSLog(@"performActivity 2");

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title"
                                                    message:@"Log2"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

    [self activityDidFinish:YES];
}

@end
