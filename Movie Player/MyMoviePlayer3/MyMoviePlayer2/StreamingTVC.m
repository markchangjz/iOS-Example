//
//  StreamingTVC.m
//  MyMoviePlayer2
//
//  Created by JzChang on 12/10/23.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "StreamingTVC.h"

@interface StreamingTVC ()

@end

@implementation StreamingTVC

@synthesize movies;
@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.delegate = self.detailViewController;
    
    NSArray *dictObjs = [[NSArray alloc] initWithObjects:@"http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8",
                                                         @"http://140.118.7.9/movie/a.mp4",
                                                         @"http://192.168.70.1/movie/2012101.mp4",
                                                         nil];
    NSArray *dictKey = [[NSArray alloc] initWithObjects:@"串流1: 使用m3u8", @"串流2: 使用實體IP", @"串流3: 使用區域網路", nil];
        
    movies = [[NSDictionary alloc] initWithObjects:dictObjs forKeys:dictKey];

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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Stream Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *key = [[[movies allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = key;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [[[movies allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)] objectAtIndex:indexPath.row];
    NSURL *urlPath = [NSURL URLWithString:[movies objectForKey:key]];    
    
    [self.delegate playURL:urlPath];
    [self.delegate dataTitle:key];    
}

@end
