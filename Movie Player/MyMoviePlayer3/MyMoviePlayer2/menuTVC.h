//
//  menuTVC.h
//  MyMoviePlayer2
//
//  Created by JzChang on 12/10/18.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewDelegate.h"

@interface menuTVC : UITableViewController
@property (nonatomic, weak) id <DetailViewDelegate> delegate;
@end
