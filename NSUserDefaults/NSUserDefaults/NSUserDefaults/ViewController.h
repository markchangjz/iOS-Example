//
//  ViewController.h
//  NSUserDefaults
//
//  Created by JzChang on 12/9/27.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)ClickBtn:(UIButton *)sender;
- (IBAction)State1Switched:(UISwitch *)sender;
- (IBAction)State2Switched:(UISwitch *)sender;
- (IBAction)State3Switched:(UISwitch *)sender;

@property (weak, nonatomic) IBOutlet UITextField *TxtField;
@property (weak, nonatomic) IBOutlet UISwitch *State1Switch;
@property (weak, nonatomic) IBOutlet UISwitch *State2Switch;
@property (weak, nonatomic) IBOutlet UISwitch *State3Switch;

@end
