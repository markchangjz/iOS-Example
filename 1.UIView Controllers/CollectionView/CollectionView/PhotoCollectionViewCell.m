//
//  PhotoCollectionViewCell.m
//  CollectionView
//
//  Created by JzChang on 13/11/9.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5.0, 8.0, 90.0, 72.0)];
        [self addSubview:self.photoImageView];
        
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo-frame.png"]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{

}

@end
