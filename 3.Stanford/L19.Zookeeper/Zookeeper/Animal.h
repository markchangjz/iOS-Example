//
//  Animal.h
//  Zookeeper
//
//  Created by JzChang on 12/12/24.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Animal : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *firstNameText;
@property (weak, nonatomic) IBOutlet UITextField *lastNameText;
@property (strong, nonatomic) NSDictionary *showSelectData;

@end
