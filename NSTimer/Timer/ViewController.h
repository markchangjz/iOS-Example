//
//  ViewController.h
//  Timer
//
//  Created by JzChang on 12/9/16.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSTimer *myTimer;
    BOOL pause;
    int data;
}
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UIButton *ctrlBtn;
- (IBAction)StartAndPause:(UIButton *)sender;

@end
