//
//  PhotosByPhotographerTableViewController.h
//  Photomania
//
//  Created by JzChang on 12/12/16.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photographer.h"
#import "CoreDataTableViewController.h"
#import "ImageViewController.h"

@interface PhotosByPhotographerTableViewController : CoreDataTableViewController

@property (nonatomic, strong) Photographer *photographer;

@end
