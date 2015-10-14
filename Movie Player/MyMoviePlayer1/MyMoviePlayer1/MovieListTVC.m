//
//  MovieListTVC.m
//  MyMoviePlayer1
//
//  Created by JzChang on 12/10/15.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "MovieListTVC.h"

@interface MovieListTVC ()

@end

@implementation MovieListTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"影片清單";
    movies = [[NSDictionary alloc] initWithObjectsAndKeys:@"sophie.mov", @"影片1", nil];
    moviesHTTP = [[NSDictionary alloc] initWithObjectsAndKeys:@"http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8", @"影片1", @"http://192.168.0.100/movie/iPad.mp4", @"影片2", nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[movies allKeys] count];
//    return [[moviesHTTP allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Movie Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *key = [[movies allKeys] objectAtIndex:indexPath.row];
    NSString *value = [movies objectForKey:key];
    
//    NSString *key = [[moviesHTTP allKeys] objectAtIndex:indexPath.row];
//    NSString *value = [moviesHTTP objectForKey:key];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ -> %@", key, value];    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [[movies allKeys] objectAtIndex:indexPath.row];
    NSString *movieURLString = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[movies objectForKey:key]];    
    NSURL *url = [NSURL fileURLWithPath:movieURLString];
    
//    NSString *key = [[moviesHTTP allKeys] objectAtIndex:indexPath.row];
//    NSString *movieURLString = [moviesHTTP objectForKey:key];
//    NSURL *url = [NSURL URLWithString:movieURLString];
    
    MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self presentMoviePlayerViewControllerAnimated:player];
}

@end
