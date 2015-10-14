//
//  ImageViewController.m
//
//  Created by CS193p Instructor.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//

#import "ImageViewController.h"
#import <dispatch/dispatch.h>

@interface ImageViewController()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation ImageViewController

@synthesize scrollView = _scrollView;
@synthesize imageURL = _imageURL;
@synthesize imageView = _imageView;
@synthesize detailViewPhotoTitle = _detailViewPhotoTitle;
bool isLoading = false;
dispatch_queue_t loadImageQ;

UIActivityIndicatorView *spinner;

- (void)setDetailViewPhotoTitle:(NSString *)detailViewPhotoTitle
{
    _detailViewPhotoTitle = detailViewPhotoTitle;
    self.title = _detailViewPhotoTitle;
}

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self.imageView removeFromSuperview];
        [self viewWillAppear:YES];
    }
}

- (void)showLoadingIndicator
{   
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    [spinner startAnimating];
    [self.view addSubview:spinner];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)loadImage
{
    if (!isLoading) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"startLoading" object:nil];
        isLoading = true;
        
        [self showLoadingIndicator];
        
        loadImageQ = dispatch_queue_create("Load Image", NULL);
        dispatch_async(loadImageQ, ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView = [[UIImageView alloc] initWithImage:image];
                self.scrollView.contentSize = self.imageView.frame.size;
                [self.scrollView addSubview:self.imageView];
                [spinner removeFromSuperview];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"stopLoading" object:nil];
                isLoading = false;
            });
        });
        
        dispatch_release(loadImageQ);
    }
}

- (void)viewWillAppear:(BOOL)animated
{    
    [super viewWillAppear:animated];
    self.splitViewController.delegate = self;
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 0.2f;
    self.scrollView.maximumZoomScale = 5.0f;
    
    if (self.imageURL) {
        [self loadImage];
    }    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{    
    spinner.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    return YES;
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = @"MENU";
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
}

@end
