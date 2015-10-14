//
//  PhotosByPhotographerTableViewController.m
//  Photomania
//
//  Created by JzChang on 12/12/16.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "PhotosByPhotographerTableViewController.h"
#import "Photo.h"

@interface PhotosByPhotographerTableViewController ()

@end

@implementation PhotosByPhotographerTableViewController

@synthesize photographer = _photographer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cannotSelect:) name:@"startLoading" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(canSelect:) name:@"stopLoading" object:nil];
}

- (void)setupFetchedResultsController
{
    // self.fetchedResultsController = ...
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    request.predicate = [NSPredicate predicateWithFormat:@"whoTook.name = %@", self.photographer.name];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.photographer.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

- (void)setPhotographer:(Photographer *)photographer
{
    _photographer = photographer;
    self.title = photographer.name;
    [self setupFetchedResultsController];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Photo Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = photo.title;
    cell.detailTextLabel.text = photo.subtitle;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // iPad 使用
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
        // 取得detail view
        ImageViewController *detailViewController = (ImageViewController *)[[[self.splitViewController viewControllers] lastObject] topViewController];
        [detailViewController setDetailViewPhotoTitle:photo.title];
        [detailViewController setImageURL:[NSURL URLWithString:photo.imageURL]];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // iPhone 使用
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath]; // ask NSFRC for the NSMO at the row in question
    if ([segue.identifier isEqualToString:@"Show Photo"]) {
        [segue.destinationViewController setImageURL:[NSURL URLWithString:photo.imageURL]];
        [segue.destinationViewController setTitle:photo.title];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)cannotSelect:(NSNotification *)notification
{
    self.tableView.allowsSelection = NO;
}

- (void)canSelect:(NSNotification *)notification
{
    self.tableView.allowsSelection = YES;
}

@end
