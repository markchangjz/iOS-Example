//
//  StreamingTVC.h
//  MyMoviePlayer2
//
//  Created by JzChang on 12/10/23.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewDelegate.h"

@class DetailViewController;

@interface StreamingTVC : UITableViewController

@property (strong, nonatomic) NSDictionary *movies;
@property (strong, nonatomic) DetailViewController *detailViewController;
@property (nonatomic, weak) id <DetailViewDelegate> delegate;

@end
