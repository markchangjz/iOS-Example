//
//  ViewController.m
//  PageView
//
//  Created by JzChang on 12/12/13.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize pageControl, scrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
    
    //UIPageControl設定
    [pageControl setCenter:CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height / 2) + 50)];
    [pageControl setNumberOfPages:5];
    [pageControl setCurrentPage:0];
    [pageControl addTarget:self action:@selector(changeCurrentPage:) forControlEvents:UIControlEventValueChanged];    
    
    //UIScrollView設定
    [scrollView setCenter:CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height / 2) - 50)];
    [scrollView setPagingEnabled:YES];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setScrollsToTop:NO];
    [scrollView setDelegate:self];    
    
    CGFloat width, height;
    width = scrollView.frame.size.width;
    height = scrollView.frame.size.height;    
    [scrollView setContentSize:CGSizeMake(width * 5, height)];
    
    //製作ScrollView的內容
    for (int i=0; i!=pageControl.numberOfPages; i++) {
        CGRect frame = CGRectMake(width*i, 0, width, height);
        UIView *view = [[UIView alloc] initWithFrame:frame];
        
        CGFloat r, g ,b;
        r = (arc4random() % 10) / 10.0;
        g = (arc4random() % 10) / 10.0;
        b = (arc4random() % 10) / 10.0;
        [view setBackgroundColor:[UIColor colorWithRed:r green:g blue:b alpha:0.3]];
        
        //使用QuartzCore.framework替UIView加上圓角
        [view.layer setCornerRadius:15.0];
        
        [scrollView addSubview:view];
    }
    
    [self.view addSubview:pageControl];
    [self.view addSubview:scrollView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

// 透過 UIScrollView 來設定 UIPageControl 的狀態
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width; // 200
    NSInteger currentPage = scrollView.contentOffset.x  / width;
    [pageControl setCurrentPage:currentPage];
}

// 透過 UIPageControl 來設定 UIScrollView 的狀態
- (void)changeCurrentPage:(UIPageControl *)sender
{
    NSInteger page = pageControl.currentPage;
    
    CGFloat width, height;
    width = scrollView.frame.size.width;
    height = scrollView.frame.size.height;
    CGRect frame = CGRectMake(width*page, 0, width, height);
    
    [scrollView scrollRectToVisible:frame animated:YES];
}

@end
