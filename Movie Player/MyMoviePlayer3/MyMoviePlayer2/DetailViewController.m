//
//  DetailViewController.m
//  MyMoviePlayer2
//
//  Created by JzChang on 12/10/15.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "DetailViewController.h"
#import "MasterViewController.h"


@interface DetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

@implementation DetailViewController

@synthesize player;
@synthesize videoSize;

- (void)playURL:(NSURL *)fileURL
{
    if (player.playbackState == MPMoviePlaybackStatePlaying) {
        [player stop];
    }    
    
    player.contentURL = fileURL;
    [player prepareToPlay];
    [player play];
}

- (void)dataTitle:(NSString *)title
{
    self.title = title;
}

- (MPMoviePlayerController *)getPlayer
{
    return player;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    player = [[MPMoviePlayerController alloc] init];
    player.shouldAutoplay = YES;
    player.controlStyle = MPMovieControlStyleEmbedded;    
    
    
    [self.view addSubview:player.view];   

    
}

- (void)viewDidUnload
{
    [self setVideoSize:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    CGRect rect = self.view.bounds;
    player.view.frame = rect;
    videoSize.title = [NSString stringWithFormat:@"%.0f(W) * %.0f(H)", self.view.frame.size.width, self.view.frame.size.height];
    player.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);    
    return YES;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = @"MENU";
    // [[[splitController.viewControllers objectAtIndex:0] topViewController] title];
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
