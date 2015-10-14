//
//  ViewController.m
//  myPlayer
//
//  Created by JzChang on 13/1/4.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "ViewController.h"
#import "ModalViewControllerDelegate.h"
#import "L_menuTVC.h"
#import "S_menuTVC.h"
#import "VideoInfo.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController () <ModalViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *videoTypeSegment;      // 選擇 "本機端" 或 "網路串流"
@property (strong, nonatomic) UIButton *titleButton;                            // 影片標題按鈕
@property (strong, nonatomic) MPMoviePlayerController *player;                  // Movie Player
@property (strong, nonatomic) UIPopoverController *showPopover;                 // Popover

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];   
    
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - code

- (void)setupView
{
    self.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.titleButton setTitle:@"myPlayer" forState:UIControlStateNormal];
    [self.titleButton sizeToFit];
    [self.titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.titleButton addTarget:self action:@selector(clickTitleButton:) forControlEvents:UIControlEventTouchUpInside];
    self.titleButton.enabled = NO;
    self.navigationItem.titleView = self.titleButton; // 將按鈕放入 navigation 的 title

    // 設定 Segment 點選到的顏色
    [[self.videoTypeSegment.subviews lastObject] setTintColor:[UIColor colorWithRed:0.078 green:0.682 blue:0.851 alpha:1.0]];    

    [self.view addSubview:self.player.view];
}

#pragma mark - selector

- (void)clickTitleButton:(UIButton *)sender
{
    if (!self.showPopover) {
        VideoInfo *videoInfo = [[VideoInfo alloc] init];
        
        self.showPopover = [[UIPopoverController alloc] initWithContentViewController:videoInfo];
        [self.showPopover setPopoverContentSize:CGSizeMake(400, 270)];
        [self.showPopover presentPopoverFromBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:sender]
                                 permittedArrowDirections:UIPopoverArrowDirectionAny
                                                 animated:YES];        
    }
    else {
        // 當 popover 已經顯示把它關閉
        [self.showPopover dismissPopoverAnimated:YES];
        self.showPopover = nil;
    }
}

#pragma mark - lazy instantiation

- (MPMoviePlayerController *)player
{
    if (!_player) {
        _player = [[MPMoviePlayerController alloc] init];
        
        _player.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        _player.controlStyle = MPMovieControlStyleDefault;
    }
    return _player;
}

#pragma mark - delegate

- (void)didDismissModalView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)playURL:(NSURL *)fileURL
{    
    if (self.player.playbackState == MPMoviePlaybackStatePlaying) {
        [self.player stop];
    }

    self.player.contentURL = fileURL;
    [self.player prepareToPlay];
    [self.player play];
}

- (void)setViewTitle:(NSString *)title
{
    self.titleButton.enabled = YES;
    [self.titleButton setTitle:title forState:UIControlStateNormal];
    [self.titleButton sizeToFit];
}

#pragma mark - IBAction

- (IBAction)clickMovieList:(UIBarButtonItem *)sender
{     
    if (self.videoTypeSegment.selectedSegmentIndex == 0) {
        // 本地端        
        L_menuTVC *l_menuTVC = [[L_menuTVC alloc] initWithStyle:UITableViewStyleGrouped];
        l_menuTVC.delegate = self;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:l_menuTVC];
        navController.modalPresentationStyle = UIModalPresentationFormSheet;
        
        [self presentViewController:navController animated:YES completion:nil];
    }
    else {
        // 網路串流
        S_menuTVC *s_menuTVC = [[S_menuTVC alloc] initWithStyle:UITableViewStyleGrouped];
        s_menuTVC.delegate = self;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:s_menuTVC];
        navController.modalPresentationStyle = UIModalPresentationFormSheet;
        
        [self presentViewController:navController animated:YES completion:nil];        
    }
}

- (IBAction)changeChannel:(UISegmentedControl *)sender
{
    // 設定 Segment 所選擇的顏色
    for (int i = 0; i < [self.videoTypeSegment.subviews count]; i++) {
        [[self.videoTypeSegment.subviews objectAtIndex:i] setTintColor:nil];
        if ([[self.videoTypeSegment.subviews objectAtIndex:i] isSelected]) {
            // 設定選擇的顏色
            [[self.videoTypeSegment.subviews objectAtIndex:i] setTintColor:[UIColor colorWithRed:0.078 green:0.682 blue:0.851 alpha:1.0]];            
        }
        else {
            // 設定回原本的顏色
            //[[self.videoTypeSegment.subviews objectAtIndex:i] setTintColor:[UIColor grayColor]];
        }
    }
}

@end