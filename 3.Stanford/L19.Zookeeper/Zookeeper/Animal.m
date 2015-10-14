//
//  Animal.m
//  Zookeeper
//
//  Created by JzChang on 12/12/24.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "Animal.h"
#import "PlistHelper.h"
#import "Salutation.h"

@interface Animal () <SalutationDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *SalutationLabel;

@end

@implementation Animal
@synthesize SalutationLabel;
@synthesize firstNameText;
@synthesize lastNameText;
@synthesize showSelectData = _showSelectData; // 在 Zoo 點選的資料

id prevNavigationBarDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // (建立 back 形狀按鈕) create button
    UIButton *backButton = [UIButton buttonWithType:101]; // left-pointing shape!
    [backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    
    // (將自己建立的按鈕 封裝到 BarButtonItem) create button item -- possible because UIButton subclasses UIView!
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backButton];    
    // 放到 navigation 左手邊按鈕
    [[self navigationItem] setLeftBarButtonItem:item]; 
    
    if (self.showSelectData) { // 有在 Table View 點選資料才顯示資料
        NSDictionary *popData = [self.showSelectData objectForKey:[[self.showSelectData allKeys] objectAtIndex:0]];
        SalutationLabel.text = [popData objectForKey:@"salutation"];
        firstNameText.text = [popData objectForKey:@"firstName"];
        lastNameText.text = [popData objectForKey:@"lastName"];
    }    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ %@", firstNameText.text, lastNameText.text];
    
    // 當修改 firstNameText 或 lastNameText 就修改 title
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeTitle:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{   
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // (按下BACK鍵才觸發)back button was pressed.  We know this is true because self is no longer in the navigation stack.
        
        NSString *plistPath = [PlistHelper plistFilePath]; // plist 路徑
        
        if (!self.showSelectData) { // 新增資料
            if (![firstNameText.text isEqualToString:@""] && ![lastNameText.text isEqualToString:@""]) {
                NSTimeInterval startTime = [NSDate timeIntervalSinceReferenceDate];
                NSString *dataKey = [NSString stringWithFormat:@"%f", startTime];
                NSDictionary *storeValue = [[NSDictionary alloc] initWithObjectsAndKeys:SalutationLabel.text, @"salutation", firstNameText.text, @"firstName", lastNameText.text, @"lastName", nil];
                NSMutableDictionary *storeData = [[NSMutableDictionary alloc] init];
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
                    NSMutableDictionary *readStoreData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath]; // 讀取plist
                    [[NSFileManager defaultManager] removeItemAtPath:plistPath error:nil]; // 刪除舊的plist
                    [readStoreData setObject:storeValue forKey:dataKey];
                    [readStoreData writeToFile:plistPath atomically:YES];
                }
                else {
                    [storeData setObject:storeValue forKey:dataKey];
                    [storeData writeToFile:plistPath atomically:YES];
                }
            }
        }
        else { // 修改資料
            if (![firstNameText.text isEqualToString:@""] && ![lastNameText.text isEqualToString:@""]) {
                NSString *editKey = [[self.showSelectData allKeys] objectAtIndex:0];                
                NSMutableDictionary *readStoreData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath]; // 讀取plist
            
                [[NSFileManager defaultManager] removeItemAtPath:plistPath error:nil]; // 刪除舊的plist
            
                [[readStoreData objectForKey:editKey] setObject:SalutationLabel.text forKey:@"salutation"];
                [[readStoreData objectForKey:editKey] setObject:firstNameText.text forKey:@"firstName"];
                [[readStoreData objectForKey:editKey] setObject:lastNameText.text forKey:@"lastName"];
            
                [readStoreData writeToFile:plistPath atomically:YES];
            }
        }
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewWillDisappear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Select Salutation Segue"]) {
        Salutation *salutation = (Salutation *)segue.destinationViewController;
        salutation.selectSalutation = SalutationLabel.text;
        salutation.delegate = self;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - 實作 SalutationDelegate 的 protocol

- (void)salutationTVC:(Salutation *)sender setSalutation:(NSString *)selectalutation
{
    SalutationLabel.text = selectalutation;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0: // 按下"取消"
            [self.navigationController popViewControllerAnimated:YES]; // 手動執行 Back
            break;
        default:
            break;
    }
}

#pragma mark - target-action

- (void)backButtonPressed
{
    if ([firstNameText.text isEqualToString:@""] || [lastNameText.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"尚未輸入First 或 Last Name 欄位"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"取消", @"好" ,nil];
        [alert show];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES]; // 手動執行 Back
    }
}

#pragma mark - selector

- (void)changeTitle:(NSNotification *)notification
{
    self.navigationItem.title = [NSString stringWithFormat:@"%@ %@", firstNameText.text, lastNameText.text];
}

@end
