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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath]; // ask NSFRC for the NSMO at the row in question
    if ([segue.identifier isEqualToString:@"Show Photo"]) {
        [segue.destinationViewController setImageURL:[NSURL URLWithString:photo.imageURL]];
        [segue.destinationViewController setTitle:photo.title];
    }
}

@end
