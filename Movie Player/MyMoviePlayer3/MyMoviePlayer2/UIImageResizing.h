//
//  UIImageResizing.h
//  MyMoviePlayer2
//
//  Created by JzChang on 12/10/15.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImageResizing : NSObject

/*
 參考網址：http://stackoverflow.com/questions/2658738/the-simplest-way-to-resize-an-uiimage
 使用 [UIImageResizing imageWithImage:image scaledToSize:CGSizeMake(70, 40)];
 調整影像大小
 */

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
