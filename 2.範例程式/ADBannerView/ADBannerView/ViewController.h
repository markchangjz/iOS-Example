//
//  ViewController.h
//  ADBannerView
//
//  Created by JzChang on 12/12/13.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController <ADBannerViewDelegate> {
    ADBannerView *bannerView;
}
- (IBAction)onButtonPress:(id)sender;

@end
