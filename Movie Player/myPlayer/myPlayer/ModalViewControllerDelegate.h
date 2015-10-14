//
//  ModalViewControllerDelegate.h
//  myPlayer
//
//  Created by JzChang on 13/1/4.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModalViewControllerDelegate <NSObject>

@required
- (void)didDismissModalView;
@optional
- (void)playURL:(NSURL *)fileURL;
- (void)setViewTitle:(NSString *)title;

@end
