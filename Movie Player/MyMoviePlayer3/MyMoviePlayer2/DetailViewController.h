//
//  DetailViewController.h
//  MyMoviePlayer2
//
//  Created by JzChang on 12/10/15.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewDelegate.h"
#import "MasterViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, DetailViewDelegate>

@property (strong, nonatomic) MPMoviePlayerController *player;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *videoSize;

@end
