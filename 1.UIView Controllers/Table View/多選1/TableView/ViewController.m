//
//  ViewController.m
//  TableView
//
//  Created by JzChang on 13/2/8.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

/*
 參考網址:http://stackoverflow.com/questions/6315269/tableview-cell-reuse-and-unwanted-checkmarks-this-is-killing-me
 */

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *items;

@end

NSMutableArray *stateArray, *selectArray;

@implementation ViewController

int count = 0;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.tableView.allowsMultipleSelection = YES;
    
    selectArray = [[NSMutableArray alloc] init];
    
    stateArray = [[NSMutableArray alloc] init];
    
    // YES:已選擇, NO:未選擇
    for (int i = 0 ; i < self.items.count; i++) {
        [stateArray addObject:[NSNumber numberWithBool:NO]];
    }
}

- (NSMutableArray *)items
{
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
        
        for (int i = 'A'; i <= 'Z'; i++) {
            [_items addObject:[NSString stringWithFormat:@"%c", i]];
        }
    }
    return _items;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if([[stateArray objectAtIndex:indexPath.row] boolValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // Configure the cell.
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %@", [self.items objectAtIndex:indexPath.row]];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.navigationItem.title = [self.items objectAtIndex:indexPath.row];
    
    if ([[stateArray objectAtIndex:indexPath.row] boolValue]) {
        [selectArray removeObject:[self.items objectAtIndex:indexPath.row]];
    }
    else {
        [selectArray addObject:[self.items objectAtIndex:indexPath.row]];
    }
    
    [stateArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:![[stateArray objectAtIndex:indexPath.row] boolValue]]];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    NSLog(@"%@", selectArray);
}

@end
