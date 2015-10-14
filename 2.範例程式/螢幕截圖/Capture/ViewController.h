//
//  ViewController.h
//  Capture
//
//  Created by JzChang on 13/1/24.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)clickCapture:(UIBarButtonItem *)sender;
- (IBAction)clickClean:(UIBarButtonItem *)sender;

@end
