//
//  RSSParser.m
//  RSSReader
//
//  Created by JzChang on 13/2/23.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "RSSParser.h"

@implementation RSSParser

- (void)initParserURL:(NSString *)url
{
    nodeContent = @"";
    self.result = [[NSMutableArray alloc] init];   
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    
    [parser parse];
}

#pragma mark - NSXMLParserDelegate
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{     
    if (startItem) {
        if ([elementName isEqualToString:@"title"]) {
            currentTag = tagTitle;
        }
        else if ([elementName isEqualToString:@"link"]) {
            currentTag = tagLink;
        }
        else if ([elementName isEqualToString:@"description"]) {
            currentTag = tagDescription;
        }
        else if ([elementName isEqualToString:@"pubDate"]) {
            currentTag = tagPubDate;
        }
        else {
            currentTag = tagUnknown;
        }
    }
    
    if ([elementName isEqualToString:@"item"]) {
        startItem = YES;
        item = [[NSMutableDictionary alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"item"]) {
        startItem = NO;
        [self.result addObject:item];
    }
    
    if (startItem && currentTag != tagUnknown) {        
        [item setValue:nodeContent forKey:elementName];
        nodeContent = @"";
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{    
    if (currentTag == tagUnknown || !startItem) {        
        return;
    }
    
    nodeContent = [nodeContent stringByAppendingString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    // Parser Start
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    // Parser End
    [self.delegate xmlParserEnd];
}

@end
