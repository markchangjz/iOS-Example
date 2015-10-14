//
//  ViewController.m
//  Keyboard
//
//  Created by JzChang on 13/2/8.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIToolbar *toolbar;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 50, 30)];
    self.textField.center = CGPointMake(self.view.center.x, 50);
    [self.textField setPlaceholder:@"請輸入資料"];
    [self.textField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.textField setReturnKeyType:UIReturnKeyGo];    // 設定鍵盤的 Return 鍵
    [self.textField setBorderStyle:UITextBorderStyleRoundedRect];
    
    self.textField.delegate = self;
    [self.textField becomeFirstResponder];              // 讓鍵盤出現
    self.textField.inputAccessoryView = self.toolbar;   // 在鍵盤上面加上toolbar
    
    [self.view addSubview:self.textField];
}

- (UIToolbar *)toolbar
{
    if (!_toolbar) {
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        _toolbar.tintColor = [UIColor darkGrayColor];
        
        UIBarButtonItem *clearBtn = [[UIBarButtonItem alloc] initWithTitle:@"Clear"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(clearText)];
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(leaveKeyboard)];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                       target:nil
                                                                                       action:nil];
        _toolbar.items = @[clearBtn, flexibleSpace, doneBtn];        
    }
    return _toolbar;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    return YES;
}

#pragma mark - selector

- (void)clearText
{
    self.textField.text = @"";
}

- (void)leaveKeyboard
{
    [self.textField resignFirstResponder];
}

@end
