//
//  PageViewController.m
//  Novel
//
//  Created by EE Lab on 12/7/4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PageViewController.h"
#import "DatabaseHelper.h"

@interface PageViewController ()

@end

@implementation PageViewController
@synthesize bookID;
@synthesize bookTitle;

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
	// Do any additional setup after loading the view.
    
    self.delegate = self;

    self.title = self.bookTitle;
    
    modelController = [ModelController new];
    self.dataSource = modelController;
    
    ContentViewController *contentController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
    contentController.bookID = self.bookID;
    
    [self setViewControllers:[NSArray arrayWithObject:contentController] direction:UIPageViewControllerNavigationOrientationHorizontal animated:YES completion:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{    
    // 若使用者放棄翻頁 
    if (!completed) {
        // 恢復原有標題
        ContentViewController *contentController = [previousViewControllers objectAtIndex:0];
        DatabaseHelper *helper = [DatabaseHelper new];
        self.title = [helper titleForIndex:contentController.bookID];
    }    
}

@end
