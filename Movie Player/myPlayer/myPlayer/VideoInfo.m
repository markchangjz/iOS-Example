//
//  VideoInfo.m
//  myPlayer
//
//  Created by JzChang on 13/1/11.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "VideoInfo.h"

@interface VideoInfo ()

@property (strong, nonatomic) UIView *nameView;
@property (strong, nonatomic) UILabel *nameLbl;
@property (strong, nonatomic) UIView *durationView;
@property (strong, nonatomic) UILabel *durationLbl;

@end

@implementation VideoInfo

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    [self.view addSubview:self.nameView];
    [self.nameView addSubview:self.nameLbl];
    
    [self.view addSubview:self.durationView];
    [self.durationView addSubview:self.durationLbl];
}

- (void)videoName:(NSString *)name andDuration:(NSString *)duration
{
    self.nameLbl.text = [NSString stringWithFormat:@"檔名：%@", name];
    self.durationLbl.text = [NSString stringWithFormat:@"片長：%@", duration];
}

#pragma mark - lazy instantiation

- (UIView *)nameView
{
    if (!_nameView) {
        _nameView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 360, 50)];
        _nameView.backgroundColor = [UIColor whiteColor];
    }
    return _nameView;
}

- (UIView *)durationView
{
    if (!_durationView) {
        _durationView = [[UIView alloc] initWithFrame:CGRectMake(20, 78, 360, 50)];
        _durationView.backgroundColor = [UIColor whiteColor];
    }
    return _durationView;
}

- (UILabel *)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 40)];
    }
    return _nameLbl;
}

- (UILabel *)durationLbl
{
    if (!_durationLbl) {
        _durationLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 40)];
    }
    return _durationLbl;
}

@end
