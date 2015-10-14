//
//  ImageViewController.h
//
//  Created by CS193p Instructor.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotosByPhotographerTableViewController;

@interface ImageViewController : UIViewController <UIScrollViewDelegate, UISplitViewControllerDelegate>

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSString *detailViewPhotoTitle;

@end
