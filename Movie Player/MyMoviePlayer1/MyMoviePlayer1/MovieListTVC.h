//
//  MovieListTVC.h
//  MyMoviePlayer1
//
//  Created by JzChang on 12/10/15.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MovieListTVC : UITableViewController {
    NSDictionary *movies;
    NSDictionary *moviesHTTP;
}

@end
