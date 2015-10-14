//
//  menuTVC.m
//  MyMoviePlayer2
//
//  Created by JzChang on 12/10/18.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "menuTVC.h"

@interface menuTVC ()

@end

@implementation menuTVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.delegate = [[self.splitViewController.viewControllers lastObject] topViewController];    
    
    if ([[self.delegate getPlayer] playbackState] != MPMoviePlaybackStatePlaying) {
        [self.delegate dataTitle:@"多媒體播放器"];
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
