//
//  RSSParser.h
//  RSSReader
//
//  Created by JzChang on 13/2/23.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {tagTitle, tagLink, tagDescription, tagPubDate, tagUnknown} RSSTag;

@protocol RSSdelegate <NSObject>

- (void)xmlParserEnd;

@end

@interface RSSParser : NSObject <NSXMLParserDelegate> {
    NSMutableDictionary *item;
    RSSTag currentTag;
    BOOL startItem;
    NSString *nodeContent;
}

@property (nonatomic, retain) NSMutableArray *result;
@property (weak) id <RSSdelegate> delegate;

- (void)initParserURL:(NSString *)url;

@end
