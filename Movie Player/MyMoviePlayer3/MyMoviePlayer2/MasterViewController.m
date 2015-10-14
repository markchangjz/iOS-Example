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
@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];    
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.delegate = self.detailViewController;   
    
    movies = [[NSDictionary alloc] initWithObjectsAndKeys:@"sophie.mov", @"影片1", nil];
    
    images = [[NSMutableDictionary alloc] init];    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
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
    NSString *CellID = @"Local Cell";
    
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
        UIImage *image = [controller thumbnailImageAtTime:5.0f timeOption:MPMovieTimeOptionNearestKeyFrame];
        
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
    NSString *movieURLString = [movies objectForKey:key];
    NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:movieURLString];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    [self.delegate playURL:url];
    [self.delegate dataTitle:key];
}

@end
