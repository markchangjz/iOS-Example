//
//  Photo+Flickr.h
//  Photomania
//
//  Created by JzChang on 12/12/16.
//  Copyright (c) 2012年 JzChang. All rights reserved.
//

#import "Photo.h"

@interface Photo (Flickr)

+ (Photo *)photoWithFlickrInfo:(NSDictionary *)flickrInfo
        inManagedObjectContext:(NSManagedObjectContext *)context;

@end
