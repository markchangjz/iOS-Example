//
//  PageViewController.h
//  Novel
//
//  Created by EE Lab on 12/7/4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"
#import "ModelController.h"

@interface PageViewController : UIPageViewController <UIPageViewControllerDelegate> {
    ModelController *modelController;
}

@property (strong, nonatomic) NSString *bookID;
@property (strong, nonatomic) NSString *bookTitle;

@end
