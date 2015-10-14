//
//  DetailViewDelegate.h
//  MyMoviePlayer2
//
//  Created by JzChang on 12/10/18.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@protocol DetailViewDelegate <NSObject>
@optional
- (void)playURL:(NSURL *)fileURL;
- (void)dataTitle:(NSString *)title;
- (MPMoviePlayerController *)getPlayer;
@end
