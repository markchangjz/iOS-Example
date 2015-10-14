//
//  MasterViewController.m
//  MyMoviePlayer2
//
//  Created by JzChang on 12/10/15.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "UIImageResizing.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

@synthesize movies;
@synthesize images;
@synthesize player;

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];}

- (void)viewDidLoad
{
    [super viewDidLoad];   
    
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    movies = [[NSDictionary alloc] initWithObjectsAndKeys:@"sophie.mov", @"影片1", nil];
    
    images = [[NSMutableDictionary alloc] init];
    

    player = [[MPMoviePlayerController alloc] init];
    player.shouldAutoplay = YES;
    player.controlStyle = MPMovieControlStyleEmbedded;

    
    CGRect rect = self.detailViewController.view.bounds;
    player.view.frame = rect;
    [self.detailViewController.view addSubview:player.view];    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    player.view.frame = CGRectMake(0, 0, self.detailViewController.view.frame.size.width, self.detailViewController.view.frame.size.height);
    return YES;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[movies allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellID = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    
    NSString *key = [[movies allKeys] objectAtIndex:indexPath.row];
    NSString *movieURLString = [movies objectForKey:key];
    NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:movieURLString];
    NSURL *url = [NSURL fileURLWithPath:filePath];

    if ([images objectForKey:url] == nil) {
        
        MPMoviePlayerController *controller = [[MPMoviePlayerController alloc] initWithContentURL:url];
        UIImage *image = [controller thumbnailImageAtTime:3.0f timeOption:MPMovieTimeOptionNearestKeyFrame];
        
        image = [UIImageResizing imageWithImage:image scaledToSize:CGSizeMake(70, 50)];
        
        cell.imageView.image = image;
        if (images != nil) {
            [images setObject:image forKey:url];
        }
    }
    
    cell.textLabel.text = key;
    cell.detailTextLabel.text = [movies objectForKey:key];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [[movies allKeys] objectAtIndex:indexPath.row];
    
    if (player.playbackState == MPMoviePlaybackStatePlaying) {
        [player stop];
    }
    
    NSString *movieURLString = [movies objectForKey:key];
    NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:movieURLString];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    player.contentURL = url;
    [player prepareToPlay];
    [player play];
    self.detailViewController.title = key;
}

@end
