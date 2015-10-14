//
//  AskerViewController.m
//  Kitchen Sink
//
//  Created by JzChang on 12/12/20.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "AskerViewController.h"

@interface AskerViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;

@end

@implementation AskerViewController

@synthesize questionLabel = _questionLabel;
@synthesize answerTextField = _answerTextField;
@synthesize question = _question;
@synthesize answer = _answer;
@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.questionLabel.text = self.question;
    self.answerTextField.placeholder = self.answer;
    self.answerTextField.delegate = self; // set delegate!
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.answerTextField becomeFirstResponder]; // 顯示鍵盤
}

- (void)setQuestion:(NSString *)question
{
    _question = question;
    self.questionLabel.text = question;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)viewDidUnload
{
    [self setQuestionLabel:nil];
    [self setAnswerTextField:nil];
    [super viewDidUnload];
}

#pragma mark - UITextFieldDelegate

// 實作 UITextFieldDelegate 的 protocol
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.answer = textField.text;
    
    if (![textField.text length]) {
        // 使用者沒輸入資料就 dismiss (自己呼叫)
        [[self presentingViewController] dismissModalViewControllerAnimated:YES];
    }
    else {
        // need to commnuicate! 使用 protocol
        [self.delegate askerViewController:self didAskQuestion:self.question andGotAnswer:self.answer];        
    }
}

// 實作 UITextFieldDelegate 的 protocol
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text length]) {
        [textField resignFirstResponder]; // 關閉鍵盤, 並呼叫 - (void)textFieldDidEndEditing:(UITextField *)textField
        return YES; 
    }
    else {
        return NO; // 不讓 return work
    }
}


@end
