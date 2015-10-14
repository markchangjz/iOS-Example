//
//  ContentViewController.h
//  Novel2
//
//  Created by EE Lab on 12/7/4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) IBOutlet UITextView *myTextView;
@property (strong, nonatomic) NSString *bookID;
@property (strong, nonatomic) NSString *bookTitle;

@end
