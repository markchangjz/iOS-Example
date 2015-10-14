//
//  A_ViewController.m
//  Localized
//
//  Created by JzChang on 13/1/18.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

/* 
 STEP 1.
 點選專案 -> PROJECT(專案名稱) -> Info -> Localizations -> 點選"+"加入語言 -> Chinese
 會在目錄下新增 zh-Hant.lproj 資料夾
 
 STEP 2.
 參考網址:http://furnacedigital.blogspot.tw/2011/08/nsstring.html
 開啟 "終端機" 程式, 切換到專案有 .h .m 的目錄下
 輸入 genstrings -o en.lproj *.m (英文)
 輸入 genstrings -o zh-Hant.lproj *.m (中文)
 會在 en.lproj 和 zh-Hant.lproj 兩個資料夾內產生 Localizable.strings
 並將這兩個 Localizable.strings 拉到專案裡
 
 STEP 3.
 修改 APP 名稱, 在 InfoPlist.strings 加入
 "CFBundleDisplayName" = "(系統語言)";
 */

#import "A_ViewController.h"

@interface A_ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *pushButton;

@end

@implementation A_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"畫面 A", @"View A");
    [self.pushButton setTitle:NSLocalizedString(@"推入", @"PUSH") forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
