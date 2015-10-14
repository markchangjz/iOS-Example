//
//  MasterViewController.h
//  MyMoviePlayer2
//
//  Created by JzChang on 12/10/15.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewDelegate.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController 

@property (strong, nonatomic) NSDictionary *movies;
@property (strong, nonatomic) NSMutableDictionary *images;

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (nonatomic, weak) id <DetailViewDelegate> delegate;

@end
