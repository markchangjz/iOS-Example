//
//  L_menuTVC.m
//  myPlayer
//
//  Created by JzChang on 13/1/4.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "L_menuTVC.h"
#import <MediaPlayer/MediaPlayer.h>

@interface L_menuTVC ()

@property (strong, nonatomic) NSIndexPath *checkedCell; // 設定 Checkmark
@property (strong, nonatomic) NSDictionary *movies;
@property (weak, nonatomic) NSString *selectMovie;

@end

@implementation L_menuTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.movies = [[NSDictionary alloc] initWithObjectsAndKeys:@"sophie.mov", @"sophie", nil];

    [self setupView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

#pragma mark - code

- (void)setupView
{
    self.navigationItem.title = @"本地端";
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(clickCnacel)];
    
    UIBarButtonItem *finishBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(clickFinish)];
    
    self.navigationItem.leftBarButtonItem = cancelBtn;
    self.navigationItem.rightBarButtonItem = finishBtn;
    
    self.tableView.rowHeight = 60; // 設定 Table View 每個 Cell 的高度
}

#pragma mark - selector

- (void)clickCnacel
{
    [self.delegate didDismissModalView];
}

- (void)clickFinish
{
    if (self.selectMovie) {        
        NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:self.selectMovie];
        NSURL *url = [NSURL fileURLWithPath:filePath];
        [self.delegate playURL:url];
        [self.delegate setViewTitle:self.selectMovie];
    }    
    
    [self.delegate didDismissModalView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.movies allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil]; // 要修正成自己 alloc init
        
    NSString *key = [[self.movies allKeys] objectAtIndex:indexPath.row];
    NSString *movieURLString = [self.movies objectForKey:key];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Video %d ", indexPath.row + 1];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.text = movieURLString;
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:18];    
    
    // 設定 Checkmark
    if (self.checkedCell != nil && self.checkedCell.row == indexPath.row && self.checkedCell.section == indexPath.section) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 設定 Checkmark
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.checkedCell != nil) { // Uncheck previously selected cell
        UITableViewCell *prevSelectedCell = [tableView cellForRowAtIndexPath:self.checkedCell];
        prevSelectedCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.checkedCell = indexPath;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    self.selectMovie = [self.movies objectForKey:[[self.movies allKeys] objectAtIndex:indexPath.row]];   
}

@end
