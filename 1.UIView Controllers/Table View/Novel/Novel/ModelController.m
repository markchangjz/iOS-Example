//
//  ModelController.m
//  Novel
//
//  Created by EE Lab on 12/7/4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ModelController.h"
#import "DatabaseHelper.h"
#import "ContentViewController.h"

@implementation ModelController

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    ContentViewController *currentView = (ContentViewController *)viewController;
    
    NSString *currentBooKID = currentView.bookID;
    
    DatabaseHelper *helper = [DatabaseHelper new];
    
    NSString *lastBookID = [NSString stringWithFormat:@"%@", [[helper bookIDs] lastObject]];
    
    if ([currentBooKID isEqualToString:lastBookID]) {
        return nil;
    }
    
    int nextIndex = [[helper bookIDs] indexOfObject:currentBooKID] + 1;
    NSString *nextBookID = [[helper bookIDs] objectAtIndex:nextIndex];
    
    pageViewController.title = [helper titleForIndex:nextBookID];
    
    ContentViewController *contentController = [viewController.storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
    contentController.bookID = nextBookID;
    return contentController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    ContentViewController *currentView = (ContentViewController *)viewController;

    NSString *currentBooKID = currentView.bookID;

    DatabaseHelper *helper = [DatabaseHelper new];
    
    NSString *firstBookID = [NSString stringWithFormat:@"%@", [[helper bookIDs] objectAtIndex:0]];

    if ([currentBooKID isEqualToString:firstBookID]) {
        return nil;
    }

    int prevIndex = [[helper bookIDs] indexOfObject:currentBooKID] - 1;
    NSString *prevBookID = [[helper bookIDs] objectAtIndex:prevIndex];

    pageViewController.title = [helper titleForIndex:prevBookID];

    ContentViewController *contentController = [viewController.storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
    contentController.bookID = prevBookID;
    return contentController;
}

@end
