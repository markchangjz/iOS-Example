//
//  CustomCell.h
//  TableView
//
//  Created by JzChang on 13/2/8.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *myTitle;
@property (weak, nonatomic) IBOutlet UIImageView *myImage;

@end
